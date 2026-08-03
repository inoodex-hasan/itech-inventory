<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Inventory Stock Report</title>
    <style>
        @page {
            margin: 140px 45px 80px 45px;
            size: A4 portrait;
        }
        .pdf-bg-pad {
            position: fixed;
            top: -140px;
            left: -45px;
            width: 210mm;
            height: 297mm;
            z-index: -1000;
        }
        .pdf-bg-pad img {
            width: 210mm;
            height: 297mm;
        }
        body {
            font-family: DejaVu Sans, Arial, sans-serif;
            font-size: 10px;
            color: #1e293b;
            margin: 0;
            padding: 0;
        }
        .header {
            width: 100%;
            margin-bottom: 12px;
            border-bottom: 2px solid #4f46e5;
            padding-bottom: 10px;
        }
        .company-name {
            font-size: 18px;
            font-weight: bold;
            color: #4f46e5;
        }
        .report-title {
            font-size: 14px;
            font-weight: bold;
            text-transform: uppercase;
            color: #0f172a;
            margin-top: 3px;
        }
        .meta-info {
            font-size: 9px;
            color: #64748b;
            margin-top: 4px;
        }

        /* Summary Table - Pixel-perfect alignment with Inventory Table */
        table.summary-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 15px;
        }
        table.summary-table td {
            background-color: #f8fafc;
            border: 1px solid #cbd5e1;
            padding: 8px 12px;
            font-size: 10px;
            color: #334155;
            vertical-align: middle;
        }
        .summary-value {
            font-weight: bold;
            font-size: 11px;
            color: #4f46e5;
        }

        /* Main Inventory Table */
        table.inventory-table {
            width: 100%;
            border-collapse: collapse;
        }
        table.inventory-table th {
            background-color: #f1f5f9;
            color: #334155;
            font-weight: bold;
            font-size: 9px;
            text-transform: uppercase;
            border: 1px solid #cbd5e1;
            padding: 7px 8px;
            text-align: left;
        }
        table.inventory-table td {
            border: 1px solid #e2e8f0;
            padding: 6px 8px;
            font-size: 9px;
            vertical-align: top;
        }
        table.inventory-table tr:nth-child(even) {
            background-color: #f8fafc;
        }

        .text-left { text-align: left; }
        .text-end { text-align: right; }
        .text-center { text-align: center; }
        .fw-bold { font-weight: bold; }
        
        .badge {
            display: inline-block;
            padding: 2px 6px;
            border-radius: 4px;
            font-size: 8px;
            font-weight: bold;
            text-transform: uppercase;
        }
        .badge-success { background-color: #dcfce7; color: #15803d; }
        .badge-warning { background-color: #fef3c7; color: #b45309; }
        .badge-danger { background-color: #fee2e2; color: #b91c1c; }

        .footer {
            margin-top: 30px;
            width: 100%;
            font-size: 8px;
            color: #94a3b8;
            text-align: center;
            border-top: 1px solid #e2e8f0;
            padding-top: 8px;
        }
    </style>
</head>
<body>
    <div class="pdf-bg-pad">
        <img src="{{ public_path('assets/invoice/final_pad.png') }}" />
    </div>

    <div class="header">
        <table width="100%">
            <tr>
                <td>
                    <div class="company-name">Intelligent Technology</div>
                    <div style="font-size: 9px; color: #475569;">Inventory &amp; Sales Management System</div>
                </td>
                <td class="text-end">
                    <div class="report-title">Inventory Stock Report</div>
                    <div class="meta-info">Generated on: {{ date('d M Y') }}</div>
                </td>
            </tr>
        </table>
    </div>

    <!-- Summary Section (Aligned pixel-perfectly with main table) -->
    <table class="summary-table">
        <tr>
            <td width="25%" class="text-left">
                <strong>Total Items:</strong> <span class="summary-value">{{ count($inventories) }}</span>
            </td>
            <td width="25%" class="text-center">
                <strong>In Stock:</strong> <span style="color: #15803d; font-weight: bold; font-size: 11px;">{{ $inventories->where('current_stock', '>', 5)->count() }}</span>
            </td>
            <td width="25%" class="text-center">
                <strong>Low Stock:</strong> <span style="color: #b45309; font-weight: bold; font-size: 11px;">{{ $inventories->where('current_stock', '<=', 5)->where('current_stock', '>', 0)->count() }}</span>
            </td>
            <td width="25%" class="text-end">
                <strong>Out of Stock:</strong> <span style="color: #b91c1c; font-weight: bold; font-size: 11px;">{{ $inventories->where('current_stock', '<=', 0)->count() }}</span>
            </td>
        </tr>
    </table>

    <!-- Main Data Table -->
    <table class="inventory-table">
        <thead>
            <tr>
                <th width="5%" class="text-center">#</th>
                <th width="35%">Product Name &amp; Model</th>
                <th width="15%">Brand</th>
                <th width="15%" class="text-center">Opening Stock</th>
                <th width="15%" class="text-center">Current Stock</th>
                <th width="15%" class="text-center">Stock Status</th>
            </tr>
        </thead>
        <tbody>
            @forelse($inventories as $index => $inv)
                @php
                    $prodName = $inv->product->name ?? 'N/A';
                    $prodModel = $inv->product->model ?? '';
                    $brandName = $inv->product->brand->name ?? 'N/A';
                    $stock = $inv->current_stock ?? 0;
                @endphp
                <tr>
                    <td class="text-center">{{ $index + 1 }}</td>
                    <td class="fw-bold">
                        {{ $prodName }}
                        @if($prodModel)
                            <div style="font-weight: normal; font-size: 8px; color: #64748b;">Model: {{ $prodModel }}</div>
                        @endif
                    </td>
                    <td>{{ $brandName }}</td>
                    <td class="text-center">{{ number_format($inv->opening_stock ?? 0) }}</td>
                    <td class="text-center fw-bold">{{ number_format($stock) }}</td>
                    <td class="text-center">
                        @if($stock > 5)
                            <span class="badge badge-success">In Stock</span>
                        @elseif($stock > 0)
                            <span class="badge badge-warning">Low Stock</span>
                        @else
                            <span class="badge badge-danger">Out of Stock</span>
                        @endif
                    </td>
                </tr>
            @empty
                <tr>
                    <td colspan="6" class="text-center" style="padding: 20px; color: #64748b;">No inventory items found.</td>
                </tr>
            @endforelse
        </tbody>
    </table>

    <div class="footer">
        Intelligent Technology Inventory System &bull; Confidential Inventory Stock Report
    </div>
</body>
</html>
