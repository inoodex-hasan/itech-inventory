<?php

namespace App\Http\Controllers;

use App\Models\Challan;
use App\Models\ChallanItem;
use App\Models\Sale;
use App\Models\Project;
use Illuminate\Http\Request;
use PDF;

class ChallanController extends Controller
{
public function index()
{
    $challans = Challan::with(['challanItems', 'sale', 'project'])
        ->latest()
        ->paginate(10);
    
    return view('frontend.pages.challans.index', compact('challans'));
}

    public function create()
    {
        return view('frontend.pages.challans.create');
    }

 public function store(Request $request)
{
    \Log::info('Challan store method called', $request->all());

    try {
        $request->validate([
            'type' => 'required|in:sale,project',
            'reference_number' => 'required',
            'challan_date' => 'required|date',
            'selected_sale_id' => 'required_if:type,sale',
            'selected_project_id' => 'required_if:type,project',
            'recipient_organization' => 'required|string|max:255',
            'recipient_address' => 'required|string',
            'attention_to' => 'nullable|string|max:255',
            'subject' => 'required|string|max:500',
            'items' => 'required|array',
            'company_name' => 'required|string|max:255',
            'signatory_name' => 'required|string|max:255',
            'signatory_designation' => 'required|string|max:255',
        ]);

        // Generate challan number
        $challanNumber = 'CHALLAN-' . date('Ymd') . '-' . str_pad(Challan::count() + 1, 4, '0', STR_PAD_LEFT);

        $customerId = null;
        $clientId = null;

        // Create the challan
        $challan = Challan::create([
            'challan_number' => $challanNumber,
            'reference_number' => $request->reference_number,
            'challan_date' => $request->challan_date,
            'type' => $request->type,
            'sale_id' => $request->selected_sale_id,
            'project_id' => $request->selected_project_id,
            'customer_id' => $customerId,
            'client_id' => $clientId,
            'recipient_organization' => $request->recipient_organization,
            'recipient_designation' => $request->recipient_designation ?? 'The Managing Director',
            'recipient_address' => $request->recipient_address,
            'attention_to' => $request->attention_to,
            'subject' => $request->subject,
            'notes' => $request->notes,
            'company_name' => $request->company_name,
            'signatory_name' => $request->signatory_name,
            'signatory_designation' => $request->signatory_designation,
        ]);

        // Add challan items
        foreach ($request->items as $item) {
            ChallanItem::create([
                'challan_id' => $challan->id,
                'description' => $item['description'],
                'quantity' => $item['quantity'],
                'unit' => $item['unit'],
            ]);
        }

        // Load challan with relationships for PDF
        $challanWithRelations = Challan::with(['challanItems'])->find($challan->id);
        
        // Prepare data for PDF
        $pdfData = [
            'challan' => $challanWithRelations,
            'recipient_designation' => $challan->recipient_designation,
            'recipient_organization' => $challan->recipient_organization,
            'recipient_address' => $challan->recipient_address,
            'attention_to' => $challan->attention_to,
            'company_name' => $challan->company_name,
            'signatory_name' => $challan->signatory_name,
            'signatory_designation' => $challan->signatory_designation,
            'notes' => $challan->notes,
        ];

        \Log::info('PDF data prepared', $pdfData);

        // Generate PDF
        $pdf = PDF::loadView('pdf.challan', $pdfData);
        
        return $pdf->download('challan-' . $challan->challan_number . '.pdf');

    } catch (\Exception $e) {
        \Log::error('Challan creation error: ' . $e->getMessage());
        \Log::error('Stack trace: ' . $e->getTraceAsString());
        return back()->with('error', 'Error creating challan: ' . $e->getMessage())->withInput();
    }
}

    public function show($id)
    {
        $challan = Challan::with(['challanItems', 'sale.customer', 'project.client'])->findOrFail($id);
        return view('challans.show', compact('challan'));
    }

    public function download($id)
    {
        $challan = Challan::with(['challanItems'])->findOrFail($id);
        
        $pdfData = [
            'challan' => $challan,
            'recipient_designation' => $challan->recipient_designation,
            'recipient_organization' => $challan->recipient_organization,
            'recipient_address' => $challan->recipient_address,
            'attention_to' => $challan->attention_to,
            'company_name' => $challan->company_name,
            'signatory_name' => $challan->signatory_name,
            'signatory_designation' => $challan->signatory_designation,
            'notes' => $challan->notes,
        ];

        $pdf = PDF::loadView('pdf.challan', $pdfData);
        return $pdf->download('challan-' . $challan->challan_number . '.pdf');
    }

public function getSales()
{
    try {
        $sales = Sale::with(['customer'])->get();
        return response()->json(['sales' => $sales]);
    } catch (\Exception $e) {
        \Log::error('Error fetching sales for challan: ' . $e->getMessage());
        return response()->json(['error' => 'Failed to load sales'], 500);
    }
}

public function getProjects()
{
    try {
        $projects = Project::with(['client'])->get();
        return response()->json(['projects' => $projects]);
    } catch (\Exception $e) {
        \Log::error('Error fetching projects for challan: ' . $e->getMessage());
        return response()->json(['error' => 'Failed to load projects'], 500);
    }
}
}