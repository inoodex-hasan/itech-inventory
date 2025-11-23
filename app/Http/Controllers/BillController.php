<?php

namespace App\Http\Controllers;

use App\Models\Bill;
use App\Models\BillItem;
use App\Models\Client;
use App\Models\Customer;
use App\Models\Project;
use App\Models\Purchase;
use App\Models\Sale;
use App\Models\Vendor;
use Illuminate\Http\Request;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Support\Facades\DB;

class BillController extends Controller
{
 public function index(Request $request)
{
    $query = Bill::with(['client', 'vendor', 'project', 'purchase', 'items']);

    // Filters
    if ($request->has('type')) {
        switch ($request->type) {
            case 'projects':
                $query->projectBills();
                break;
            case 'sales':
                $query->saleBills();
                break;
            case 'purchases':
                $query->purchaseBills();
                break;
        }
    }

    if ($request->has('status')) {
        $query->where('status', $request->status);
    }

    if ($request->has('from_date')) {
        $query->where('bill_date', '>=', $request->from_date);
    }

    if ($request->has('to_date')) {
        $query->where('bill_date', '<=', $request->to_date);
    }

    $bills = $query->latest()->paginate(20);

    // Statistics
    $totalAmount = Bill::sum('total_amount');
    // $paidCount = Bill::where('status', 'paid')->count();
    // $draftCount = Bill::where('status', 'draft')->count();
    // $overdueCount = Bill::where('status', 'overdue')->count();
    // $pendingCount = Bill::whereIn('status', ['draft', 'sent'])->count();

    return view('frontend.pages.bills.index', compact(
        'bills', 
        'totalAmount', 
        // 'paidCount', 
        // 'draftCount', 
        // 'overdueCount', 
        // 'pendingCount'
    ));
}

// public function create(Request $request)
// {
//     $projects = Project::with('client')->get();
//     $clients = Client::all();
//     $vendors = Vendor::all();
//     $sales = Sale::with('customer')->get();
//     $purchases = Purchase::with('vendor')->get();

//     return view('frontend.pages.bills.create', compact(
//         'projects', 'clients', 'vendors', 'sales', 'purchases'
//     ));
// }

   public function create()
    {
        return view('frontend.pages.bills.create');
    }

    public function getSales()
{
    try {
        $sales = Sale::with(['customer', 'product']) // Load product relationship
                    ->get()
                    ->map(function($sale) {
                        return [
                            'id' => $sale->id,
                            'order_no' => $sale->order_no,
                            'date' => $sale->created_at->format('Y-m-d'),
                            'total_amount' => $sale->payble ?? $sale->total,
                            'due_payment' => $sale->due_payment,
                            'status' => $sale->status,
                            'customer' => $sale->customer ? [
                                'id' => $sale->customer->id,
                                'name' => $sale->customer->name ?? 'Unknown',
                                'email' => $sale->customer->email ?? 'N/A',
                                'phone' => $sale->customer->phone ?? 'N/A',
                                'address' => $sale->customer->address ?? 'N/A',
                            ] : null,
                            'items' => [
                                [
                                    'id' => $sale->product_id ?? $sale->id,
                                    'description' => $sale->product->name ?? 'Product #' . $sale->order_no, // Use product name
                                    'quantity' => $sale->qty ?? 1,
                                    'unit' => 'Piece', // Adjust based on your product data
                                    'unit_price' => $sale->qty ? ($sale->total / $sale->qty) : $sale->total,
                                    'total' => $sale->total,
                                ]
                            ]
                        ];
                    });

        return response()->json(['sales' => $sales]);
    } catch (\Exception $e) {
        return response()->json(['error' => $e->getMessage()], 500);
    }
}

// public function getSales()
// {
//     try {
//         $sales = Sale::with(['customer'])
//                     ->get()
//                     ->map(function($sale) {
//                         return [
//                             'id' => $sale->id,
//                             'order_no' => $sale->order_no,
//                             'date' => $sale->created_at->format('Y-m-d'),
//                             'total_amount' => $sale->payble ?? $sale->total,
//                             'due_payment' => $sale->due_payment,
//                             'status' => $sale->status,
//                             'customer_id' => $sale->customer_id, // Add this
//                             'customer' => $sale->customer ? [
//                                 'id' => $sale->customer->id,
//                                 'name' => $sale->customer->name ?? 'Unknown',
//                                 'email' => $sale->customer->email ?? 'N/A',
//                                 'phone' => $sale->customer->phone ?? 'N/A',
//                                 'address' => $sale->customer->address ?? 'N/A',
//                             ] : null,
//                             'items' => [
//                                 [
//                                     'id' => $sale->id,
//                                     'description' => 'Sale #' . $sale->order_no,
//                                     'quantity' => $sale->qty ?? 1,
//                                     'unit' => 'Piece',
//                                     'unit_price' => $sale->qty ? ($sale->total / $sale->qty) : $sale->total,
//                                     'total' => $sale->total,
//                                 ]
//                             ]
//                         ];
//                     });

//         return response()->json(['sales' => $sales]);
//     } catch (\Exception $e) {
//         return response()->json(['error' => $e->getMessage()], 500);
//     }
// }

// public function getProjects()
// {
//     try {
//         $projects = Project::with(['client'])
//                     ->get()
//                     ->map(function($project) {
//                         return [
//                             'id' => $project->id,
//                             'name' => $project->project_name,
//                             'reference' => 'PROJ-' . $project->id,
//                             'date' => $project->start_date ?? $project->created_at->format('Y-m-d'),
//                             'total_amount' => $project->grand_total ?? $project->budget,
//                             'due_payment' => $project->due_payment,
//                             'status' => $project->status,
//                             'client' => $project->client ? [
//                                 'id' => $project->client->id,
//                                 'name' => $project->client->name ?? 'Unknown',
//                                 'email' => $project->client->email ?? 'N/A',
//                                 'phone' => $project->client->phone ?? 'N/A',
//                                 'address' => $project->client->address ?? 'N/A',
//                             ] : null,
//                             'items' => [
//                                 [
//                                     'id' => $project->id,
//                                     'description' => $project->project_name,
//                                     'quantity' => 1,
//                                     'unit' => 'Project',
//                                     'unit_price' => $project->grand_total ?? $project->budget,
//                                     'total' => $project->grand_total ?? $project->budget,
//                                 ]
//                             ]
//                         ];
//                     });

//         return response()->json(['projects' => $projects]);
//     } catch (\Exception $e) {
//         return response()->json(['error' => $e->getMessage()], 500);
//     }
// }   

public function getProjects()
{
    try {
        $projects = Project::with(['client', 'projectItems.product']) 
                    ->get()
                    ->map(function($project) {
                        return [
                            'id' => $project->id,
                            'name' => $project->project_name,
                            'reference' => 'PROJ-' . $project->id,
                            'date' => $project->start_date ?? $project->created_at->format('Y-m-d'),
                            'total_amount' => $project->budget,
                            'due_payment' => $project->due_payment,
                            'status' => $project->status,
                            'client' => $project->client ? [
                                'id' => $project->client->id,
                                'name' => $project->client->name ?? 'Unknown',
                                'email' => $project->client->email ?? 'N/A',
                                'phone' => $project->client->phone ?? 'N/A',
                                'address' => $project->client->address ?? 'N/A',
                            ] : null,
                            'items' => $project->projectItems->map(function($item) {
                                // Get description from the product relationship
                                $productName = $item->product ? $item->product->name : null;
                                $productDescription = $item->product ? $item->product->description : null;
                                
                                return [
                                    'id' => $item->id,
                                    'description' => $item->description ?? $productDescription ?? $productName ?? 'Project Item',
                                    'quantity' => $item->quantity ?? 1,
                                    'unit' => $item->unit ?? 'Unit',
                                    'unit_price' => $item->unit_price ?? 0,
                                    'total' => $item->total ?? ($item->quantity * $item->unit_price),
                                ];
                            })->toArray()
                        ];
                    });

        return response()->json(['projects' => $projects]);
    } catch (\Exception $e) {
        \Log::error('getProjects Error: ' . $e->getMessage());
        return response()->json(['error' => $e->getMessage()], 500);
    }
}

public function store(Request $request)
{
    $request->validate([
        'bill_type' => 'required|in:sale,project',
        'reference_number' => 'required',
        'bill_date' => 'required|date',
        'selected_sale_id' => 'required_if:bill_type,sale',
        'selected_project_id' => 'required_if:bill_type,project',
        'work_order_number' => 'nullable|string|max:255',
        'items' => 'required|array',
        'total_amount' => 'required|numeric',
        'client_name' => 'required|string|max:255',
        'client_address' => 'required|string',
        'attention_to' => 'nullable|string|max:255',
        'terms_conditions' => 'required|string',
        'bank_account_name' => 'required|string|max:255',
        'bank_name' => 'required|string|max:255',
        'bank_branch' => 'required|string|max:255',
        'bank_account_number' => 'required|string|max:255',
        'bank_account_type' => 'required|string|max:255',
        'company_name' => 'required|string|max:255',
        'signatory_name' => 'required|string|max:255',
        'signatory_designation' => 'required|string|max:255',
        'company_phone' => 'nullable|string|max:255',
        'company_email' => 'nullable|email|max:255',
        'company_website' => 'nullable|string|max:255',
        'subject' => 'required|string|max:500',
    ]);

    // Generate bill number
    $billNumber = 'BILL-' . date('Ymd') . '-' . str_pad(Bill::count() + 1, 4, '0', STR_PAD_LEFT);

    $customerId = null;
    $clientId = null;

    // Get customer_id and client_id from the selected sale/project
    if ($request->bill_type === 'sale' && $request->selected_sale_id) {
        $sale = Sale::find($request->selected_sale_id);
        $customerId = $sale->customer_id ?? null;
    } elseif ($request->bill_type === 'project' && $request->selected_project_id) {
        $project = Project::find($request->selected_project_id);
        $clientId = $project->client_id ?? null;
    }

    // Create the bill - WITHOUT client fields
    $bill = Bill::create([
        'bill_number' => $billNumber, 
        'bill_type' => $request->bill_type,
        'reference_number' => $request->reference_number,
        'bill_date' => $request->bill_date,
        'sale_id' => $request->selected_sale_id,
        'project_id' => $request->selected_project_id,
        'customer_id' => $customerId,
        'client_id' => $clientId,
        'work_order_number' => $request->work_order_number,
        'subtotal' => $request->subtotal,
        'total_amount' => $request->total_amount,
        'notes' => $request->notes,
        // Don't store client fields in database
    ]);

    // Add bill items
    foreach ($request->items as $item) {
        BillItem::create([
            'bill_id' => $bill->id,
            'description' => $item['description'],
            'quantity' => $item['quantity'],
            'unit' => $item['unit'],
            'unit_price' => $item['unit_price'],
            'total' => $item['total'],
        ]);
    }

    // Load bill with relationships for PDF
    $billWithRelations = Bill::with(['billItems', 'sale.customer', 'project.client'])->find($bill->id);
    
   // Prepare data for your PDF template
$pdfData = [
    'bill' => $billWithRelations,
    'amount_in_words' => $this->convertToWords($billWithRelations->total_amount),
    'subject' => $request->subject,
    // Dynamic Bank Details from form
    'bank_details' => [
        'account_name' => $request->bank_account_name,
        'bank_name' => $request->bank_name,
        'branch' => $request->bank_branch,
        'account_number' => $request->bank_account_number,
        'account_type' => $request->bank_account_type,
    ],
    // Dynamic Company Details from form
    'company' => [
        'name' => $request->company_name,
        'signatory_name' => $request->signatory_name,
        'signatory_designation' => $request->signatory_designation,
        'phone' => $request->company_phone,
        'email' => $request->company_email,
        'website' => $request->company_website,
    ],
    // Client data
    'recipient_designation' => 'Director (IT)',
    'recipient_organization' => $request->client_name,
    'recipient_address' => $request->client_address,
    'attention_to' => $request->attention_to,
    'terms_conditions' => $request->terms_conditions,
];
    // Generate PDF using your existing template
    $pdf = Pdf::loadView('pdf.bill', $pdfData);
   
// $pdf->setOptions([
//     'footer-center' => 'Corporate Office: 187(3rd Floor), Green Road, Dhanmondi Dhaka-1205, Bangladesh. Cell: +88 01904400202, +88 01904400203 | E-mail: info.itechbd@yahoo.com | Web: www.itechbd.net | Page [page]',
//     'footer-font-size' => 7,
//     'footer-font-family' => 'Arial',
//     'footer-line' => true, // Add line above footer
//     'margin-bottom' => 20, // Make space for footer
//     'isHtml5ParserEnabled' => true,
//     'isRemoteEnabled' => true,
// ]);

return $pdf->download('bill-' . $bill->bill_number . '.pdf');

}
// public function store(Request $request)
// {
//     $request->validate([
//         'bill_type' => 'required|in:sale,project',
//         'reference_number' => 'required',
//         'bill_date' => 'required|date',
//         'selected_sale_id' => 'required_if:bill_type,sale',
//         'selected_project_id' => 'required_if:bill_type,project',
//         'work_order_number' => 'nullable|string|max:255',
//         'items' => 'required|array',
//         'total_amount' => 'required|numeric',
//     ]);

//     // Generate bill number
//     $billNumber = 'BILL-' . date('Ymd') . '-' . str_pad(Bill::count() + 1, 4, '0', STR_PAD_LEFT);

//     $customerId = null;
//     $clientId = null;

//     // Get customer_id and client_id from the selected sale/project
//     if ($request->bill_type === 'sale' && $request->selected_sale_id) {
//         $sale = Sale::find($request->selected_sale_id);
//         $customerId = $sale->customer_id ?? null;
//     } elseif ($request->bill_type === 'project' && $request->selected_project_id) {
//         $project = Project::find($request->selected_project_id);
//         $clientId = $project->client_id ?? null;
//     }

//     // Create the bill
//     $bill = Bill::create([
//         'bill_number' => $billNumber, 
//         'bill_type' => $request->bill_type,
//         'reference_number' => $request->reference_number,
//         'bill_date' => $request->bill_date,
//         'sale_id' => $request->selected_sale_id,
//         'project_id' => $request->selected_project_id,
//         'customer_id' => $customerId,
//         'client_id' => $clientId,
//         'work_order_number' => $request->work_order_number,
//         'subtotal' => $request->subtotal,
//         'total_amount' => $request->total_amount,
//         'notes' => $request->notes,
//     ]);

//     // Add bill items
//     foreach ($request->items as $item) {
//         BillItem::create([
//             'bill_id' => $bill->id,
//             'description' => $item['description'],
//             'quantity' => $item['quantity'],
//             'unit' => $item['unit'],
//             'unit_price' => $item['unit_price'],
//             'total' => $item['total'],
//         ]);
//     }

//     // Load bill with relationships for PDF
//     $billWithRelations = Bill::with(['billItems', 'sale.customer', 'project.client'])->find($bill->id);
    
//     // Prepare data for your PDF template
//     $pdfData = [
//         'bill' => $billWithRelations,
//         'amount_in_words' => $this->convertToWords($billWithRelations->total_amount),
//         'bank_details' => [
//             'account_name' => 'Intelligent Technology',
//             'bank_name' => 'Bank Asia Ltd.',
//             'branch' => 'Satmosjid Road',
//             'account_number' => '06933000526',
//             'account_type' => 'Current',
//         ],
//         'company' => [
//             'name' => 'Intelligent Technology',
//             'signatory_name' => 'Engr. Shamsul Alam',
//             'signatory_designation' => 'Director (Technical)',
//             'phone' => '+880 XXXX-XXXXXX',
//             'email' => 'info@intelligenttech.com',
//             'website' => 'www.intelligenttech.com'
//         ]
//     ];

//     // Generate PDF using your existing template
//     $pdf = Pdf::loadView('pdf.bill', $pdfData);
    
//     return $pdf->download('bill-' . $bill->bill_number . '.pdf');
// }

public function show($id)
{
    // Get the bill with all relationships
    $bill = Bill::with([
        'billItems',
        'sale.customer', 
        'project.client',
        'customer',
        'client'
    ])->findOrFail($id);

    // Prepare data for the view (similar to PDF data)
    $data = [
        'bill' => $bill,
        'amount_in_words' => $this->convertToWords($bill->total_amount),
        'subject' => $bill->subject ?? 'Bill for Supplying of Products/Services',
        'bank_details' => [
            'account_name' => $bill->bank_account_name ?? 'Intelligent Technology',
            'bank_name' => $bill->bank_name ?? 'Bank Asia Ltd.',
            'branch' => $bill->bank_branch ?? 'Satmosjid Road',
            'account_number' => $bill->bank_account_number ?? '06933000526',
            'account_type' => $bill->bank_account_type ?? 'Current',
        ],
        'company' => [
            'name' => $bill->company_name ?? 'Intelligent Technology',
            'signatory_name' => $bill->signatory_name ?? 'Engr. Shamsul Alam',
            'signatory_designation' => $bill->signatory_designation ?? 'Director (Technical)',
            'phone' => $bill->company_phone ?? '+880 XXXX-XXXXXX',
            'email' => $bill->company_email ?? 'info@intelligenttech.com',
            'website' => $bill->company_website ?? 'www.intelligenttech.com',
        ],
        'recipient_designation' => 'Director (IT)',
        'recipient_organization' => $bill->client_name ?? ($bill->client->name ?? 'N/A'),
        'recipient_address' => $bill->client_address ?? ($bill->client->address ?? 'N/A'),
        'attention_to' => $bill->attention_to,
        'terms_conditions' => $bill->terms_conditions,
    ];

    return view('frontend.pages.bills.show', $data);
}

private function convertToWords($number)
{
    $decimal = round($number - floor($number), 2) * 100;
    $whole_number = floor($number);
    
    $words = $this->convertNumberToWords($whole_number) . ' Taka';
    
    if ($decimal > 0) {
        $words .= ' and ' . $this->convertNumberToWords($decimal) . ' Paisa';
    }
    
    return $words;
}

private function convertNumberToWords($number)
{
    if ($number == 0) {
        return 'Zero';
    }
    
    $ones = array(
        0 => '',
        1 => 'One',
        2 => 'Two',
        3 => 'Three',
        4 => 'Four',
        5 => 'Five',
        6 => 'Six',
        7 => 'Seven',
        8 => 'Eight',
        9 => 'Nine',
        10 => 'Ten',
        11 => 'Eleven',
        12 => 'Twelve',
        13 => 'Thirteen',
        14 => 'Fourteen',
        15 => 'Fifteen',
        16 => 'Sixteen',
        17 => 'Seventeen',
        18 => 'Eighteen',
        19 => 'Nineteen'
    );
    
    $tens = array(
        2 => 'Twenty',
        3 => 'Thirty',
        4 => 'Forty',
        5 => 'Fifty',
        6 => 'Sixty',
        7 => 'Seventy',
        8 => 'Eighty',
        9 => 'Ninety'
    );
    
    $words = '';
    
    // Handle lakhs
    if ($number >= 100000) {
        $lakhs = floor($number / 100000);
        $words .= $this->convertNumberToWords($lakhs) . ' Lakh ';
        $number %= 100000;
    }
    
    // Handle thousands
    if ($number >= 1000) {
        $thousands = floor($number / 1000);
        $words .= $this->convertNumberToWords($thousands) . ' Thousand ';
        $number %= 1000;
    }
    
    // Handle hundreds
    if ($number >= 100) {
        $hundreds = floor($number / 100);
        $words .= $this->convertNumberToWords($hundreds) . ' Hundred ';
        $number %= 100;
    }
    
    // Handle tens and ones
    if ($number > 0) {
        if ($number < 20) {
            $words .= $ones[$number];
        } else {
            $words .= $tens[floor($number / 10)];
            if ($number % 10 > 0) {
                $words .= ' ' . $ones[$number % 10];
            }
        }
    }
    
    return trim($words);
}

// public function store(Request $request)
// {
//     $request->validate([
//         'bill_type' => 'required|in:sale,project',
//         'reference_number' => 'required',
//         'bill_date' => 'required|date',
//         'selected_sale_id' => 'required_if:bill_type,sale',
//         'selected_project_id' => 'required_if:bill_type,project',
//         'work_order_number' => 'nullable|string|max:255',
//         'items' => 'required|array',
//         'total_amount' => 'required|numeric',
//     ]);

//     // Generate bill number
//     $billNumber = 'BILL-' . date('Ymd') . '-' . str_pad(Bill::count() + 1, 4, '0', STR_PAD_LEFT);

//     $customerId = null;
//     $clientId = null;

//     // FIX: Get customer_id and client_id from the selected sale/project
//     if ($request->bill_type === 'sale' && $request->selected_sale_id) {
//         $sale = Sale::find($request->selected_sale_id);
//         $customerId = $sale->customer_id ?? null;
//     } elseif ($request->bill_type === 'project' && $request->selected_project_id) {
//         $project = Project::find($request->selected_project_id);
//         $clientId = $project->client_id ?? null;
//     }

//     // Create the bill
//     $bill = Bill::create([
//         'bill_number' => $billNumber, 
//         'bill_type' => $request->bill_type,
//         'reference_number' => $request->reference_number,
//         'bill_date' => $request->bill_date,
//         'sale_id' => $request->selected_sale_id,
//         'project_id' => $request->selected_project_id,
//         'customer_id' => $customerId,
//         'client_id' => $clientId, 
//         'work_order_number' => $request->work_order_number,
//         'subtotal' => $request->subtotal,
//         'total_amount' => $request->total_amount,
//         'notes' => $request->notes,
//     ]);

//     // Add bill items
//     foreach ($request->items as $item) {
//         BillItem::create([
//             'bill_id' => $bill->id,
//             'description' => $item['description'],
//             'quantity' => $item['quantity'],
//             'unit' => $item['unit'],
//             'unit_price' => $item['unit_price'],
//             'total' => $item['total'],
//         ]);
//     }

//     // FIX: Load the bill with all relationships for PDF
//     $billWithRelations = Bill::with(['billItems', 'sale.customer', 'project.client'])->find($bill->id);
    
//     $pdf = PDF::loadView('pdf.bill', compact('billWithRelations'));
    
//     return $pdf->download('bill-' . $bill->bill_number . '.pdf');
// }
private function updateRelatedEntities(Bill $bill, array $validated)
{
    try {
        switch ($validated['bill_type']) {
            case 'project':
                // Update project status or add bill reference
                $project = Project::find($validated['project_id']);
                if ($project) {
                    // You can update project status or add bill reference here
                    \Log::info("Bill {$bill->bill_number} created for project: {$project->name}");
                }
                break;

            case 'sale':
                // Update sale status or add bill reference
                $client = Client::find($validated['client_id']);
                if ($client) {
                    \Log::info("Bill {$bill->bill_number} created for client: {$client->name}");
                }
                break;

            case 'purchase':
                // Update purchase order status
                if (isset($validated['purchase_id'])) {
                    $purchase = Purchase::find($validated['purchase_id']);
                    if ($purchase) {
                        // Update purchase status to billed
                        $purchase->update(['status' => 'billed']);
                        \Log::info("Bill {$bill->bill_number} created for purchase: {$purchase->purchase_number}");
                    }
                }
                break;

            case 'vendor':
                $vendor = Vendor::find($validated['vendor_id']);
                if ($vendor) {
                    \Log::info("Vendor bill {$bill->bill_number} created for: {$vendor->name}");
                }
                break;
        }
    } catch (\Exception $e) {
        \Log::error('Error updating related entities: ' . $e->getMessage());
        // Don't throw error, just log it as this is secondary
    }
}

   public function preview(Bill $bill)
{
    $bill->load(['client', 'vendor', 'project', 'purchase', 'items']);
    
    $company = $this->getCompanyDetails();
    $bankDetails = $this->getBankDetails();
    $amountInWords = $bill->amount_in_words;

    // Customize PDF title based on bill type
    $title = match($bill->type) {
        'project' => 'PROJECT BILL',
        'sale' => 'SALES INVOICE',
        'purchase' => 'PURASE BILL',
        'vendor' => 'VENDOR BILL',
        default => 'BILL'
    };

    $pdf = Pdf::loadView('bills.pdf.template', [
        'bill' => $bill,
        'company' => $company,
        'bank_details' => $bankDetails,
        'amount_in_words' => $amountInWords,
        'title' => $title,
    ]);

    return $pdf->stream("{$bill->bill_number}.pdf");
}

public function download($id)
{
    $bill = Bill::with(['billItems', 'sale.customer', 'project.client'])->findOrFail($id);
    
    $pdfData = [
        'bill' => $bill,
        'amount_in_words' => $this->convertToWords($bill->total_amount),
        'subject' => $bill->subject ?? 'Bill for Supplying of Products/Services',
        'bank_details' => [
            'account_name' => $bill->bank_account_name ?? 'Intelligent Technology',
            'bank_name' => $bill->bank_name ?? 'Bank Asia Ltd.',
            'branch' => $bill->bank_branch ?? 'Satmosjid Road',
            'account_number' => $bill->bank_account_number ?? '06933000526',
            'account_type' => $bill->bank_account_type ?? 'Current',
        ],
        'company' => [
            'name' => $bill->company_name ?? 'Intelligent Technology',
            'signatory_name' => $bill->signatory_name ?? 'Engr. Shamsul Alam',
            'signatory_designation' => $bill->signatory_designation ?? 'Director (Technical)',
            'phone' => $bill->company_phone ?? '+880 XXXX-XXXXXX',
            'email' => $bill->company_email ?? 'info@intelligenttech.com',
            'website' => $bill->company_website ?? 'www.intelligenttech.com',
        ],
        'recipient_designation' => 'Director (IT)',
        'recipient_organization' => $bill->client_name ?? ($bill->client->name ?? 'N/A'),
        'recipient_address' => $bill->client_address ?? ($bill->client->address ?? 'N/A'),
        'attention_to' => $bill->attention_to,
        'terms_conditions' => $bill->terms_conditions,
    ];

    $pdf = Pdf::loadView('pdf.bill', $pdfData);
    return $pdf->download('bill-' . $bill->bill_number . '.pdf');
}

    public function updateStatus(Bill $bill, Request $request)
    {
        $request->validate([
            'status' => 'required|in:draft,sent,paid,overdue,cancelled'
        ]);

        $bill->update(['status' => $request->status]);

        return response()->json([
            'success' => true,
            'message' => 'Bill status updated successfully!'
        ]);
    }

    // Helper Methods
    private function validateRequest(Request $request)
    {
        return $request->validate([
            'reference_number' => 'required|string|unique:bills,reference_number',
            'client_id' => 'nullable|exists:clients,id',
            'vendor_id' => 'nullable|exists:vendors,id',
            'project_id' => 'nullable|exists:projects,id',
            'purchase_id' => 'nullable|exists:purchases,id',
            'work_order_number' => 'nullable|string',
            'bill_date' => 'required|date',
            'items' => 'required|array',
            'items.*.description' => 'required|string',
            'items.*.quantity' => 'required|numeric|min:1',
            'items.*.unit_price' => 'required|numeric|min:0',
            'subtotal' => 'required|numeric|min:0',
            'total_amount' => 'required|numeric|min:0',
            'notes' => 'nullable|string',
        ]);
    }

    private function getSourceData($sourceType, $sourceId)
    {
        switch ($sourceType) {
            case 'project':
                return Project::with('client', 'items')->find($sourceId);
            case 'client':
                return Client::find($sourceId);
            case 'vendor':
                return Vendor::find($sourceId);
            case 'purchase':
                return Purchase::with('vendor', 'items')->find($sourceId);
            default:
                return null;
        }
    }

    private function getDefaultData($sourceType, $source)
    {
        $defaults = [
            'reference_number' => 'BIL-' . now()->format('Ymd-His'),
            'bill_date' => now()->format('Y-m-d'),
        ];

        if (!$source) return $defaults;

        switch ($sourceType) {
            case 'project':
                $defaults['project_id'] = $source->id;
                $defaults['client_id'] = $source->client_id;
                $defaults['work_order_number'] = $source->work_order_number;
                $defaults['notes'] = "Bill for project: {$source->name}";
                break;
            
            case 'purchase':
                $defaults['purchase_id'] = $source->id;
                $defaults['vendor_id'] = $source->vendor_id;
                $defaults['notes'] = "Bill for purchase order: {$source->purchase_number}";
                break;
            
            case 'client':
                $defaults['client_id'] = $source->id;
                $defaults['notes'] = "Bill for client: {$source->name}";
                break;
        }

        return $defaults;
    }

    private function determineBillType($data)
    {
        if ($data['project_id']) return 'project';
        if ($data['purchase_id']) return 'purchase';
        if ($data['vendor_id']) return 'vendor';
        if ($data['client_id']) return 'sale';
        return 'general';
    }

private function getCompanyDetails()
{
    return [
        'name' => config('app.company_name', 'Your Company'),
        'address' => config('app.company_address', '123 Company Street, City, State'),
        'phone' => config('app.company_phone', '+880 XXXX-XXXXXX'),
        'email' => config('app.company_email', 'info@company.com'),
        'website' => config('app.company_website', 'www.company.com'),
        'signatory_name' => config('app.signatory_name', 'Authorized Signatory'),
        'signatory_designation' => config('app.signatory_designation', 'Manager'),
    ];
}

private function getBankDetails()
{
    return [
        'account_name' => config('app.bank_account_name', 'Your Company'),
        'bank_name' => config('app.bank_name', 'Bank Name'),
        'branch' => config('app.bank_branch', 'Branch Name'),
        'account_number' => config('app.bank_account_number', 'XXXX-XXXX-XXXX'),
        'account_type' => config('app.bank_account_type', 'Current'),
        'routing_number' => config('app.bank_routing_number', 'XXXXXXX'),
    ];
}

    // private function convertToWords($number)
    // {
    //     // Your number to words conversion logic
    //     return number_format($number, 2) . " Taka Only";
    // }
}