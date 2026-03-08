@extends('frontend.layouts.app')
@section('content')
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <style>
        .select2-container--default.select2-container--open .select2-selection--single .select2-selection__arrow b {
            border-color: transparent transparent #888 transparent;
            border-width: 0 !important;
        }

        .select2-container--default .select2-selection--single .select2-selection__arrow b {
            border-color: #888 transparent transparent transparent;
            border-style: solid;
            border-width: 0 !important;
            height: 0;
            left: 50%;
            margin-left: -4px;
            margin-top: -2px;
            position: absolute;
            top: 50%;
            width: 0;
        }
    </style>
    <div class="content container-fluid">
        <div class="page-header">
            <div class="content-page-header">
                <h5>Vendors</h5>

                <div class="list-btn">
                    <ul class="filter-list">
                        <li>
                            <a href="{{ route('vendors.pdf') }}" target="_blank" class="btn btn-info">
                                Download Vendor List
                            </a>


                            <a class="btn btn-primary" href="{{ route('vendors.create') }}">
                                <i class="fa fa-plus-circle me-2" aria-hidden="true"></i>Add Vendor </a>
                        </li>
                    </ul>

                    <div id="add-payment-modal" class="modal fade" tabindex="-1" style="display: none;" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-body">
                                    <div class="text-center mt-2 mb-4">
                                        <div class="auth-logo">
                                            <a href="{{ route('index') }}" class="logo logo-dark">
                                                <span class="logo-lg">
                                                    <img src="{{ asset('assets/img/logo.png') }}" alt="Logo"
                                                        height="42">
                                                </span>
                                            </a>
                                        </div>
                                    </div>

                                    <form class="px-3" method="post" action="{{ route('products.store') }}">
                                        @csrf
                                        <!-- Input for Product Name -->
                                        <div class="mb-3">
                                            <label for="name" class="form-label">Product Name <span
                                                    class="text-danger">*</span></label>
                                            <input type="text" name="name" id="name" class="form-control"
                                                placeholder="Enter product name" value="{{ old('name') }}" required>
                                        </div>
                                        <!-- Product Model Name Input -->
                                        <div class="mb-3">
                                            <label for="model_name" class="form-label">Product Model Name <span
                                                    class="text-danger">*</span></label>
                                            <input type="text" name="model_name" id="model_name" class="form-control"
                                                placeholder="Enter product model name" value="{{ old('model_name') }}"
                                                required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="status" class="form-label">Status</label>
                                            <select class="form-select mb-3" name="status" required>
                                                <option selected="" value="1">Actve</option>
                                                <option value="0">InActve</option>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <button type="submit" class="btn btn-primary">Submit</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <!-- /Page Header -->
        
        <!-- Filter Section -->
        <div class="row mb-3">
            <div class="col-sm-12">
                <div class="card shadow-sm border-0 rounded-3">
                    <div class="card-body p-3">
                        <form action="{{ route('vendors.index') }}" method="GET">
                            <div class="row align-items-end">
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="search" class="form-label">Search</label>
                                        <input type="text" class="form-control" id="search" name="search" 
                                            value="{{ request('search') }}" placeholder="Search by name, phone, email...">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <label for="status" class="form-label">Status</label>
                                        <select class="form-select" id="status" name="status">
                                            <option value="">All Status</option>
                                            <option value="1" {{ request('status') == '1' ? 'selected' : '' }}>Active</option>
                                            <option value="0" {{ request('status') == '0' ? 'selected' : '' }}>Inactive</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <button type="submit" class="btn btn-primary w-100">
                                            <i class="fe fe-filter me-1"></i>Filter
                                        </button>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="mb-3">
                                        <a href="{{ route('vendors.index') }}" class="btn btn-secondary w-100">
                                            <i class="fe fe-refresh-ccw me-1"></i>Reset
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Search Filter -->
        <div class="row">
            <div class="col-sm-12">
                <div class="card-table">
                    <div class="card-body">
                        <div class="table-fluid">
                            <table id="productTable" class="table table-center table-hover ">
                                <thead class="thead-light">
                                    <tr>
                                        <th>#</th>
                                        <th>Name</th>
                                        <th>Phone</th>
                                        <th>Email</th>
                                        <th>Address</th>
                                        <th>Status</th>
                                        <th class="no-sort">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @forelse ($customers as $vendor)
                                        <tr>
                                            <td>{{ $loop->iteration }}</td>
                                            <td>{{ Str::limit($vendor->name, 20) }}</td>
                                            <td>{{ Str::limit($vendor->phone, 20) }}</td>
                                            <td>{{ Str::limit($vendor->email, 20) }}</td>
                                            <td>{{ Str::limit($vendor->address, 20) }}</td>
                                            <td>
                                                @if ($vendor->status == 1)
                                                    <span class="badge bg-success">Active</span>
                                                @else
                                                    <span class="badge bg-danger">Inactive</span>
                                                @endif
                                            </td>
                                            <td class="d-flex align-items-center">
                                                <div class="dropdown dropdown-action">
                                                    <a href="#" class="btn-action-icon" data-bs-toggle="dropdown">
                                                        <i class="fas fa-ellipsis-v"></i>
                                                    </a>
                                                    <div class="dropdown-menu dropdown-menu-end">
                                                        <ul>
                                                            <li>
                                                                <a class="dropdown-item"
                                                                    href="{{ route('vendors.edit', $vendor->id) }}">
                                                                    <i class="far fa-edit me-2"></i>Edit
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a onclick="if (confirm('Are you sure to delete the vendor?')) { document.getElementById('vendorDelete{{ $vendor->id }}').submit(); }"
                                                                    class="dropdown-item" href="javascript:void(0)">
                                                                    <i class="far fa-trash-alt me-2"></i>Delete
                                                                </a>
                                                                <form id="vendorDelete{{ $vendor->id }}"
                                                                    action="{{ route('vendors.destroy', $vendor->id) }}"
                                                                    method="POST" style="display:none;">
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
                                            <td colspan="7" class="text-center py-4">
                                                <i class="fe fe-inbox fa-3x text-muted mb-3 d-block"></i>
                                                <span class="text-muted">No vendors found</span>
                                            </td>
                                        </tr>
                                    @endforelse
                                </tbody>
                            </table>

                            <!-- Pagination -->
                            <div class="d-flex justify-content-end mt-3">
                                {{ $customers->links('pagination::bootstrap-5') }}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
@endsection
