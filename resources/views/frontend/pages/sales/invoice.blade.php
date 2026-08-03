<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Invoice #{{ $sales->order_no }}</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, 'Helvetica Neue', Helvetica, sans-serif;
        }

        body {
            background-color: #f1f5f9;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
            padding: 30px 15px;
            color: #0f172a;
        }

        .no-print-bar {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
            display: flex;
            gap: 12px;
        }

        .btn-action {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: #4f46e5;
            color: #ffffff;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            box-shadow: 0 4px 14px rgba(79, 70, 229, 0.35);
            transition: all 0.2s ease;
        }

        .btn-action:hover {
            background: #4338ca;
            transform: translateY(-2px);
        }

        .btn-secondary {
            background: #0f172a;
            box-shadow: 0 4px 14px rgba(15, 23, 42, 0.25);
        }

        .a4-container {
            width: 210mm;
            min-height: 297mm;
            background: #ffffff;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.08);
            border-radius: 4px;
            margin: 0 auto;
            padding: 145px 45px 50px 45px;
            position: relative;
            background-image: url('{{ asset('assets/invoice/final_pad.png') }}');
            background-size: 100% 100%;
            background-position: center top;
            background-repeat: no-repeat;
        }

        @media print {
            body {
                background: none;
                padding: 0;
                margin: 0;
            }

            .no-print-bar {
                display: none !important;
            }

            .a4-container {
                box-shadow: none !important;
                border-radius: 0;
                width: 100%;
                height: 100%;
                margin: 0;
                padding: 145px 45px 40px 45px;
                -webkit-print-color-adjust: exact !important;
                print-color-adjust: exact !important;
            }
        }
    </style>
</head>

<body>

    <div class="no-print-bar">
        <a href="{{ route('sales.invoice.pdf', $sales->id) }}" class="btn-action btn-secondary" target="_blank">
            <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path></svg>
            Download PDF
        </a>
        <button class="btn-action" onclick="window.print()">
            <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 17h2a2 2 0 002-2v-4a2 2 0 00-2-2H5a2 2 0 00-2 2v4a2 2 0 002 2h2m2 4h6a2 2 0 002-2v-4a2 2 0 00-2-2H9a2 2 0 00-2 2v4a2 2 0 002 2zm8-12V5a2 2 0 00-2-2H9a2 2 0 00-2 2v4h10z"></path></svg>
            Print Invoice
        </button>
    </div>

    <div class="a4-container">
        
        <!-- Header Title & Order Meta -->
        <table style="width: 100%; margin-bottom: 20px; border-bottom: 2px solid #e2e8f0; padding-bottom: 12px;">
            <tr>
                <td align="right">
                    <h1 style="font-size: 26px; font-weight: 800; color: #0f172a; margin-bottom: 4px;">INVOICE</h1>
                    <div style="font-size: 15px; font-weight: 700; color: #4f46e5;">Invoice No: #{{ $sales->order_no }}</div>
                    <div style="font-size: 12px; color: #64748b; margin-top: 3px;">Invoice Date: {{ $sales->created_at ? $sales->created_at->format('d M Y') : date('d M Y') }}</div>
                </td>
            </tr>
        </table>

        <!-- Customer Info Card -->
        <table style="width: 100%; border-collapse: separate; border-spacing: 0; background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 10px; margin-bottom: 25px;">
            <tr>
                <td style="padding: 14px 18px; width: 33.33%; vertical-align: top;">
                    <div style="font-size: 9px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.8px; color: #64748b; margin-bottom: 4px;">CUSTOMER / CLIENT</div>
                    <div style="font-size: 13px; font-weight: 700; color: #0f172a;">{{ $customer->name ?? 'N/A' }}</div>
                </td>
                <td style="padding: 14px 18px; width: 33.33%; vertical-align: top; border-left: 1px solid #e2e8f0;">
                    <div style="font-size: 9px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.8px; color: #64748b; margin-bottom: 4px;">PHONE NUMBER</div>
                    <div style="font-size: 13px; font-weight: 700; color: #0f172a;">{{ $customer->phone ?? 'N/A' }}</div>
                </td>
                <td style="padding: 14px 18px; width: 33.33%; vertical-align: top; border-left: 1px solid #e2e8f0;">
                    <div style="font-size: 9px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.8px; color: #64748b; margin-bottom: 4px;">ADDRESS / LOCATION</div>
                    <div style="font-size: 13px; font-weight: 700; color: #0f172a;">{{ $customer->address ?? 'N/A' }}</div>
                </td>
            </tr>
        </table>

        <!-- Items Table -->
        <table style="width: 100%; border-collapse: collapse; margin-bottom: 25px; border: 1px solid #e2e8f0; border-radius: 8px; overflow: hidden;">
            <thead>
                <tr style="background: #1e293b; color: #ffffff;">
                    <th style="padding: 10px 14px; font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; text-align: center; width: 6%;">#</th>
                    <th style="padding: 10px 14px; font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; text-align: left; width: 48%;">Item Description &amp; Model</th>
                    <th style="padding: 10px 14px; font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; text-align: center; width: 12%;">Qty</th>
                    <th style="padding: 10px 14px; font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; text-align: right; width: 17%;">Unit Price</th>
                    <th style="padding: 10px 14px; font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; text-align: right; width: 17%;">Total Price</th>
                </tr>
            </thead>
            <tbody>
                @foreach ($items as $item)
                    <tr style="background-color: {{ $loop->even ? '#f8fafc' : '#ffffff' }};">
                        <td style="padding: 10px 14px; font-size: 12px; color: #334155; border-bottom: 1px solid #f1f5f9; text-align: center;">{{ $loop->index + 1 }}</td>
                        <td style="padding: 10px 14px; font-size: 12px; color: #334155; border-bottom: 1px solid #f1f5f9;">
                            <strong>{{ $item->name }}</strong>
                            @if(!empty($item->model))
                                <div style="font-size: 10px; color: #64748b;">Model: {{ $item->model }}</div>
                            @endif
                        </td>
                        <td style="padding: 10px 14px; font-size: 12px; color: #334155; border-bottom: 1px solid #f1f5f9; text-align: center;">{{ $item->qty ?? 1 }}</td>
                        <td style="padding: 10px 14px; font-size: 12px; color: #334155; border-bottom: 1px solid #f1f5f9; text-align: right;">৳{{ $item->unit_price ? number_format($item->unit_price, 2) : '0.00' }}</td>
                        <td style="padding: 10px 14px; font-size: 12px; color: #334155; border-bottom: 1px solid #f1f5f9; text-align: right;">৳{{ $item->total_price ? number_format($item->total_price, 2) : '0.00' }}</td>
                    </tr>
                @endforeach
            </tbody>
        </table>

        @php
            $completedReturns = $returns->where('status', 'completed');
            $totalRefundAmount = $completedReturns->sum(function($return) {
                return $return->total_refund_amount ?? $return->items->sum('total_price');
            });
            $hasReturns = $completedReturns->count() > 0;
        @endphp

        @if($hasReturns)
        <!-- Returns Section -->
        <div style="border: 1px dashed #f87171; background: #fff5f5; border-radius: 10px; padding: 14px 18px; margin-bottom: 25px;">
            <h4 style="color: #dc2626; font-size: 13px; font-weight: 700; margin-bottom: 10px;">Returned Items</h4>
            <table style="width: 100%; border-collapse: collapse;">
                <thead>
                    <tr style="background: #dc2626; color: white;">
                        <th style="padding: 8px; font-size: 11px;">Return #</th>
                        <th style="padding: 8px; font-size: 11px;">Product</th>
                        <th style="padding: 8px; font-size: 11px; text-align: center;">Qty</th>
                        <th style="padding: 8px; font-size: 11px;">Reason</th>
                        <th style="padding: 8px; font-size: 11px;">Condition</th>
                        <th style="padding: 8px; font-size: 11px; text-align: right;">Refund Amount</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($completedReturns as $return)
                        @foreach($return->items as $returnItem)
                            <tr>
                                <td style="padding: 8px; font-size: 11px; border-bottom: 1px solid #fecaca;">#{{ $return->id }}</td>
                                <td style="padding: 8px; font-size: 11px; border-bottom: 1px solid #fecaca;">{{ $returnItem->product->name ?? 'N/A' }}</td>
                                <td style="padding: 8px; font-size: 11px; border-bottom: 1px solid #fecaca; text-align: center;">{{ $returnItem->quantity }}</td>
                                <td style="padding: 8px; font-size: 11px; border-bottom: 1px solid #fecaca;">{{ $returnItem->reason_label }}</td>
                                <td style="padding: 8px; font-size: 11px; border-bottom: 1px solid #fecaca;">{{ $returnItem->condition_label }}</td>
                                <td style="padding: 8px; font-size: 11px; border-bottom: 1px solid #fecaca; text-align: right;">৳{{ number_format($returnItem->total_price, 2) }}</td>
                            </tr>
                        @endforeach
                    @endforeach
                </tbody>
            </table>
        </div>
        @endif

        <!-- Summary & Terms Grid -->
        <table style="width: 100%; border-collapse: collapse; margin-bottom: 25px;">
            <tr>
                <td style="width: 55%; vertical-align: top; padding-right: 20px;">
                    <div style="background: #ffffff; border: 1px solid #e2e8f0; border-radius: 10px; padding: 16px;">
                        <h3 style="font-size: 13px; font-weight: 700; color: #1e293b; margin-bottom: 10px; border-bottom: 1px solid #f1f5f9; padding-bottom: 6px;">Terms &amp; Conditions</h3>
                        <p style="font-size: 11px; color: #64748b; line-height: 1.6; margin-bottom: 6px;">&bull; Products can be returned within 7 days in their original, unopened condition.</p>
                        <p style="font-size: 11px; color: #64748b; line-height: 1.6; margin-bottom: 6px;">&bull; Refunds or exchanges are offered, but perishable/custom items cannot be returned.</p>
                        <p style="font-size: 11px; color: #64748b; margin-top: 10px;">Contact support at <strong>01904400205</strong> for valid receipt claims.</p>
                    </div>
                </td>
                <td style="width: 45%; vertical-align: top;">
                    <div style="background: #f8fafc; border: 1px solid #cbd5e1; border-radius: 10px; padding: 14px 16px;">
                        <table style="width: 100%; border-collapse: collapse; font-size: 12px;">
                            @if($hasReturns)
                            <tr style="color: #94a3b8; text-decoration: line-through;">
                                <td style="padding: 5px 0;">Original Sub Total:</td>
                                <td style="padding: 5px 0; text-align: right; font-weight: 600;">৳{{ number_format($sales->bill + $totalRefundAmount, 2) }}</td>
                            </tr>
                            <tr style="color: #dc2626;">
                                <td style="padding: 5px 0;">Returns / Refund:</td>
                                <td style="padding: 5px 0; text-align: right; font-weight: 600;">- ৳{{ number_format($totalRefundAmount, 2) }}</td>
                            </tr>
                            @endif
                            <tr>
                                <td style="padding: 5px 0; color: #475569;">Sub Total:</td>
                                <td style="padding: 5px 0; text-align: right; font-weight: 600; color: #0f172a;">৳{{ number_format($sales->bill, 2) }}</td>
                            </tr>
                            @if(($sales->vat ?? 0) > 0)
                            @php $vatAmount = ($sales->bill * $sales->vat) / 100; @endphp
                            <tr>
                                <td style="padding: 5px 0; color: #475569;">VAT ({{ number_format($sales->vat, 2) }}%):</td>
                                <td style="padding: 5px 0; text-align: right; font-weight: 600; color: #0f172a;">৳{{ number_format($vatAmount, 2) }}</td>
                            </tr>
                            @endif
                            @if(($sales->tax ?? 0) > 0)
                            @php $taxAmount = ($sales->bill * $sales->tax) / 100; @endphp
                            <tr>
                                <td style="padding: 5px 0; color: #475569;">Tax ({{ number_format($sales->tax, 2) }}%):</td>
                                <td style="padding: 5px 0; text-align: right; font-weight: 600; color: #0f172a;">৳{{ number_format($taxAmount, 2) }}</td>
                            </tr>
                            @endif
                            @if(($sales->delivery_charge ?? 0) > 0)
                            <tr>
                                <td style="padding: 5px 0; color: #475569;">Delivery Charge:</td>
                                <td style="padding: 5px 0; text-align: right; font-weight: 600; color: #0f172a;">৳{{ number_format($sales->delivery_charge, 2) }}</td>
                            </tr>
                            @endif
                            <tr>
                                <td style="padding: 5px 0; color: #475569;">Discount:</td>
                                <td style="padding: 5px 0; text-align: right; font-weight: 600; color: #0f172a;">৳{{ number_format($sales->discount ?? 0, 2) }}</td>
                            </tr>
                            <tr>
                                <td style="padding: 8px 0; border-top: 1px solid #cbd5e1; border-bottom: 1px solid #cbd5e1; font-size: 14px; font-weight: 800; color: #4f46e5;">Grand Total:</td>
                                <td style="padding: 8px 0; border-top: 1px solid #cbd5e1; border-bottom: 1px solid #cbd5e1; text-align: right; font-size: 14px; font-weight: 800; color: #4f46e5;">৳{{ number_format($sales->payble, 2) }}</td>
                            </tr>
                            <tr>
                                <td style="padding: 5px 0; color: #475569;">Received Amount:</td>
                                <td style="padding: 5px 0; text-align: right; font-weight: 600; color: #0f172a;">৳{{ number_format($sales->advanced_payment ?? 0, 2) }}</td>
                            </tr>
                            <tr>
                                <td style="padding: 5px 0; font-weight: 800; color: #dc2626;">Total Due:</td>
                                <td style="padding: 5px 0; text-align: right; font-weight: 800; color: {{ ($sales->due_payment ?? 0) > 0 ? '#dc2626' : '#16a34a' }};">৳{{ number_format($sales->due_payment ?? 0, 2) }}</td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>

        <!-- In Words -->
        <div style="background: #f8fafc; border: 1px solid #cbd5e1; border-radius: 8px; padding: 10px 16px; font-size: 12px; color: #334155; margin-bottom: 40px;">
            <strong style="color: #4f46e5; margin-right: 6px;">Amount In Words:</strong>
            @php $totalAmount = $sales->bill ?? 0; @endphp
            {{ numberToWords($totalAmount) }} Taka Only
        </div>

        <!-- Signatures -->
        <table style="width: 100%; border-collapse: collapse; margin-top: 50px;">
            <tr>
                <td width="50%" align="center" style="vertical-align: bottom;">
                    <div style="border-top: 1px solid #64748b; width: 180px; margin: 0 auto 6px auto;"></div>
                    <div style="font-size: 11px; font-weight: 600; color: #475569;">Customer Signature</div>
                </td>
                <td width="50%" align="center" style="vertical-align: bottom;">
                    <div style="border-top: 1px solid #64748b; width: 180px; margin: 0 auto 6px auto;"></div>
                    <div style="font-size: 11px; font-weight: 600; color: #475569;">Authorized Signature</div>
                </td>
            </tr>
        </table>

    </div>

</body>
</html>
