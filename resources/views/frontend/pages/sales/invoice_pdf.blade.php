<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <title>Invoice</title>
    @php
        $toFileUrl = function ($path) {
            return 'file:///' . str_replace(['\\', ' '], ['/', '%20'], public_path($path));
        };
    @endphp
    <style>
        /* ── mPDF: page background image ── */
        @page {
            background-image: url('{{ $toFileUrl('assets/invoice/invoice-bg.jpg') }}');
            background-image-resize: 6;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            font-size: 12px;
            color: #333;
        }

        /* ── Header ── */
        .header-table {
            width: 100%;
            margin-bottom: 20px;
        }

        .header-table td {
            vertical-align: top;
            padding: 4px;
        }

        .invoice-title {
            text-align: right;
        }

        .invoice-title h1 {
            font-size: 28px;
            font-weight: bold;
            letter-spacing: 2px;
        }

        .invoice-title p {
            font-size: 12px;
            margin-top: 4px;
        }

        /* ── Customer details ── */
        .details-table {
            width: 100%;
            margin-bottom: 20px;
        }

       .details-table td {
            padding: 6px 6px;
            font-size: 12px;
            vertical-align: top;
        }

        .details-table .value {
            border-bottom: 1px solid #ccc;
            width: 100%;
        }

        .details-table .label {
            font-weight: bold;
            width: 80px;
            color: #555;
        }

        /* ── Items table ── */
        .items-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .items-table thead tr {
            background-color: #626262;
        }

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

        .items-table tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        /* ── Returns section ── */
        .returns-section {
            margin-top: 20px;
            border: 1px dashed #dc3545;
            padding: 15px;
            background: #fff5f5;
            margin-bottom: 20px;
        }

        .returns-section h4 {
            color: #dc3545;
            margin-bottom: 10px;
            font-size: 13px;
        }

        .returns-table {
            width: 100%;
            border-collapse: collapse;
        }

        .returns-table th,
        .returns-table td {
            border: 1px solid #f5c6cb;
            padding: 6px 8px;
            font-size: 11px;
        }

        .returns-table thead tr {
            background-color: #626262;
        }

        .returns-table th {
            background-color: #626262;
            color: #fff !important;
        }

        .returns-table tfoot tr {
            background-color: #ffe0e0;
            font-weight: bold;
        }

        /* ── Totals + Terms row ── */
        .bottom-table {
            width: 100%;
            margin-bottom: 15px;
        }

        .bottom-table > tbody > tr > td {
            vertical-align: top;
            padding: 0 6px;
        }

        /* ── Terms & Conditions ── */
        .conditions h2 {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 16px;
            color: #111;
        }

        .conditions p {
            font-size: 13px;
            margin-bottom: 12px;
            line-height: 1.7;
            color: #333;
        }

        /* ── Totals sub-table ── */
        .totals-table {
            width: 100%;
            border-collapse: collapse;
        }

        .totals-table td {
            padding: 7px 10px;
            font-size: 12px;
            border-bottom: 1px solid #e8e8e8;
            color: #333;
        }

        .totals-table .text-right {
            text-align: right;
        }

        .totals-table .row-strikethrough td {
            text-decoration: line-through;
            color: #999;
        }

        .totals-table .row-refund td {
            color: #dc3545;
        }

        .totals-table .row-due td {
            background-color: #2d3748;
            color: #ffffff;
            font-weight: bold;
            font-size: 13px;
            border-bottom: none;
        }

        /* ── In-words ── */
        .in-words {
            font-size: 12px;
            margin-bottom: 30px;
            padding: 8px 10px;
            border: 1px solid #ddd;
            background: #fafafa;
            text-align: center;
        }

        /* ── Signature ── */
        .signature-table {
            width: 100%;
            margin-top: 40px;
        }

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

        /* ── Utility ── */
        .text-right { text-align: right; }
    </style>
</head>

<body>

    {{-- ═══════════════════════════════════════════
         HEADER: logo (left) | invoice info (right)
    ═══════════════════════════════════════════ --}}
    <table class="header-table" cellpadding="0" cellspacing="0">
        <tr>
            <td style="width:50%;">
                {{-- <img src="{{ $toFileUrl('assets/invoice/logo.png') }}" height="60" alt="Logo"> --}}
            </td>
            <td style="width:50%;" class="invoice-title">
                <h1>INVOICE</h1>
                <p>Invoice No: {{ $sales->order_no }}</p>
                <p>Invoice Date: {{ $sales->created_at->format('d-m-Y') }}</p>
            </td>
        </tr>
    </table>

    {{-- ═══════════════════════════════════════════
         CUSTOMER DETAILS
    ═══════════════════════════════════════════ --}}
    <table class="details-table" cellpadding="0" cellspacing="0">
       <tr>
        <td class="label">Customer:</td>
        <td class="value">{{ $customer->name }}</td>
    </tr>
    <tr>
        <td class="label">Phone:</td>
        <td class="value">{{ $customer->phone }}</td>
    </tr>
    <tr>
        <td class="label">Address:</td>
        <td class="value">{{ $customer->address }}</td>
    </tr>
    </table>

    {{-- ═══════════════════════════════════════════
         ITEMS TABLE
    ═══════════════════════════════════════════ --}}
    <table class="items-table" cellpadding="0" cellspacing="0">
        <thead>
            <tr>
                <th>SL</th>
                <th>Item Names</th>
                <th>Qty</th>
                <th>Price</th>
                <th>Total Price</th>
            </tr>
        </thead>
        <tbody>
            @foreach ($items as $item)
                <tr>
                    <td>{{ $loop->index + 1 }}</td>
                    <td>{{ $item->name }}</td>
                    <td>{{ $item->qty ?? 'N/A' }}</td>
                    <td>{{ $item->unit_price ? number_format($item->unit_price, 2) : 'N/A' }}</td>
                    <td>{{ $item->total_price ? number_format($item->total_price, 2) : 'N/A' }}</td>
                </tr>
            @endforeach
        </tbody>
    </table>

    {{-- ═══════════════════════════════════════════
         RETURNS SECTION (only shown when present)
    ═══════════════════════════════════════════ --}}
    @php
        $completedReturns  = $returns->where('status', 'completed');
        $totalRefundAmount = $completedReturns->sum(function ($return) {
            return $return->total_refund_amount ?? $return->items->sum('total_price');
        });
        $hasReturns = $completedReturns->count() > 0;
    @endphp

    @if ($hasReturns)
    <div class="returns-section">
        <h4>Returned Items</h4>
        <table class="returns-table" cellpadding="0" cellspacing="0">
            <thead>
                <tr>
                    <th>Return #</th>
                    <th>Product</th>
                    <th>Qty Returned</th>
                    <th>Reason</th>
                    <th>Condition</th>
                    <th>Refund Amount</th>
                </tr>
            </thead>
            <tbody>
                @foreach ($completedReturns as $return)
                    @foreach ($return->items as $returnItem)
                        <tr>
                            <td>#{{ $return->id }}</td>
                            <td>{{ $returnItem->product->name ?? 'N/A' }}</td>
                            <td>{{ $returnItem->quantity }}</td>
                            <td>{{ $returnItem->reason_label }}</td>
                            <td>{{ $returnItem->condition_label }}</td>
                            <td>{{ number_format($returnItem->total_price, 2) }} Tk</td>
                        </tr>
                    @endforeach
                @endforeach
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="5" class="text-right">Total Refund:</td>
                    <td>{{ number_format($totalRefundAmount, 2) }} Tk</td>
                </tr>
            </tfoot>
        </table>
    </div>
    @endif

    {{-- ═══════════════════════════════════════════
         TERMS & CONDITIONS  |  TOTALS
    ═══════════════════════════════════════════ --}}
    <table class="bottom-table" cellpadding="0" cellspacing="0">
        <tr>
            {{-- Terms --}}
            <td style="width:55%;">
                <div class="conditions">
                    <h2>Terms &amp; Conditions</h2> <br>
                    <p>1. Products can be returned within 7 days in their original, unopened condition.</p> <br>
                    <p>2. Refunds or exchanges are offered, but perishable goods cannot be returned.</p> <br>
                    <p>Contact us at <strong>01904400205</strong> with a valid receipt for assistance.</p>
                </div>
            </td>

            {{-- Totals --}}
            <td style="width:45%;">
                <table class="totals-table" cellpadding="0" cellspacing="0">

                    @if ($hasReturns)
                    <tr class="row-strikethrough">
                        <td>Original Sub Total:</td>
                        <td class="text-right">{{ number_format($sales->bill + $totalRefundAmount, 2) }} Tk</td>
                    </tr>
                    <tr class="row-refund">
                        <td>Returns / Refund:</td>
                        <td class="text-right">- {{ number_format($totalRefundAmount, 2) }} Tk</td>
                    </tr>
                    @endif

                    <tr>
                        <td>Sub Total:</td>
                        <td class="text-right">{{ number_format($sales->bill, 2) }} Tk</td>
                    </tr>

                    @if (($sales->vat ?? 0) > 0)
                        @php $vatAmount = ($sales->bill * $sales->vat) / 100; @endphp
                        <tr>
                            <td>VAT ({{ number_format($sales->vat, 2) }}%):</td>
                            <td class="text-right">{{ number_format($vatAmount, 2) }} Tk</td>
                        </tr>
                    @endif

                    @if (($sales->tax ?? 0) > 0)
                        @php $taxAmount = ($sales->bill * $sales->tax) / 100; @endphp
                        <tr>
                            <td>Tax ({{ number_format($sales->tax, 2) }}%):</td>
                            <td class="text-right">{{ number_format($taxAmount, 2) }} Tk</td>
                        </tr>
                    @endif

                    @if (($sales->delivery_charge ?? 0) > 0)
                        <tr>
                            <td>Delivery Charge:</td>
                            <td class="text-right">{{ number_format($sales->delivery_charge, 2) }} Tk</td>
                        </tr>
                    @endif

                    <tr>
                        <td>Discount:</td>
                        <td class="text-right">{{ number_format($sales->discount ?? 0, 2) }} Tk</td>
                    </tr>
                    <tr>
                        <td>Total:</td>
                        <td class="text-right">{{ number_format($sales->payble, 2) }} Tk</td>
                    </tr>
                    <tr>
                        <td>Received:</td>
                        <td class="text-right">{{ number_format($sales->advanced_payment ?? 0, 2) }} Tk</td>
                    </tr>
                    <tr class="row-due">
                        <td>Total Due:</td>
                        <td class="text-right">{{ number_format($sales->due_payment ?? 0, 2) }} Tk</td>
                    </tr>

                </table>
            </td>
        </tr>
    </table>

    {{-- ═══════════════════════════════════════════
         AMOUNT IN WORDS
    ═══════════════════════════════════════════ --}}
    <div class="in-words">
        <strong>In Words:</strong>
        @php $totalAmount = $sales->bill ?? 0; @endphp
        {{ numberToWords($totalAmount) }} Taka Only
    </div>

    {{-- ═══════════════════════════════════════════
         SIGNATURES
    ═══════════════════════════════════════════ --}}
    <table class="signature-table" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <hr class="signature-line">
                Customer Signature
            </td>
            <td>
                <hr class="signature-line">
                Authorized Signature
            </td>
        </tr>
    </table>

</body>
</html>