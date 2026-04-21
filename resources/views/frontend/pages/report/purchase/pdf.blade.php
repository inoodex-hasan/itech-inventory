<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Purchase Report</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: Arial, sans-serif;
            font-size: 12px;
            line-height: 1.4;
            color: #333;
            padding: 20px;
        }
        .header {
            text-align: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #333;
        }
        .header h1 {
            font-size: 20px;
            margin-bottom: 5px;
        }
        .header p {
            font-size: 10px;
            color: #666;
        }
        .filters {
            margin-bottom: 15px;
            padding: 10px;
            background: #f5f5f5;
            border-radius: 4px;
        }
        .filters table {
            width: 100%;
            font-size: 10px;
        }
        .filters td {
            padding: 3px 10px;
        }
        .filters .label {
            font-weight: bold;
            width: 100px;
        }
        table.data-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        table.data-table th,
        table.data-table td {
            border: 1px solid #333;
            padding: 8px;
            text-align: left;
        }
        table.data-table th {
            background: #333;
            color: #fff;
            font-weight: bold;
        }
        table.data-table tr:nth-child(even) {
            background: #f9f9f9;
        }
        .text-right {
            text-align: right;
        }
        .text-center {
            text-align: center;
        }
        .footer {
            margin-top: 20px;
            text-align: center;
            font-size: 9px;
            color: #666;
            border-top: 1px solid #ddd;
            padding-top: 10px;
        }
        .summary {
            margin-top: 15px;
            text-align: right;
            font-size: 11px;
        }
        .summary strong {
            font-size: 12px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Purchase Report</h1>
        <p>Generated on: {{ now()->format('F d, Y h:i A') }}</p>
    </div>

    <div class="filters">
        <table>
            <tr>
                <td class="label">Date Range:</td>
                <td>{{ $filters['from'] }} to {{ $filters['to'] }}</td>
                <td class="label">Product:</td>
                <td>{{ $filters['product'] }}</td>
            </tr>
            <tr>
                <td class="label">Vendor:</td>
                <td>{{ $filters['vendor'] }}</td>
                <td></td>
                <td></td>
            </tr>
        </table>
    </div>

    <table class="data-table">
        <thead>
            <tr>
                <th style="width: 50px;">#</th>
                <th>Product Name</th>
                <th style="width: 120px;" class="text-center">Total Quantity</th>
                <th style="width: 150px;" class="text-right">Total Amount</th>
            </tr>
        </thead>
        <tbody>
            @forelse($purchases as $index => $purchase)
                <tr>
                    <td class="text-center">{{ $index + 1 }}</td>
                    <td>{{ $purchase->product->name ?? 'N/A' }}</td>
                    <td class="text-center">{{ $purchase->total_qty }}</td>
                    <td class="text-right">{{ number_format($purchase->total_amount, 2) }}</td>
                </tr>
            @empty
                <tr>
                    <td colspan="4" class="text-center">No data available</td>
                </tr>
            @endforelse
        </tbody>
    </table>

    <div class="summary">
        <strong>Grand Total: {{ number_format($purchases->sum('total_amount'), 2) }}</strong><br>
        Total Quantity: {{ $purchases->sum('total_qty') }}
    </div>

    <div class="footer">
        <p>This is a computer-generated report. No signature required.</p>
    </div>
</body>
</html>
