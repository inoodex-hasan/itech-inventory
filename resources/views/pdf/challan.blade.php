<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet" />
    <title>Challan {{ $challan->reference_number }}</title>
    <style>
        body {
            font-family: "Montserrat", sans-serif;
            font-size: 12px;
            line-height: 1.3;
            color: #000;
            margin: 0;
            padding: 20px;
            background: url("{{ public_path('assets/invoice/final_pad.png') }}") no-repeat center top / 100% 100% fixed transparent !important;
        }

        @page {
            margin: 160px 45px 90px 45px;
            size: A4 portrait;
        }

        .container {
            max-width: 800px;
            margin: 15px auto 15px;
        }

        header {
            position: fixed;
            top: -150px;
            left: 0;
            right: 0;
            display: block;
            height: 100px;
            background: transparent;
            padding: 15px 45px 30px;
            padding-bottom: 30px;
            font-size: 11px;
            z-index: 10;
        }

        footer {
            position: fixed;
            bottom: -70px;
            left: 0;
            right: 0;
            height: 50px;
            padding: 10px 0;
            border-top: 1px solid #999;
            font-size: 12px;
            display: flex;
            justify-content: space-between;
            text-align: center;
            align-items: center;
        }

        .logo {
            max-width: 200px;
        }

        .logo img {
            width: 100%;
            text-align: left;
            opacity: 0.5;
            margin-left: -60px;
            margin-bottom: 50px !important;
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

        .subject {
            margin: 15px 0;
            font-weight: bold;
        }

        .underline {
            text-decoration: underline;
        }

        .challan-title {
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
            width: 67%;
        }

        .quantity {
            width: 25%;
            text-align: center;
        }

        .serial {
            width: 8%;
            text-align: center;
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
            float: left;
            text-align: left;
            width: 300px;
        }

        .signature-line {
            border-top: 1px dashed #000;
            width: 200px;
        }

        .contact-info {
            margin-top: 10px;
            font-size: 11px;
        }

        .product-specs {
            margin-left: 10px;
        }

        .sil {
            max-width: 130px;
        }

        .sil img {
            width: 100%;
        }
    </style>
</head>
<body>
    <header>
        <div class="logo">
            <img src="{{ public_path('logo.jpg') }}" alt="logo">
        </div>
    </header>

    <footer>
        <div>Corporate Office: Jahanara Villa, House # 07 (3rd Floor), Road # 04, Mirpur-10 Circle, Dhaka-1216, Bangladesh.
Cell: +88 01904400202, +88 01904400203</div>
        <div>E-mail: info.itechbd@yahoo.com Web: www.itechbd.net</div>
    </footer>

    <div class="container">
        <div class="reference">
            <span style="float: left;">Ref: {{ $challan->reference_number }}</span>
            <span style="float: right;">{{ $challan->challan_date->format('F d, Y') }}</span>
            <div style="clear: both;"></div>
        </div>

        <div class="to-section">
            <p>To,</p>
            <p>{{ $recipient_designation ?? 'Director (IT)' }}</p>
            <p>{{ $recipient_organization ?? ($challan->client_name ?? 'N/A') }}</p>
            <p>{{ $recipient_address ?? ($challan->client_address ?? 'N/A') }}</p>
            @if (!empty($attention_to))
                <p>Attention: {{ $attention_to }}</p>
            @endif
        </div>

        @if ($challan->work_order_number)
            <div class="subject">
                Work Order # {{ $challan->work_order_number }}
            </div>
        @endif

        <div class="subject">
            Sub: <span class="underline">{{ $subject ?? 'Delivery Challan' }}</span>
        </div>

        <div class="challan-title">DELIVERY CHALLAN</div>

        <table>
            <thead>
                <tr>
                    <th class="serial">S/L</th>
                    <th class="product-description">PRODUCT DESCRIPTION</th>
                    <th class="quantity">QTY.</th>
                </tr>
            </thead>
            <tbody>
                @foreach ($challan->challanItems as $item)
                    <tr>
                        <td class="serial">{{ $loop->iteration }}</td>
                        <td class="product-description">
                            <div class="product-specs">
                                {!! nl2br(e($item->description)) !!}
                            </div>
                        </td>
                        <td class="quantity">{{ number_format($item->quantity) }} {{ $item->unit ?? 'No' }}</td>
                    </tr>
                @endforeach
            </tbody>
        </table>

        <div class="closing">
            <p>We assure you that we provide our best service at all times.</p>
            <p>Thank you once again.</p>
        </div>

        <div class="signature-section">
            <div class="signature-content">
                <div class="signature-line"></div>
                <p><strong>For, Intelligent Technology</strong></p>
            </div>
            <div class="sil" style="float: right; text-align: center;">
                <img src="{{ public_path('sil.png') }}" alt="sil">
                <p style="margin-top: 5px;"><strong>Customer's Signature</strong></p>
            </div>
            <div style="clear: both;"></div>
        </div>
    </div>
</body>
</html>
