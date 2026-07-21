@extends('frontend.layouts.app')
@push('styles')
    <style>
        #customersTable td, #customersTable th {
            padding-left: 12px !important;
            padding-right: 12px !important;
        }
    </style>
@endpush
@section('content')
    <div class="content container-fluid">

        <div class="page-header">
            <div class="content-page-header">
                <h5>Customers</h5>
                <div class="list-btn">
                    <ul class="filter-list">
                        <li>
                            <a class="btn btn-primary" href="{{ route('customers.create') }}">
                                <i class="fa fa-plus-circle me-2" aria-hidden="true"></i>Add Customer
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-sm-12">
                <div class="card-table">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover datatable" id="customersTable">
                                <thead class="thead-light">
                                    <tr>
                                        <th>#</th>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Phone</th>
                                        <th>Status</th>
                                        <th class="no-sort">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @forelse ($customers as $key => $customer)
                                        <tr>
                                            <td>{{ $loop->iteration }}</td>
                                            <td>
                                                <strong>{{ Str::limit($customer->name, 30) }}</strong>
                                            </td>
                                            <td>{{ Str::limit($customer->email, 20) ?: 'N/A' }}</td>
                                            <td>{{ $customer->phone }}</td>
                                            <td>
                                                @if ($customer->status == 'active' || $customer->status == 1 || $customer->status == '1')
                                                    <span class="badge bg-success">Active</span>
                                                @else
                                                    <span class="badge bg-danger">Inactive</span>
                                                @endif
                                            </td>
                                            <td>
                                                <div class="dropdown">
                                                    <a href="#" class="btn-action-icon" data-bs-toggle="dropdown">
                                                        <i class="fas fa-ellipsis-v"></i>
                                                    </a>
                                                    <div class="dropdown-menu dropdown-menu-end shadow-sm rounded-3">
                                                        <ul class="list-unstyled mb-0">
                                                            <li>
                                                                <a class="dropdown-item"
                                                                    href="{{ route('customers.edit', $customer->id) }}">
                                                                    <i class="far fa-edit me-2"></i>Edit
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a class="dropdown-item text-danger"
                                                                    href="javascript:void(0)"
                                                                    onclick="if (confirm('Are you sure to delete the customer?')) { document.getElementById('delete{{ $customer->id }}').submit(); }">
                                                                    <i class="far fa-trash-alt me-2"></i>Delete
                                                                </a>
                                                                <form id="delete{{ $customer->id }}"
                                                                    action="{{ route('customers.destroy', $customer->id) }}"
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
                                            <td colspan="6" class="text-center py-4">
                                                <i class="fe fe-inbox fa-3x text-muted mb-3 d-block"></i>
                                                <span class="text-muted">No customers found</span>
                                            </td>
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