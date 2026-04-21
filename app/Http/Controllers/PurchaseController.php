<?php

namespace App\Http\Controllers;

use App\Models\Vendor;
use App\Models\Product;
use App\Models\Purchase;
use App\Models\Inventory;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;
use Barryvdh\DomPDF\Facade\Pdf;

class PurchaseController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $query = Purchase::with(['product', 'vendor']);

        // Filter by search term
        if ($request->filled('search')) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->whereHas('product', function ($q) use ($search) {
                    $q->where('name', 'like', "%{$search}%");
                })->orWhereHas('vendor', function ($q) use ($search) {
                    $q->where('name', 'like', "%{$search}%");
                });
            });
        }

        // Filter by vendor
        if ($request->filled('vendor_id')) {
            $query->where('vendor_id', $request->vendor_id);
        }

        // Filter by product
        if ($request->filled('product_id')) {
            $query->where('product_id', $request->product_id);
        }

        // Filter by date range
        if ($request->filled('from') && $request->filled('to')) {
            $from = date('Y-m-d 00:00:00', strtotime($request->from));
            $to = date('Y-m-d 23:59:59', strtotime($request->to));
            $query->whereBetween('created_at', [$from, $to]);
        }

        $purchases = $query->latest()->paginate(10)->withQueryString();
        $products = Product::latest()->get();
        $vendors = Vendor::latest()->get();
        
        return view('frontend.pages.purchase.index', compact('purchases', 'products', 'vendors'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'product_id'     => 'required|exists:products,id',
            'quantity'       => 'required|numeric|min:1',
            'unit_price'     => 'required|numeric|min:0',
            'sub_price'      => 'nullable|numeric',
            'total_price'    => 'required|numeric|min:0',
            'payment'        => 'required|numeric|min:0',
            'due'            => 'required|numeric|min:0',
            'vendor_id'      => 'required|exists:vendors,id',
            'serial_numbers' => 'nullable|array',
            'serial_bulk'    => 'nullable|string',
        ]);

        // Create purchase
        $purchase = Purchase::create([
            'product_id'  => $request->product_id,
            'quantity'    => $request->quantity,
            'unit_price'  => $request->unit_price,
            'sub_price'   => $request->sub_price ?? ($request->quantity * $request->unit_price),
            'total_price' => $request->total_price,
            'payment'     => $request->payment,
            'due'         => $request->due,
            'vendor_id'   => $request->vendor_id,
            'created_by'  => Auth::id(),
        ]);

        // Handle Serial Numbers
        $product = Product::find($request->product_id);
        if ($product && $product->is_serialized) {
            $serials = [];

            // From individual inputs
            if ($request->filled('serial_numbers')) {
                $serials = array_merge($serials, $request->serial_numbers);
            }

            // From bulk textarea
            if ($request->filled('serial_bulk')) {
                // Split by newline or comma
                $bulkSerials = preg_split('/[\n,]+/', $request->serial_bulk);
                $serials = array_merge($serials, array_map('trim', $bulkSerials));
            }

            // Filter out empty values and limit to quantity
            $serials = array_filter($serials);
            $serials = array_slice($serials, 0, $request->quantity);

            foreach ($serials as $serial) {
                \App\Models\ProductSerial::create([
                    'product_id'    => $product->id,
                    'purchase_id'   => $purchase->id,
                    'serial_number' => $serial,
                    'status'        => 'available',
                ]);
            }
        }

        // Increment inventory quantity
        $inventory = Inventory::where('product_id', $request->product_id)->first();

        if ($inventory) {
            $inventory->current_stock += $request->quantity;
            $inventory->save();
        } else {
            $newInventory  = new Inventory();
            $newInventory->product_id = $request->product_id;
            $newInventory->current_stock = $request->quantity;
            $newInventory->opening_stock = $request->quantity;
            $newInventory->notes = 'Opening stock entry';
            $newInventory->save();
        }

        return redirect()->back()->with('success', 'Purchase created and inventory updated successfully.');
    }



    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Purchase $purchase)
    {
        $request->validate([
            'product_id'  => 'required|exists:products,id',
            'quantity'    => 'required|numeric|min:1',
            'unit_price'  => 'required|numeric|min:0',
            'sub_price'   => 'nullable|numeric',
            'total_price' => 'required|numeric|min:0',
            'payment'     => 'required|numeric|min:0',
            'due'         => 'required|numeric|min:0',
            'vendor_id'         => 'required|exists:vendors,id',
        ]);

    

        $purchase = Purchase::findOrFail($purchase->id);
        $inventory = Inventory::where('product_id', $purchase->product_id)->first();
        if ($inventory) {
            $inventory->current_stock -= $purchase->quantity;
            $inventory->current_stock += $request->quantity;
            $inventory->update();        
        }else{
            $newInventory  = new Inventory();
            $newInventory->product_id = $request->product_id;
            $newInventory->current_stock = $request->quantity;
            $newInventory->opening_stock = $request->quantity;
            $newInventory->notes = 'Opening stock entry';
            $newInventory->save();
        }
        $purchase->product_id  = $request->product_id;
        $purchase->quantity    = $request->quantity;
        $purchase->unit_price  = $request->unit_price;
        $purchase->sub_price   = $request->sub_price ?? ($request->quantity * $request->unit_price);
        $purchase->total_price = $request->total_price;
        $purchase->payment     = $request->payment;
        $purchase->due         = $request->due;
        $purchase->vendor_id         = $request->vendor_id;    
        $purchase->updated_by  = Auth::id();

        $purchase->update();

        return redirect()->back()->with('success', 'Purchase updated and inventory adjusted successfully.');
    }


    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Purchase $purchase)
    {
        $purchase->delete();
        return redirect()->back()->with('success', 'Purchase deleted successfully.');
    }

    public function getLatestPrice($id)
    {
        $product = Product::with('latestPurchase')->find($id);

        if (!$product) {
            return response()->json(['price' => 0]);
        }

        $price = $product->latestPurchase ? $product->latestPurchase->unit_price : 0;

        return response()->json(['price' => $price]);
    }




    public function reportIndex(Request $request)
    {
        $query = Purchase::query();
        $hasFilters = $request->filled('vendor_id') || $request->filled('item_name') || $request->filled('from') || $request->filled('to');

        if (!$hasFilters) {
            $query->whereBetween('created_at', [
                Carbon::now()->startOfMonth(),
                Carbon::now()->endOfMonth(),
            ]);
        } else {
            $query = $this->applyPurchaseReportFilters($query, $request);
        }

        $purchases = $query
            ->selectRaw('product_id, SUM(quantity) as total_qty, SUM(total_price) as total_amount')
            ->groupBy('product_id')
            ->with('product')
            ->get();

        $products = Product::with('brand')->latest()->get();
        $vendors = Vendor::latest()->get();

        return view('frontend.pages.report.purchase.index', compact('purchases', 'products', 'vendors'));
    }


    public function report(Request $request)
    {
        $query = Purchase::query();
        $query = $this->applyPurchaseReportFilters($query, $request);

        $purchases = $query
            ->selectRaw('product_id, SUM(quantity) as total_qty, SUM(total_price) as total_amount')
            ->groupBy('product_id')
            ->with('product')
            ->get();

        $products = Product::latest()->get();
        $vendors = Vendor::latest()->get();

        return view('frontend.pages.report.purchase.index', compact('purchases', 'products', 'vendors', 'request'));
    }

    public function reportPdf(Request $request)
    {
        $query = Purchase::query();
        $query = $this->applyPurchaseReportFilters($query, $request);

        $purchases = $query
            ->selectRaw('product_id, SUM(quantity) as total_qty, SUM(total_price) as total_amount')
            ->groupBy('product_id')
            ->with('product')
            ->get();

        $products = Product::latest()->get();
        $vendors = Vendor::latest()->get();

        $filters = [
            'from' => $request->filled('from') ? $request->from : Carbon::now()->startOfMonth()->format('Y-m-d'),
            'to' => $request->filled('to') ? $request->to : Carbon::now()->endOfMonth()->format('Y-m-d'),
            'product' => $request->filled('item_name') ? Product::find($request->item_name)?->name : 'All Products',
            'vendor' => $request->filled('vendor_id') ? Vendor::find($request->vendor_id)?->name : 'All Vendors',
        ];

        $pdf = Pdf::loadView('frontend.pages.report.purchase.pdf', compact('purchases', 'filters'));

        return $pdf->download('purchase-report-' . now()->format('Y-m-d') . '.pdf');
    }

    private function applyPurchaseReportFilters($query, Request $request)
    {
        if ($request->filled('vendor_id')) {
            $query->where('vendor_id', $request->vendor_id);
        }

        if ($request->filled('item_name')) {
            $query->where('product_id', $request->item_name);
        }

        if ($request->filled('from')) {
            $query->whereDate('created_at', '>=', $request->from);
        }

        if ($request->filled('to')) {
            $query->whereDate('created_at', '<=', $request->to);
        }

        return $query;
    }

}
