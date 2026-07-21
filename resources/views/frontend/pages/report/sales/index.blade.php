@extends('frontend.layouts.app')
@section('content')
    <style>
        /* Default: Columns stack vertically */
        .custom-col-xl-2 {
            flex: 0 0 100%;
            max-width: 100%;
        }

        /* Media Query for XL screens (≥1200px) */
        @media (min-width: 1200px) {
            .custom-col-xl-2 {
                flex: 0 0 20%;
                /* Equivalent to col-xl-2 (2/12 = 16.67%) */
                max-width: 20%;
            }
        }

        .page-wrapper .content {
            padding: 14px !important;
        }
    </style>
    <div class="content container-fluid col-sm-12">


        <!-- Page Header -->
        <div class="page-header">
            <div class="content-page-header">
                <h5>Sales Report</h5>
            </div>
        </div>
        <div id="filter_inputs" class="card mb-3">
            <div class="card-body pb-0">
                <form action="{{ route('sales.report') }}" method="GET">
                    <div class="row align-items-end mb-3">
                        <!-- Customer Name -->
                        <div class="col-sm-12 col-md-4 col-lg-3">
                            <div class="input-block">
                                <label class="form-label">Customer</label>
                                <select name="customer_id" class="form-control">
                                    <option value="">-- All Customers --</option>
                                    @foreach ($customers as $customer)
                                        <option value="{{ $customer->id }}"
                                            {{ request('customer_id') == $customer->id ? 'selected' : '' }}>
                                            {{ $customer->name }} - {{ $customer->phone }}
                                        </option>
                                    @endforeach
                                </select>
                            </div>
                        </div>

                        <!-- Product Name -->
                        <div class="col-sm-12 col-md-4 col-lg-3">
                            <div class="input-block">
                                <label class="form-label">Product Name</label>
                                <select name="item_name" class="form-control">
                                    <option value="">-- Select Product --</option>
                                    @foreach ($products as $product)
                                        <option value="{{ $product->id }}"
                                            {{ request('item_name') == $product->id ? 'selected' : '' }}>
                                            {{ $product->name }}
                                        </option>
                                    @endforeach
                                </select>
                            </div>
                        </div>

                        <!-- From Date -->
                        <div class="col-sm-12 col-md-3 col-lg-2">
                            <div class="input-block">
                                <label class="form-label">From Date</label>
                                <input type="date" class="form-control" name="from" value="{{ request('from') }}">
                            </div>
                        </div>

                        <!-- To Date -->
                        <div class="col-sm-12 col-md-3 col-lg-2">
                            <div class="input-block">
                                <label class="form-label">To Date</label>
                                <input type="date" class="form-control" name="to" value="{{ request('to') }}">
                            </div>
                        </div>

                        <!-- Filter + PDF Buttons -->
                        <div class="col-sm-12 col-md-6 col-lg-2 mt-3 mt-md-0">
                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-primary px-3 flex-fill">Filter</button>
                                <a href="{{ route('sales.report.pdf', request()->query()) }}" class="btn btn-danger px-3 flex-fill" target="_blank">
                                    <i class="fas fa-file-pdf"></i> PDF
                                </a>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div class="row p-3">
            <div class="col-sm-12">
                <div class="card-table">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered mt-4">
                                <thead class="thead-dark">
                                    <tr>
                                        <th>#</th>
                                        <th>Customer</th>
                                        <th>Product Name</th>
                                        <th>Qty</th>
                                        <th>Unit Price</th>
                                        <th>Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @forelse($salesReport as $index => $purchase)
                                        <tr>
                                            <td>{{ $index + 1 }}</td>
                                            <td>{{ $purchase->customer_name ?? 'N/A' }}</td>
                                            <td>{{ $purchase->product_name ?? 'N/A' }}</td>
                                            <td>{{ $purchase->qty }}</td>
                                            <td>{{ number_format($purchase->unit_price, 2) }}</td>
                                            <td>{{ number_format($purchase->total_price, 2) }}</td>
                                        </tr>
                                    @empty
                                        <tr>
                                            <td colspan="6" class="text-center">No data available</td>
                                        </tr>
                                    @endforelse
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
