 <!DOCTYPE html>
 <html>

 <head>
     <meta charset="utf-8" />
     <link rel="preconnect" href="https://fonts.googleapis.com" />
     <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
     <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap"
         rel="stylesheet" />
     <title>Vendor List</title>
     <style>
         body {
             font-family: "Montserrat", sans-serif;
             font-size: 12px;
             line-height: 1.3;
             color: #000;
             margin: 0;
             padding: 20px;

             background: rgba(255, 255, 255, 0.2) url("{{ public_path('big-logo.png') }}") no-repeat 310px -10px / 340px auto fixed transparent !important;

         }

         @page {
             margin: 160px 45px 100px 45px;
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

             /* margin-top: 30px; */
             margin-bottom: 20px;
             font-weight: bold;
             position: relative;
         }

         .reference .ref-date {
             position: absolute;
             top: 0;
             right: 0;
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
             /* background-color: #f9f9f9; */
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
             margin: 10px 0;
             padding: 15px;
             /* background-color: #f5f5f5; */
             /* border-left: 2px solid #333; */
         }

         .bank-details strong {
             display: inline-block;
             width: 180px;
         }

         .closing {
             margin: 40px 0 0 0px;
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
             /* margin: 40px auto 5px auto; */
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

         .sil {
             max-width: 120px;
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
         <div> Corporate Office: 187(3rd Floor), Green Road, Dhanmondi Dhaka-1205, Bangladesh. Cell: +88 01904400202,
             +88 01904400203</div>

         <div>E-mail: info.itechbd@yahoo.com Web: www.itechbd.net</div>
     </footer>


     <div class="container">

         <div class="bill-title">Vendor List</div>

         <table>
             <thead>
                 <tr>
                     <th>S/L</th>
                     <th>Vendor Name</th>
                     <th>Phone</th>
                     <th>Email</th>
                     <th>Address</th>
                 </tr>
             </thead>
             <tbody>
                 @foreach ($vendors->sortBy('name') as $index => $vendors)
                     <tr>
                         <td>{{ $loop->iteration }}</td>
                         <td>
                             <div class="product-specs">
                                 {{ $vendors->name }}
                             </div>
                         </td>
                         <td>{{ $vendors->phone }} </td>
                         <td>{{ $vendors->email }}</td>
                         <td>{{ $vendors->address }}</td>
                     </tr>
                 @endforeach

             </tbody>
         </table>

         {{-- <div class="signature-section">
             <div class="signature-content">

                 <div class="signature-line"></div>
                 <p><strong>{{ $company['signatory_name'] ?? 'Engr. Shamsul Alam' }}</strong></p>
                 <p>{{ $company['signatory_designation'] ?? 'Director (Technical)' }}</p>
                 <p>For, <strong>{{ $company['name'] ?? 'Intelligent Technology' }}</strong></p>

                 <div class="contact-info">
                     @if (!empty($company['phone'] ?? null))
                         <p>Cell: {{ $company['phone'] }}</p>
                     @endif
                     @if (!empty($company['email'] ?? null))
                         <p>E-mail: {{ $company['email'] }}</p>
                     @endif
                     @if (!empty($company['website'] ?? null))
                         <p>Web: {{ $company['website'] }}</p>
                     @endif
                 </div>
             </div>
             <div class="sil">
                 <img src="{{ public_path('sil.png') }}" alt="logo">
             </div>
         </div> --}}

     </div>

 </body>

 </html>
