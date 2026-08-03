<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Monthly Revenue Report</title>
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

        /* Summary Table - Pixel-perfect alignment with Revenue Table */
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

        /* Main Revenue Table */
        table.revenue-table {
            width: 100%;
            border-collapse: collapse;
        }
        table.revenue-table th {
            background-color: #f1f5f9;
            color: #334155;
            font-weight: bold;
            font-size: 9px;
            text-transform: uppercase;
            border: 1px solid #cbd5e1;
            padding: 7px 8px;
            text-align: left;
        }
        table.revenue-table td {
            border: 1px solid #e2e8f0;
            padding: 6px 8px;
            font-size: 9px;
            vertical-align: top;
        }
        table.revenue-table tr:nth-child(even) {
            background-color: #f8fafc;
        }

        .text-left { text-align: left; }
        .text-end { text-align: right; }
        .text-center { text-align: center; }
        .fw-bold { font-weight: bold; }

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
                    <div class="report-title">Monthly Revenue Report</div>
                    <div class="meta-info">Generated on: {{ date('d M Y, h:i A') }}</div>
                </td>
            </tr>
        </table>
    </div>

    <!-- Summary Section (Aligned pixel-perfectly with main table) -->
    <table class="summary-table">
        <tr>
            <td width="20%" class="text-left">
                <strong>Periods:</strong> <span class="summary-value">{{ count($revenues) }} Mos</span>
            </td>
            <td width="25%" class="text-center">
                <strong>Total Sales:</strong> <span style="color: #4f46e5; font-weight: bold; font-size: 11px;">৳{{ number_format($revenues->sum('total_sales'), 2) }}</span>
            </td>
            <td width="25%" class="text-center">
                <strong>Total Expenses:</strong> <span style="color: #b45309; font-weight: bold; font-size: 11px;">৳{{ number_format($revenues->sum('total_expenses') + $revenues->sum('total_purchases'), 2) }}</span>
            </td>
            <td width="30%" class="text-end">
                @php
                    $netProfit = $revenues->sum('total_sales') - ($revenues->sum('total_purchases') + $revenues->sum('total_expenses'));
                @endphp
                <strong>Total Net Profit:</strong> <span style="color: {{ $netProfit >= 0 ? '#15803d' : '#b91c1c' }}; font-weight: bold; font-size: 11px;">৳{{ number_format($netProfit, 2) }}</span>
            </td>
        </tr>
    </table>

    <!-- Main Data Table -->
    <table class="revenue-table">
        <thead>
            <tr>
                <th width="5%" class="text-center">#</th>
                <th width="20%">Month / Year</th>
                <th width="20%" class="text-end">Total Sales (৳)</th>
                <th width="20%" class="text-end">Purchases (৳)</th>
                <th width="15%" class="text-end">Expenses (৳)</th>
                <th width="20%" class="text-end">Net Profit (৳)</th>
            </tr>
        </thead>
        <tbody>
            @forelse($revenues as $index => $rev)
                @php
                    $monthName = DateTime::createFromFormat('!m', $rev->month)->format('F');
                    $profit = $rev->total_sales - ($rev->total_purchases + $rev->total_expenses);
                @endphp
                <tr>
                    <td class="text-center">{{ $index + 1 }}</td>
                    <td class="fw-bold">{{ $monthName }} {{ $rev->year }}</td>
                    <td class="text-end">{{ number_format($rev->total_sales, 2) }}</td>
                    <td class="text-end">{{ number_format($rev->total_purchases, 2) }}</td>
                    <td class="text-end">{{ number_format($rev->total_expenses, 2) }}</td>
                    <td class="text-end fw-bold" style="color: {{ $profit >= 0 ? '#15803d' : '#b91c1c' }};">
                        {{ number_format($profit, 2) }}
                    </td>
                </tr>
            @empty
                <tr>
                    <td colspan="6" class="text-center" style="padding: 20px; color: #64748b;">No monthly revenue records found.</td>
                </tr>
            @endforelse
        </tbody>
    </table>

    <div class="footer">
        Intelligent Technology Inventory System &bull; Confidential Monthly Revenue Report
    </div>
</body>
</html>
