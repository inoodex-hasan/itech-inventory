<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Sales Report</title>
    @php
        $toFileUrl = function ($path) {
            return 'file:///' . str_replace(['\\', ' '], ['/', '%20'], public_path($path));
        };
    @endphp
    <style>
        @page {
            background-image: url('{{ $toFileUrl('assets/invoice/final_pad.png') }}');
            background-image-resize: 6;
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: Arial, sans-serif;
            font-size: 12px;
            color: #333;
            background: url('{{ $toFileUrl('assets/invoice/final_pad.png') }}') no-repeat center top / 100% 100% fixed transparent !important;
        }
        .header-table { width: 100%; margin-bottom: 20px; }
        .header-table td { vertical-align: top; padding: 4px; }
        .report-title { text-align: right; }
        .report-title h1 {
            font-size: 28px;
            font-weight: bold;
            letter-spacing: 2px;
        }
        .report-title p { font-size: 12px; margin-top: 6px; }
        .filter-info {
            font-size: 11px;
            color: #666;
            margin-bottom: 15px;
            padding: 8px 10px;
            background: #fafafa;
            border: 1px solid #ddd;
        }
        .items-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .items-table thead tr { background-color: #626262; }
        .items-table th {
            background-color: #626262;
            color: #fff !important;
        }
        .items-table th,
        .items-table td {
            border: 1px solid #ccc;
            padding: 7px 10px;
            text-align: left;
            font-size: 11px;
        }
        .items-table tbody tr:nth-child(even) { background-color: #f9f9f9; }
        .in-words {
            font-size: 12px;
            margin-bottom: 30px;
            padding: 8px 10px;
            border: 1px solid #ddd;
            background: #fafafa;
            text-align: center;
        }
        .signature-table { width: 100%; margin-top: 40px; }
        .signature-table td {
            text-align: center;
            font-size: 11px;
            width: 50%;
            padding: 0 40px;
        }
        hr.signature-line {
            border: none;
            border-top: 1px solid #333;
            margin: 0 0 6px 0;
        }
        .text-right { text-align: right; }
    </style>
</head>
<body>
    <table class="header-table" cellpadding="0" cellspacing="0">
        <tr>
            <td style="width:50%;"></td>
            <td style="width:50%;" class="report-title">
                <h1>SALES REPORT</h1>
                <p>Generated: {{ now()->format('d-m-Y') }}</p>
            </td>
        </tr>
    </table>

    <div class="filter-info">
        @if ($request->customer_id)
            Customer ID: {{ $request->customer_id }} |
        @else
            All Customers |
        @endif
        @if ($request->item_name)
            Product ID: {{ $request->item_name }} |
        @endif
        @if ($request->from)
            From: {{ $request->from }} |
        @endif
        @if ($request->to)
            To: {{ $request->to }} |
        @endif
        Total: {{ $salesReport->count() }} item(s)
    </div>

    <table class="items-table" cellpadding="0" cellspacing="0">
        <thead>
            <tr>
                <th>SL</th>
                <th>Customer</th>
                <th>Product</th>
                <th>Qty</th>
                <th>Unit Price</th>
                <th>Total</th>
            </tr>
        </thead>
        <tbody>
            @forelse ($salesReport as $item)
                <tr>
                    <td>{{ $loop->index + 1 }}</td>
                    <td>{{ $item->customer_name ?? 'N/A' }}</td>
                    <td>{{ $item->product_name ?? 'N/A' }}</td>
                    <td>{{ $item->qty }}</td>
                    <td>{{ number_format($item->unit_price, 2) }}</td>
                    <td>{{ number_format($item->total_price, 2) }}</td>
                </tr>
            @empty
                <tr>
                    <td colspan="6" style="text-align:center;">No data available</td>
                </tr>
            @endforelse
        </tbody>
    </table>

    <div class="in-words">
        <strong>Total Items:</strong> {{ $salesReport->count() }} |
        <strong>Total Amount:</strong> {{ number_format($salesReport->sum('total_price'), 2) }} Tk
    </div>

    {{-- <table class="signature-table" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <hr class="signature-line">
                Authorized Signature
            </td>
        </tr>
    </table> --}}
</body>
</html>