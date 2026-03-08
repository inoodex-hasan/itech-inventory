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
    <div class="content container-fluid">


        <!-- Page Header -->
        <div class="page-header">

            <form action="{{ route('sales.index') }}" method="get">
                <div class="row">
                    <div class="col-12 col-md-2">
                        <label for="">From</label>
                        <input type="date" name="from" class="form-control"
                            value="{{ isset($request) ? $request->from : '' }}">
                    </div>
                    <div class="col-12 col-md-2">
                        <label for="">To</label><br>
                        <input type="date" name="to" class="form-control"
                            value="{{ isset($request) ? $request->to : '' }}">
                    </div>

                    <div class="col-12 col-md-2">
                        <label for="">Search By</label><br>
                        <select name="search_by" id="" class="form-select">
                            <option value="">--Select--</option>
                            <option value="order_no"
                                {{ isset($request) && $request->search_by == 'order_no' ? 'selected' : '' }}>Order No
                            </option>
                            <option value="name" {{ isset($request) && $request->search_by == 'name' ? 'selected' : '' }}>
                                Name</option>
                            <option value="phone"
                                {{ isset($request) && $request->search_by == 'phone' ? 'selected' : '' }}>Phone</option>
                            <option value="email"
                                {{ isset($request) && $request->search_by == 'email' ? 'selected' : '' }}>Email</option>
                            <option value="product_name"
                                {{ isset($request) && $request->search_by == 'product_name' ? 'selected' : '' }}>Product
                                Name</option>
                        </select>
                    </div>
                    <div class="col-12 col-md-2">
                        <label for="">Search Key</label><br>
                        <input type="text" name="key" class="form-control"
                            value="{{ isset($request) ? $request->key : '' }}">
                    </div>
                    <div class="col-12 col-md-2">
                        <label for=""></label>
                        <button type="submit" name="search_for" value="filter" class="btn btn-primary"
                            style="margin-top:25px;">Search</button>
                        <label for=""></label>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- /Page Header -->
    <!-- Search Filter -->
    <div id="filter_inputs" class="card filter-card">
        <div class="card-body pb-0">
            <div class="row">
                <div class="col-sm-6 col-md-3">
                    <div class="input-block mb-3">
                        <label>Name</label>
                        <input type="text" class="form-control">
                    </div>
                </div>
                <div class="col-sm-6 col-md-3">
                    <div class="input-block mb-3">
                        <label>Email</label>
                        <input type="text" class="form-control">
                    </div>
                </div>
                <div class="col-sm-6 col-md-3">
                    <div class="input-block mb-3">
                        <label>Phone</label>
                        <input type="text" class="form-control">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /Search Filter -->
    <div class="row p-3">
        <div class="col-sm-12">
            <div class="card-table">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-center table-hover" id="salesTable">
                            <thead class="thead-light">
                                <tr>
                                    <th>#</th>
                                    <th>Date</th>
                                    <th>Order No</th>
                                    <th>Name</th>
                                    <th>Phone</th>
                                    <th>Payable</th>
                                    <th>Type</th>
                                    <th>Sales By</th>
                                    <th class="no-sort">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse ($services as $service)
                                    <tr>
                                        <td>{{ $loop->iteration }}</td>
                                        <td>
                                            <h2 class="table-avatar">
                                                <span>{{ $service->created_at->format('Y-m-d') }}</span>
                                            </h2>
                                        </td>
                                        <td>
                                            <h2 class="table-avatar"> <span>{{ $service->order_no }}</span></h2>
                                        </td>
                                        <td>
                                            {{ $service->sale_type == 'project' ? $service->client->name ?? 'N/A' : $service->customer->name ?? 'N/A' }}
                                        </td>
                                        <td>
                                            {{ $service->sale_type == 'project' ? $service->client->phone ?? 'N/A' : $service->customer->phone ?? 'N/A' }}
                                        </td>

                                        <td> {{ $service->payble }} </td>
                                        <td>{{ ucfirst($service->sale_type) }}</td>
                                        <td>{{ $service->salesPerson->name ?? 'N/A' }}</td>
                                        <td class="d-flex align-items-center">
                                            <div class="dropdown dropdown-action">
                                                <a href="#" class=" btn-action-icon " data-bs-toggle="dropdown"
                                                    aria-expanded="false">
                                                    <i class="fas fa-ellipsis-v"></i>
                                                </a>
                                                <div class="dropdown-menu dropdown-menu-end">
                                                    <ul>

                                                        @if ($service->sale_type == 'retail')
                                                            {{-- Invoice / Bill --}}
                                                            <li>
                                                                <a class="dropdown-item" target="_blank"
                                                                    href="{{ route('sales.invoice', $service->id) }}">
                                                                    <i class="far fa-file-alt me-2"></i>
                                                                    Invoice
                                                                </a>
                                                            </li>

                                                            {{-- Edit --}}
                                                            <li>
                                                                <a class="dropdown-item"
                                                                    href="{{ route('sales.edit', $service->id) }}">
                                                                    <i class="far fa-edit me-2"></i> Edit
                                                                </a>
                                                            </li>
                                                        @endif


                                                        {{-- DELETE ( always show for both retail & project ) --}}
                                                        <li>
                                                            <a onclick="if (confirm('Are you sure to delete the Sales?')) { document.getElementById('serviceDelete{{ $service->id }}').submit(); }"
                                                                class="dropdown-item" href="javascript:void(0)">
                                                                <i class="far fa-trash-alt me-2"></i>Delete
                                                            </a>
                                                            <form id="serviceDelete{{ $service->id }}"
                                                                action="{{ route('sales.destroy', $service->id) }}"
                                                                method="post">
                                                                @csrf
                                                                @method('DELETE')
                                                            </form>
                                                        </li>

                                                    </ul>

                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                @empty
                                    <tr>
                                        <td colspan="9" class="text-center py-4">
                                            <i class="fe fe-inbox fa-3x text-muted mb-3 d-block"></i>
                                            <span class="text-muted">No sales found</span>
                                        </td>
                                    </tr>
                                @endforelse
                            </tbody>
                        </table>

                        <!-- Pagination -->
                        <div class="d-flex justify-content-end mt-3">
                            {{ $services->links('pagination::bootstrap-5') }}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            $('.view-sale-details-btn').click(function() {
                let saleId = $(this).data('sale-id');

                // Use Laravel's route helper to generate URL pattern with placeholder
                let urlTemplate = "{{ route('sales.details', ':id') }}";
                let url = urlTemplate.replace(':id', saleId);

                $('#saleDetailsContent').html('<p>Loading...</p>');

                $.ajax({
                    url: url,
                    method: 'GET',
                    success: function(res) {
                        let sale = res.sale;
                        let items = res.items;

                        let html = `
            <h6>Customer: ${sale.name} (${sale.phone})</h6>
            <p>Address: ${sale.address}</p>
            <p>Bill: ${sale.bill}</p>
            <p>Discount: ${sale.discount}</p>
            <p>Payable: ${sale.payble}</p>
            <hr>
            <table class="table table-bordered">
              <thead>
                <tr>
                  <th>Product</th>
                  <th>Warranty (Days)</th>
                  <th>Unit Price</th>
                  <th>Quantity</th>
                  <th>Total Price</th>
                </tr>
              </thead>
              <tbody>`;

                        items.forEach(function(item) {
                            html += `<tr>
                  <td>${item.name} (${item.model || ''})</td>
                  <td>${item.warranty || 'N/A'} <br><small class="text-muted">(${item.warranty_days_left} day(s) left)</small></td>
                  <td>${item.unit_price}</td>
                  <td>${item.qty}</td>
                  <td>${item.total_price}</td>
                </tr>`;
                        });


                        html += `</tbody></table>`;

                        $('#saleDetailsContent').html(html);
                        $('#saleDetailsModal').modal('show');
                    },
                    error: function() {
                        $('#saleDetailsContent').html('<p>Error loading sale details.</p>');
                    }
                });
            });
        });
    </script>
@endsection
