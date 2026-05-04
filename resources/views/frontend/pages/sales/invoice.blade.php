<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Invoice</title>
    <link rel="stylesheet" href="{{ asset('assets/invoice/style.css') }}" />
    <style>


        @media print 
    .a4-container {
        /* This tells the browser: "I don't care about ink, show the background!" */
        -webkit-print-color-adjust: exact !important;
        print-color-adjust: exact !important;
    }

    .no-print {
        display: none !important;
    }

        /* Background image for PDF - watermark style */
        .a4-container {
            background-image: url('{{ asset('assets/invoice/invoice-bg.jpg') }}');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }
        
        /* Alternative: watermark style (centered, semi-transparent)
        .a4-container::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 300px;
            height: 300px;
            background-image: url('{{ asset('assets/invoice/invoice-bg.jpg') }}');
            background-size: contain;
            background-repeat: no-repeat;
            background-position: center;
            opacity: 0.15;
            z-index: 0;
            pointer-events: none;
        } */
        
        /* Ensure content stays above background */
        .a4-container > * {
            position: relative;
            z-index: 1;
        }
    </style>
</head>

<body>
    <button class="print-btn no-print" onclick="window.print()">
        Print Invoice
    </button>

    <div class="a4-container">
        <div class="invoice-header">
            <!-- <div class="header__left">
                <div class="logo">
                    <img src="{{ asset('assets/invoice/logo-transparent.webp') }}" alt="" />
                </div>
                <div class="company-info">
                    <h1>Intelligent Technology</h1>
                    <p>Phone: 01904400202</p>
                    <p>Email: info.itechbd@yahoo.com</p>
                </div>
            </div> -->
            <!-- <div class="invoice-title">
                {{-- <p>Date: {{ $sales->created_at->format('d-m-Y') }}</p> --}}
                <h1>INVOICE</h1>
            </div> -->
        </div>
        <!-- invoice address  -->
        <!-- <div class="address">
            <p>Address: House # 7, (3rd floor), Road # 4,</p>
            <p>Mirpur-10, Dhaka -1216, Bangladesh.</p>
        </div> -->

         <div class="right">
                        <h1>INVOICE</h1>
                        <p>Invoice No: {{ $sales->order_no }}</p>
                        <p>Invoice Date:
                            {{ $sales->created_at->format('d-m-Y') }}

                        </p>
                    </div>

        <div class="invoice-details">
            <ul>
                <li class="details__item">
                    <div class="customer">
                        <p>Customer:</p>
                        <p class="customer__name">{{ $customer->name }}</p>
                    </div>

                </li>
                <li class="details__item">
                    <div class="customer">
                        <p>Phone:</p>
                        <p class="customer__name">{{ $customer->phone }}</p>
                    </div>

                </li>
                <li class="details__item">
                    <div class="customer">
                        <p>Address:</p>
                        <p class="customer__name">{{ $customer->address }}</p>
                    </div>

                </li>
            </ul>
        </div>

        <table class="items-table">
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

        @php
            $completedReturns = $returns->where('status', 'completed');
            $totalRefundAmount = $completedReturns->sum(function($return) {
                return $return->total_refund_amount ?? $return->items->sum('total_price');
            });
            $hasReturns = $completedReturns->count() > 0;
        @endphp

        @if($hasReturns)
        <!-- Returns Section -->
        <div class="returns-section" style="margin-top: 20px; border: 1px dashed #dc3545; padding: 15px; background: #fff5f5;">
            <h4 style="color: #dc3545; margin-bottom: 10px;">Returned Items</h4>
            <table class="items-table" style="width: 100%;">
                <thead>
                    <tr style="background: #dc3545; color: white;">
                        <th>Return #</th>
                        <th>Product</th>
                        <th>Qty Returned</th>
                        <th>Reason</th>
                        <th>Condition</th>
                        <th>Refund Amount</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($completedReturns as $return)
                        @foreach($return->items as $returnItem)
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
                    <tr style="font-weight: bold; background: #ffe0e0;">
                        <td colspan="5" class="text-right">Total Refund:</td>
                        <td>{{ number_format($totalRefundAmount, 2) }} Tk</td>
                    </tr>
                </tfoot>
            </table>
        </div>
        @endif

        <div class="totals-section">
            <div class="conditions">
                <h2>Terms & Conditions</h2>
                <br>
                <p>
                    1. Products can be returned within 7 days in their original, unopened
                    condition.
                </p>
                <br>
                <p>2. Refunds or exchanges are offered, but perishable goods
                    cannot be returned.</p>
                <br>
                <p>Contact us at <strong>01904400205</strong> with a valid receipt
                    for assistance.</p>
                </p>
            </div>
            <table class="totals-table">
                @if($hasReturns)
                <tr style="color: #666; text-decoration: line-through;">
                    <td>Original Sub Total:</td>
                    <td class="text-right">{{ number_format($sales->bill + $totalRefundAmount, 2) }} Tk</td>
                </tr>
                <tr style="color: #dc3545;">
                    <td>Returns / Refund:</td>
                    <td class="text-right">- {{ number_format($totalRefundAmount, 2) }} Tk</td>
                </tr>
                @endif
                <tr>
                    <td>Sub Total:</td>
                    <td class="text-right">{{ number_format($sales->bill, 2) }} Tk</td>
                </tr>
                @if(($sales->vat ?? 0) > 0)
                @php $vatAmount = ($sales->bill * $sales->vat) / 100; @endphp
                <tr>
                    <td>VAT ({{ number_format($sales->vat, 2) }}%):</td>
                    <td class="text-right">{{ number_format($vatAmount, 2) }} Tk</td>
                </tr>
                @endif
                @if(($sales->tax ?? 0) > 0)
                @php $taxAmount = ($sales->bill * $sales->tax) / 100; @endphp
                <tr>
                    <td>Tax ({{ number_format($sales->tax, 2) }}%):</td>
                    <td class="text-right">{{ number_format($taxAmount, 2) }} Tk</td>
                </tr>
                @endif
                @if(($sales->delivery_charge ?? 0) > 0)
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
                <tr>
                    <td>Total Due:</td>
                    <td class="text-right">{{ number_format($sales->due_payment ?? 0, 2) }} Tk</td>
                </tr>
            </table>
        </div>
        <div class="in-words">
            <strong>In Words:</strong>
            @php
                $totalAmount = $sales->bill ?? 0;
            @endphp
            {{ numberToWords($totalAmount) }} Taka Only
        </div>

        <!-- signature  -->
        <div class="signature">
            <div class="signature__left">
                <p>Customer Signature</p>
            </div>
            <div class="signature__right">
                <p>Authorized Signature</p>
            </div>
        </div>
    </div>

    <script>
        document
            .querySelector(".print-btn")
            .addEventListener("click", function() {
                window.print();
            });

    </script>
</body>

</html>
