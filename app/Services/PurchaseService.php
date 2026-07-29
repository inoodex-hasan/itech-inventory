<?php

namespace App\Services;

use App\Models\Inventory;
use App\Models\Product;
use App\Models\ProductSerial;
use App\Models\Purchase;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class PurchaseService
{
    public function __construct(private InventoryService $inventoryService) {}

    /**
     * Create a purchase, register serials, and update inventory — all in one transaction.
     */
    public function createPurchase(array $data): Purchase
    {
        return DB::transaction(function () use ($data) {

            // 1. Create the purchase record
            $purchase = Purchase::create([
                'product_id'  => $data['product_id'],
                'vendor_id'   => $data['vendor_id'],
                'quantity'    => $data['quantity'],
                'unit_price'  => $data['unit_price'],
                'sub_price'   => $data['sub_price'] ?? ($data['quantity'] * $data['unit_price']),
                'total_price' => $data['total_price'],
                'payment'     => $data['payment'],
                'due'         => $data['due'],
                'created_by'  => Auth::id(),
            ]);

            // 2. Register serial numbers if product is serialized
            $product = Product::find($data['product_id']);
            if ($product && $product->is_serialized) {
                $serials = $this->collectSerials($data);
                $this->inventoryService->registerSerials(
                    $product->id,
                    $purchase->id,
                    $serials,
                    $data['quantity']
                );
            }

            // 3. Increment inventory stock
            $this->inventoryService->incrementStock(
                $data['product_id'],
                $data['quantity'],
                'Stock added via purchase #' . $purchase->id
            );

            return $purchase;
        });
    }

    /**
     * Collect all serial numbers from both individual inputs and bulk textarea.
     */
    private function collectSerials(array $data): array
    {
        $serials = [];

        if (!empty($data['serial_numbers'])) {
            $serials = array_merge($serials, (array) $data['serial_numbers']);
        }

        if (!empty($data['serial_bulk'])) {
            $bulk    = $this->inventoryService->parseBulkSerials($data['serial_bulk']);
            $serials = array_merge($serials, $bulk);
        }

        return $serials;
    }
}
