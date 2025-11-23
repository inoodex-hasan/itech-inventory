<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>Bill {{ $bill->reference_number }}</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            font-size: 12px;
            line-height: 1.3;
            color: #000;
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
        }

        .reference {
            margin-bottom: 20px;
            font-weight: bold;
        }

        .to-section {
            margin-bottom: 20px;
        }

        .to-section p {
            margin: 3px 0;
        }

        .work-order {
            margin: 15px 0;
            font-weight: bold;
        }

        .subject {
            margin: 15px 0;
            font-weight: bold;
        }

        .underline {
            text-decoration: underline;
        }

        .letter-body {
            margin: 20px 0;
            text-align: justify;
        }

        .bill-title {
            text-align: center;
            font-weight: bold;
            text-decoration: underline;
            margin: 20px 0;
            font-size: 14px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            font-size: 11px;
        }

        table th {
            border: 1px solid #000;
            padding: 8px;
            text-align: center;
            background-color: #f0f0f0;
            font-weight: bold;
        }

        table td {
            border: 1px solid #000;
            padding: 8px;
            vertical-align: top;
        }

        .product-description {
            width: 55%;
        }

        .quantity,
        .unit-price,
        .total-price {
            width: 15%;
            text-align: center;
        }

        .total-row {
            font-weight: bold;
        }

        .total-row td {
            text-align: right;
            padding-right: 20px;
        }

        .amount-in-words {
            margin: 15px 0;
            padding: 10px;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            font-style: italic;
            text-align: center;
            font-weight: bold;
        }

        .terms-title {
            text-align: center;
            font-weight: bold;
            text-decoration: underline;
            margin: 20px 0 10px 0;
        }

        .terms-table {
            margin: 10px 0;
        }

        .terms-table td {
            vertical-align: top;
            padding: 5px 8px;
        }

        .terms-table td:first-child {
            width: 30px;
            font-weight: bold;
        }

        .bank-details {
            margin: 20px 0;
            padding: 15px;
            background-color: #f5f5f5;
            border-left: 4px solid #333;
        }

        .bank-details strong {
            display: inline-block;
            width: 180px;
        }

        .closing {
            margin: 20px 0;
            text-align: justify;
        }

        .signature-section {
            margin-top: 60px;
            position: relative;
        }

        .signature-content {
            float: right;
            text-align: center;
            width: 300px;
        }

        .signature-line {
            border-top: 1px solid #000;
            width: 200px;
            margin: 40px auto 5px auto;
        }

        .contact-info {
            margin-top: 10px;
            font-size: 11px;
        }

        .brand-details {
            margin-bottom: 3px;
        }

        .product-specs {
            margin-left: 10px;
        }
    </style>
</head>

<body>
    <div class="container">
        <!-- Reference and Date -->
        <div class="reference">
            Ref: {{ $bill->reference_number }} {{ $bill->bill_date->format('F d, Y') }}
        </div>

        <!-- Recipient Details -->
        <div class="to-section">
            <p>To,</p>
            <p>{{ $bill->recipient_designation }}</p>
            <p>{{ $bill->recipient_organization }}</p>
            <p>{{ $bill->recipient_address }}</p>
            @if ($bill->attention_to)
                <p>Attention: {{ $bill->attention_to }}</p>
            @endif
        </div>

        <!-- Work Order -->
        <div class="work-order">
            Work order # {{ $bill->work_order_number }}
        </div>

        <!-- Subject -->
        <div class="subject">
            Sub: <span class="underline">{{ $bill->notes }}</span>
        </div>

        <!-- Letter Body -->
        <div class="letter-body">
            <p>Dear Sir,</p>
            <p>Regarding the previously mentioned subject, I am pleased to inform you that we have successfully
                delivered the product in accordance with your specifications. Kindly proceed with the settlement of the
                invoice.</p>
        </div>

        <!-- Bill Title -->
        <div class="bill-title">BILL</div>

        <!-- Products Table -->
        <table>
            <thead>
                <tr>
                    <th class="product-description">PRODUCT DESCRIPTION</th>
                    <th class="quantity">QTY.</th>
                    <th class="unit-price">UNIT PRICE</th>
                    <th class="total-price">TOTAL PRICE</th>
                </tr>
            </thead>
            <tbody>
                @foreach ($bill->items as $index => $item)
                    <tr>
                        <td class="product-description">
                            <strong>{{ $index + 1 }}.</strong>
                            <div class="product-specs">
                                {!! nl2br(e($item->description)) !!}
                            </div>
                        </td>
                        <td class="quantity">{{ number_format($item->quantity) }} {{ $item->unit ?? 'No' }}</td>
                        <td class="unit-price">{{ number_format($item->unit_price, 2) }}</td>
                        <td class="total-price">{{ number_format($item->total, 2) }}</td>
                    </tr>
                @endforeach

                <!-- Total Rows -->
                <tr class="total-row">
                    <td colspan="3">Subtotal</td>
                    <td class="total-price">{{ number_format($bill->subtotal, 2) }}</td>
                </tr>
                @if ($bill->tax_amount > 0)
                    <tr class="total-row">
                        <td colspan="3">Tax Amount</td>
                        <td class="total-price">{{ number_format($bill->tax_amount, 2) }}</td>
                    </tr>
                @endif
                <tr class="total-row">
                    <td colspan="3">Total Amount</td>
                    <td class="total-price">{{ number_format($bill->total_amount, 2) }}</td>
                </tr>
            </tbody>
        </table>

        <!-- Amount in Words -->
        <div class="amount-in-words">
            In Word: {{ $amount_in_words ?? $bill->amount_in_words }}
        </div>

        <!-- Terms and Conditions -->
        @if ($bill->terms_conditions)
            <div class="terms-title">Terms and Conditions</div>

            <table class="terms-table">
                @foreach (explode("\n", $bill->terms_conditions) as $index => $term)
                    @if (trim($term))
                        <tr>
                            <td>{{ $index + 1 }}.</td>
                            <td>{{ trim($term) }}</td>
                        </tr>
                    @endif
                @endforeach
            </table>
        @endif

        <!-- Bank Details -->
        @if (isset($bank_details))
            <div class="bank-details">
                <p>Please take necessary step to clear the bill to the following accounts details.</p>
                <p><strong>Account Name:</strong> {{ $bank_details['account_name'] ?? 'Intelligent Technology' }}</p>
                <p><strong>Bank Name:</strong> {{ $bank_details['bank_name'] ?? 'Bank Asia Ltd.' }}</p>
                <p><strong>Branch:</strong> {{ $bank_details['branch'] ?? 'Satmosjid Road' }}</p>
                <p><strong>Account Number:</strong> {{ $bank_details['account_number'] ?? '06933000526' }}</p>
                <p><strong>Account Type:</strong> {{ $bank_details['account_type'] ?? 'Current' }}</p>
                @if (isset($bank_details['routing_number']))
                    <p><strong>Receiving Bank Routing Number:</strong> {{ $bank_details['routing_number'] }}</p>
                @endif
                @if (isset($bank_details['mobile']))
                    <p><strong>Mobile:</strong> {{ $bank_details['mobile'] }}</p>
                @endif
            </div>
        @endif

        <!-- Closing -->
        <div class="closing">
            <p>Thank you for your prompt attention to this matter. We assure you that we provide our best service at all
                times.</p>
            <p>Thank you once again.</p>
        </div>

        <!-- Signature Section -->
        <div class="signature-section">
            <div class="signature-content">
                <p>Yours Sincerely,</p>
                <div class="signature-line"></div>
                <p><strong>{{ $company['signatory_name'] ?? 'Engr. Shamsul Alam' }}</strong></p>
                <p>{{ $company['signatory_designation'] ?? 'Director (Technical)' }}</p>
                <p>For, <strong>{{ $company['name'] ?? 'Intelligent Technology' }}</strong></p>
                <div class="contact-info">
                    @if (isset($company['phone']))
                        <p>Cell: {{ $company['phone'] }}</p>
                    @endif
                    @if (isset($company['email']))
                        <p>E-mail: {{ $company['email'] }}</p>
                    @endif
                    @if (isset($company['website']))
                        <p>Web: {{ $company['website'] }}</p>
                    @endif
                </div>
            </div>
        </div>
    </div>
</body>

</html>

{{-- <!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>Bill - {{ $bill->bill_number }}</title>
    <style>
        body {
            font-family: DejaVu Sans, sans-serif;
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
        }

        .bill-info {
            margin-bottom: 20px;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .table th,
        .table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        .table th {
            background-color: #f2f2f2;
        }

        .text-right {
            text-align: right;
        }

        .total-section {
            margin-top: 20px;
        }
    </style>
</head>

<body>
    <div class="header">
        <h1>BILL</h1>
        <h3>{{ $bill->bill_number }}</h3>
    </div>

    <div class="bill-info">
        <p><strong>Bill Date:</strong> {{ $bill->bill_date }}</p>
        <p><strong>Reference:</strong> {{ $bill->reference_number }}</p>
        <p><strong>Type:</strong> {{ ucfirst($bill->bill_type) }} Bill</p>
        @if ($bill->work_order_number)
            <p><strong>Work Order:</strong> {{ $bill->work_order_number }}</p>
        @endif
    </div>

    <!-- Customer/Client Information -->
    <div style="margin-bottom: 20px;">
        <h4>Bill To:</h4>
        @if ($bill->bill_type === 'sale' && $bill->sale && $bill->sale->customer)
            <p><strong>{{ $bill->sale->customer->name }}</strong></p>
            <p>Email: {{ $bill->sale->customer->email ?? 'N/A' }}</p>
            <p>Phone: {{ $bill->sale->customer->phone ?? 'N/A' }}</p>
            <p>Address: {{ $bill->sale->customer->address ?? 'N/A' }}</p>
        @elseif($bill->bill_type === 'project' && $bill->project && $bill->project->client)
            <p><strong>{{ $bill->project->client->name }}</strong></p>
            <p>Email: {{ $bill->project->client->email ?? 'N/A' }}</p>
            <p>Phone: {{ $bill->project->client->phone ?? 'N/A' }}</p>
            <p>Address: {{ $bill->project->client->address ?? 'N/A' }}</p>
        @else
            <p>Customer information not available</p>
        @endif
    </div>

    <!-- Bill Items -->
    <table class="table">
        <thead>
            <tr>
                <th>Description</th>
                <th>Quantity</th>
                <th>Unit</th>
                <th>Unit Price</th>
                <th>Total</th>
            </tr>
        </thead>
        <tbody>
            @foreach ($bill->billItems as $item)
                <tr>
                    <td>{{ $item->description }}</td>
                    <td>{{ $item->quantity }}</td>
                    <td>{{ $item->unit }}</td>
                    <td class="text-right">{{ number_format($item->unit_price, 2) }}</td>
                    <td class="text-right">{{ number_format($item->total, 2) }}</td>
                </tr>
            @endforeach
        </tbody>
    </table>

    <!-- Totals -->
    <div class="total-section" style="text-align: right;">
        <p><strong>Subtotal: {{ number_format($bill->subtotal, 2) }}</strong></p>
        <p><strong>Total Amount: {{ number_format($bill->total_amount, 2) }}</strong></p>
    </div>

    @if ($bill->notes)
        <div style="margin-top: 30px;">
            <h4>Notes:</h4>
            <p>{{ $bill->notes }}</p>
        </div>
    @endif

    <div style="margin-top: 50px; text-align: center;">
        <p>Thank you for your business!</p>
    </div>
</body>

</html> --}}
