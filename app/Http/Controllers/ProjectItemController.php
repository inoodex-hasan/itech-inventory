<?php

namespace App\Http\Controllers;

use App\Models\Product;
use App\Models\Project;
use App\Models\ProjectItem;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ProjectItemController extends Controller
{
    /**
     * Display all project items
     */
    public function index()
    {
        $projectItems = ProjectItem::with(['project', 'product'])
            ->latest()
            ->paginate(10);
            
        return view('frontend.pages.project-items.index', compact('projectItems'));
    }

    /**
     * Show form to create new project item
     */
    public function create()
    {
        $projects = Project::where('status', '!=', 'completed')->get();
        $products = Product::with(['inventory'])->get();
        
        return view('frontend.pages.project-items.create', compact('projects', 'products'));
    }

    /**
     * Store new project item
     */

    public function store(Request $request)
{
    \Log::info('Store request data:', $request->all());
    
    // Validate the request
    $validated = $request->validate([
        'project_id' => 'required|exists:projects,id',
        'items' => 'required|array|min:1',
        'items.*.product_id' => 'required|exists:products,id',
        'items.*.unit_price' => 'required|numeric|min:0',
        'items.*.quantity' => 'required|integer|min:1',
        'items.*.total_price' => 'required|numeric|min:0',
    ]);

    DB::beginTransaction();

    try {
        $projectId = $request->project_id;
        $itemsAdded = 0;
        $itemsUpdated = 0;

        foreach ($request->items as $itemData) {
            $productId = $itemData['product_id'];
            $unitPrice = $itemData['unit_price'];
            $quantity = $itemData['quantity'];
            
            // Check if item already exists with same product_id and unit_price
            $existingItem = ProjectItem::where('project_id', $projectId)
                ->where('product_id', $productId)
                ->where('unit_price', $unitPrice)
                ->first();

            if ($existingItem) {
                // Update existing item - increase quantity
                $newQuantity = $existingItem->quantity + $quantity;
                $newTotal = $existingItem->unit_price * $newQuantity;
                
                $existingItem->update([
                    'quantity' => $newQuantity,
                    'total_price' => $newTotal
                ]);
                
                $itemsUpdated++;
                
                \Log::info("Updated existing item - Product: {$productId}, New Quantity: {$newQuantity}");
            } else {
                // Create new item
                ProjectItem::create([
                    'project_id' => $projectId,
                    'product_id' => $productId,
                    'unit_price' => $unitPrice,
                    'quantity' => $quantity,
                    'total_price' => $itemData['total_price'],
                ]);
                
                $itemsAdded++;
            }
        }

        // Recalculate project grand total
        $this->recalculateProjectGrandTotal($projectId);

        DB::commit();

        $message = "Project items processed successfully. ";
        if ($itemsAdded > 0) {
            $message .= "{$itemsAdded} new item(s) added. ";
        }
        if ($itemsUpdated > 0) {
            $message .= "{$itemsUpdated} existing item(s) updated.";
        }

        return redirect()->route('project-items.index')
            ->with('success', $message);

    } catch (\Exception $e) {
        DB::rollBack();
        \Log::error('Error storing project items: ' . $e->getMessage());
        
        return redirect()->back()
            ->withInput()
            ->with('error', 'Error adding project items: ' . $e->getMessage());
    }
}

// public function store(Request $request)
// {
//     \Log::info('Store request data:', $request->all());
    
//     // Validate the request
//     $validated = $request->validate([
//         'project_id' => 'required|exists:projects,id',
//         'items' => 'required|array|min:1',
//         'items.*.product_id' => 'required|exists:products,id',
//         'items.*.unit_price' => 'required|numeric|min:0',
//         'items.*.quantity' => 'required|integer|min:1',
//         'items.*.total_price' => 'required|numeric|min:0',
//     ]);

//     DB::beginTransaction();

//     try {
//         $projectId = $request->project_id;

//         // Create project items
//         foreach ($request->items as $itemData) {
//             ProjectItem::create([
//                 'project_id' => $projectId,
//                 'product_id' => $itemData['product_id'],
//                 'unit_price' => $itemData['unit_price'],
//                 'quantity' => $itemData['quantity'],
//                 'total_price' => $itemData['total_price'],
//             ]);
//         }

//         // Recalculate project grand total from ALL items of the same project
//         $this->recalculateProjectGrandTotal($projectId);

//         DB::commit();

//         return redirect()->route('project-items.index')
//             ->with('success', count($request->items) . ' items added successfully. Project grand total updated.');

//     } catch (\Exception $e) {
//         DB::rollBack();
//         \Log::error('Error storing project items: ' . $e->getMessage());
        
//         return redirect()->back()
//             ->withInput()
//             ->with('error', 'Error adding project items: ' . $e->getMessage());
//     }
// }

    /**
     * Display project item details
     */
    public function show($id)
    {
        $projectItem = ProjectItem::with(['project', 'product'])->findOrFail($id);
        return view('frontend.pages.project-items.show', compact('projectItem'));
    }

    /**
     * Show form to edit project item
     */

// public function edit($id)
// {
//     $projectItem = ProjectItem::with(['project', 'product.inventory', 'product.latestPurchase'])->findOrFail($id);
//     $projects = Project::all();
//     $products = Product::with(['inventory', 'latestPurchase'])->get();

//     return view('frontend.pages.project-items.edit', compact('projectItem', 'projects', 'products'));
// }

// public function edit($id)
// {
//     $projectItem = ProjectItem::findOrFail($id);

//     $project = Project::with('items.product')
//                       ->findOrFail($projectItem->project_id);

//     $projects = Project::all();
//     $products = Product::with(['inventory', 'latestPurchase'])->get();

//     return view('frontend.pages.project-items.edit', compact(
//         'projectItem', 'project', 'projects', 'products'
//     ));
// }

public function edit($id)
{
    $projectItem = ProjectItem::with('product', 'project')->findOrFail($id);
    $projects = Project::all();
    $products = Product::with(['inventory', 'latestPurchase'])->get();

    return view('frontend.pages.project-items.edit', compact(
        'projectItem', 'projects', 'products'
    ));
}

    /**
     * Update project item
     */


// public function update(Request $request, $id)
// {
//     // Debug the request data
//     \Log::info('Update request data:', $request->all());

//     $validated = $request->validate([
//         'project_id' => 'required|exists:projects,id',
//         'product_id' => 'required|exists:products,id',
//         'unit_price' => 'required|numeric|min:0',
//         'quantity' => 'required|integer|min:1',
//         'total_price' => 'required|numeric|min:0',
//     ]);

//     try {
//         $projectItem = ProjectItem::findOrFail($id);

//         // Update the project item
//         $projectItem->update([
//             'project_id' => $validated['project_id'],
//             'product_id' => $validated['product_id'],
//             'unit_price' => $validated['unit_price'],
//             'quantity' => $validated['quantity'],
//             'total_price' => $validated['total_price'],
//         ]);

//         return redirect()->route('project-items.index')
//             ->with('success', 'Project item updated successfully.');

//     } catch (\Exception $e) {
//         \Log::error('Error updating project item: ' . $e->getMessage());
        
//         return redirect()->back()
//             ->withInput()
//             ->with('error', 'Error updating project item: ' . $e->getMessage());
//     }
// }

public function update(Request $request, $id)
{
    \Log::info('Update project item request:', $request->all());

    $validated = $request->validate([
        'project_id' => 'required|exists:projects,id',
        'product_id' => 'required|exists:products,id',
        'unit_price' => 'required|numeric|min:0',
        'quantity' => 'required|integer|min:1',
        'total_price' => 'required|numeric|min:0',
    ]);

    DB::beginTransaction();

    try {
        $projectItem = ProjectItem::findOrFail($id);
        
        // Store old project ID to handle project changes
        $oldProjectId = $projectItem->project_id;
        $newProjectId = $request->project_id;

        // Update the project item
        $projectItem->update([
            'project_id' => $request->project_id,
            'product_id' => $request->product_id,
            'unit_price' => $request->unit_price,
            'quantity' => $request->quantity,
            'total_price' => $request->total_price,
        ]);

        // Recalculate grand total for both projects if project changed
        if ($oldProjectId != $newProjectId) {
            // Recalculate old project total (without this item now)
            $this->recalculateProjectGrandTotal($oldProjectId);
            // Recalculate new project total (with this item now)
            $this->recalculateProjectGrandTotal($newProjectId);
        } else {
            // Same project, just recalculate the total
            $this->recalculateProjectGrandTotal($newProjectId);
        }

        DB::commit();

        return redirect()->route('project-items.index')
            ->with('success', 'Project item updated successfully. Project grand totals recalculated.');

    } catch (\Exception $e) {
        DB::rollBack();
        \Log::error('Error updating project item: ' . $e->getMessage());
        
        return redirect()->back()
            ->withInput()
            ->with('error', 'Error updating project item: ' . $e->getMessage());
    }
}
private function recalculateProjectGrandTotal($projectId)
{
    try {
        // Get the project with all its items
        $project = Project::with('items')->find($projectId);
        
        if ($project) {
            // Calculate sum of total_price from ALL items in this project
            $grandTotal = $project->items->sum('total_price');
            
            // Update the project's grand_total
            $project->update([
                'grand_total' => $grandTotal
            ]);
            
            \Log::info("Project ID {$projectId} grand total recalculated: " . $grandTotal);
            
            return $grandTotal;
        }
        
        return 0;
    } catch (\Exception $e) {
        \Log::error('Error recalculating project grand total for project ' . $projectId . ': ' . $e->getMessage());
        return 0;
    }
}
    /**
     * Delete project item
     */
    public function destroy($id)
    {
        $projectItem = ProjectItem::findOrFail($id);
        $projectItem->delete();

        return redirect()->route('project-items.index')
            ->with('success', 'Item deleted successfully!');
    }
}