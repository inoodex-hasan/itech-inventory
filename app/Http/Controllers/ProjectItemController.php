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
    $request->validate([
        'project_id' => 'required|exists:projects,id',
        'products' => 'required|array|min:1',
        'products.*.product_id' => 'required|exists:products,id',
        'products.*.unit_price' => 'required|numeric|min:0',
        'products.*.quantity' => 'required|integer|min:1',
        'products.*.total' => 'required|numeric|min:0',
        'subTotal' => 'required|numeric|min:0',
        'grandTotal' => 'required|numeric|min:0',
    ]);

    try {
        DB::beginTransaction();

        // Create project items (individual records for each product)
        foreach ($request->products as $productData) {
            $projectItem = ProjectItem::create([
                'project_id' => $request->project_id,
                'product_id' => $productData['product_id'],
                'unit_price' => $productData['unit_price'],
                'quantity' => $productData['quantity'],
                'total_price' => $productData['total'],
                'added_by' => auth()->id(),
            ]);

        }

        DB::commit();

        return redirect()->route('project-items.index')
            ->with('success', 'Items added to project successfully.');

    } catch (\Exception $e) {
        DB::rollBack();
        return redirect()->back()
            ->with('error', 'Error adding items to project: ' . $e->getMessage())
            ->withInput();
    }
}

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

// ProjectItemController.php
public function edit($id)
{
    $projectItem = ProjectItem::findOrFail($id);

    $project = Project::with('items.product')
                      ->findOrFail($projectItem->project_id);

    $projects = Project::all();
    $products = Product::with(['inventory', 'latestPurchase'])->get();

    return view('frontend.pages.project-items.edit', compact(
        'projectItem', 'project', 'projects', 'products'
    ));
}

    /**
     * Update project item
     */

// public function update(Request $request, $id)
// {
//     // Debug: see what's coming in the request
//     \Log::info('Update request data:', $request->all());
    
//     $request->validate([
//         'project_id' => 'required|exists:projects,id',
//         'items' => 'sometimes|array',
//         'items.*.product_id' => 'required|exists:products,id',
//         'items.*.unit_price' => 'required|numeric|min:0',
//         'items.*.quantity' => 'required|integer|min:1',
//         'items.*.total_price' => 'required|numeric|min:0',
//         'products' => 'sometimes|array',
//         'products.*.product_id' => 'required|exists:products,id',
//         'products.*.unit_price' => 'required|numeric|min:0',
//         'products.*.quantity' => 'required|integer|min:1',
//         'products.*.total' => 'required|numeric|min:0',
//         'removed_items' => 'sometimes|array',
//         'removed_items.*' => 'required|exists:project_items,id',
//         'subTotal' => 'required|numeric|min:0',
//         'grandTotal' => 'required|numeric|min:0',
//     ]);

//     try {
//         DB::beginTransaction();

//         // Debug: log removed items
//         \Log::info('Removed items:', $request->removed_items ?? []);

//         // Update the main project
//         $projectItem = ProjectItem::findOrFail($id);
//         $projectItem->update([
//             'project_id' => $request->project_id,
//             'updated_by' => auth()->id(),
//         ]);

//         // Delete removed items
//         if ($request->has('removed_items')) {
//             \Log::info('Deleting items:', $request->removed_items);
//             ProjectItem::whereIn('id', $request->removed_items)->delete();
//         }

//         // Update existing items
//         if ($request->has('items')) {
//             foreach ($request->items as $itemId => $itemData) {
//                 $existingItem = ProjectItem::find($itemId);
//                 if ($existingItem) {
//                     $existingItem->update([
//                         'unit_price' => $itemData['unit_price'],
//                         'quantity' => $itemData['quantity'],
//                         'total_price' => $itemData['total_price'],
//                     ]);
//                 }
//             }
//         }

//         // Add new items
//         if ($request->has('products')) {
//             foreach ($request->products as $productData) {
//                 ProjectItem::create([
//                     'project_id' => $request->project_id,
//                     'product_id' => $productData['product_id'],
//                     'unit_price' => $productData['unit_price'],
//                     'quantity' => $productData['quantity'],
//                     'total_price' => $productData['total'],
//                     'added_by' => auth()->id(),
//                 ]);
//             }
//         }

//         DB::commit();

//         return redirect()->route('project-items.index')
//             ->with('success', 'Project items updated successfully.');

//     } catch (\Exception $e) {
//         DB::rollBack();
//         \Log::error('Update error: ' . $e->getMessage());
//         return redirect()->back()
//             ->with('error', 'Error updating project items: ' . $e->getMessage())
//             ->withInput();
//     }
// }

public function update(Request $request, $id)
{
    $projectItem = ProjectItem::findOrFail($id);
    $project = $projectItem->project;

    foreach ($request->items ?? [] as $itemId => $data) {
        ProjectItem::where('id', $itemId)
                   ->where('project_id', $project->id)
                   ->update([
                       'unit_price' => $data['unit_price'],
                       'quantity' => $data['quantity'],
                       'total_price' => $data['unit_price'] * $data['quantity'],
                   ]);
    }

    return back()->with('success', 'Items updated successfully!');
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