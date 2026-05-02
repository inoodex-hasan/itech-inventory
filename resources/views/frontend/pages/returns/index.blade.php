@extends('frontend.layouts.app')

@section('content')
    <div class="content container-fluid">
        <div class="page-header">
            <div class="content-page-header">
                <h5 class="card-title fw-bold">Product Returns</h5>
            </div>
        </div>

        <!-- Filters -->
        <div class="card mb-3">
            <div class="card-body">
                <form method="GET" action="{{ route('returns.index') }}">
                    <div class="row g-2">
                        <div class="col-md-3">
                            <input type="text" name="search" class="form-control" placeholder="Search (ID, Order, Customer)"
                                value="{{ request('search') }}">
                        </div>
                        <div class="col-md-2">
                            <select name="status" class="form-select">
                                <option value="">All Status</option>
                                <option value="pending" {{ request('status') == 'pending' ? 'selected' : '' }}>Pending</option>
                                <option value="approved" {{ request('status') == 'approved' ? 'selected' : '' }}>Approved</option>
                                <option value="completed" {{ request('status') == 'completed' ? 'selected' : '' }}>Completed</option>
                                <option value="rejected" {{ request('status') == 'rejected' ? 'selected' : '' }}>Rejected</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <select name="customer_id" class="form-select">
                                <option value="">All Customers</option>
                                @foreach($customers as $customer)
                                    <option value="{{ $customer->id }}" {{ request('customer_id') == $customer->id ? 'selected' : '' }}>
                                        {{ $customer->name }}
                                    </option>
                                @endforeach
                            </select>
                        </div>
                        <div class="col-md-2">
                            <input type="date" name="date_from" class="form-control" placeholder="From Date"
                                value="{{ request('date_from') }}">
                        </div>
                        <div class="col-md-2">
                            <input type="date" name="date_to" class="form-control" placeholder="To Date"
                                value="{{ request('date_to') }}">
                        </div>
                        <div class="col-md-1">
                            <button type="submit" class="btn btn-primary w-100">Filter</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Returns Table -->
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="card-title mb-0">Return List</h5>
                <a href="{{ route('returns.create') }}" class="btn btn-primary">
                    <i class="fa fa-plus me-2"></i>New Return
                </a>
            </div>
            <div class="card-body">
                <div class="table-responsive" style="overflow: visible;">
                    <table class="table table-hover">
                        <thead class="thead-light">
                            <tr>
                                <th>#</th>
                                <th>Return Date</th>
                                <th>Order No</th>
                                <th>Customer</th>
                                <th>Items</th>
                                <th>Refund Amount</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($returns as $return)
                                <tr>
                                    <td>{{ $return->id }}</td>
                                    <td>{{ $return->return_date->format('d M Y') }}</td>
                                    <td>
                                        @if($return->sale)
                                            <a href="{{ route('sales.show', $return->sale_id) }}" class="text-decoration-none">
                                                {{ $return->sale->order_no }}
                                            </a>
                                        @else
                                            <span class="text-muted">N/A</span>
                                        @endif
                                    </td>
                                    <td>{{ $return->customer->name ?? 'N/A' }}</td>
                                    <td>{{ $return->items->count() }} items</td>
                                    <td>{{ number_format($return->total_refund_amount, 2) }}</td>
                                    <td>
                                        @php
                                            $statusBadge = [
                                                'pending' => 'warning',
                                                'approved' => 'info',
                                                'completed' => 'success',
                                                'rejected' => 'danger'
                                            ][$return->status] ?? 'secondary';
                                        @endphp
                                        <span class="badge bg-{{ $statusBadge }}">
                                            {{ ucfirst($return->status) }}
                                        </span>
                                    </td>
                                    <td class="d-flex align-items-center">
                                        <div class="dropdown dropdown-action">
                                            <a href="#" class="btn-action-icon" data-bs-toggle="dropdown" aria-expanded="false">
                                                <i class="fas fa-ellipsis-v"></i>
                                            </a>
                                            <div class="dropdown-menu dropdown-menu-end">
                                                <ul>
                                                    <li>
                                                        <a class="dropdown-item" href="{{ route('returns.show', $return->id) }}">
                                                            <i class="far fa-eye me-2"></i>View
                                                        </a>
                                                    </li>
                                                    @if($return->isPending())
                                                        <li>
                                                            <form method="POST" action="{{ route('returns.approve', $return->id) }}"
                                                                class="d-inline" onsubmit="return confirm('Approve this return?')">
                                                                @csrf
                                                                @method('PATCH')
                                                                <button type="submit" class="dropdown-item text-success bg-transparent border-0 w-100 text-start">
                                                                    <i class="far fa-check-circle me-2"></i>Approve
                                                                </button>
                                                            </form>
                                                        </li>
                                                        <li>
                                                            <a class="dropdown-item text-danger" href="#" data-bs-toggle="modal"
                                                                data-bs-target="#rejectModal{{ $return->id }}">
                                                                <i class="far fa-times-circle me-2"></i>Reject
                                                            </a>
                                                        </li>
                                                    @endif
                                                    @if($return->isApproved())
                                                        <li>
                                                            <form method="POST" action="{{ route('returns.complete', $return->id) }}"
                                                                class="d-inline" onsubmit="return confirm('Complete return and update stock?')">
                                                                @csrf
                                                                @method('PATCH')
                                                                <button type="submit" class="dropdown-item text-primary bg-transparent border-0 w-100 text-start">
                                                                    <i class="fas fa-box me-2"></i>Complete & Update
                                                                </button>
                                                            </form>
                                                        </li>
                                                    @endif
                                                    @if($return->isPending() || $return->isRejected())
                                                        <li>
                                                            <hr class="dropdown-divider">
                                                        </li>
                                                        <li>
                                                            <form method="POST" action="{{ route('returns.destroy', $return->id) }}"
                                                                class="d-inline" onsubmit="return confirm('Delete this return?')">
                                                                @csrf
                                                                @method('DELETE')
                                                                <button type="submit" class="dropdown-item text-danger bg-transparent border-0 w-100 text-start">
                                                                    <i class="far fa-trash-alt me-2"></i>Delete
                                                                </button>
                                                            </form>
                                                        </li>
                                                    @endif
                                                </ul>
                                            </div>
                                        </div>

                                        <!-- Reject Modal -->
                                        @if($return->isPending())
                                            <div class="modal fade" id="rejectModal{{ $return->id }}" tabindex="-1">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <form method="POST" action="{{ route('returns.reject', $return->id) }}">
                                                            @csrf
                                                            @method('PATCH')
                                                            <div class="modal-header">
                                                                <h5 class="modal-title">Reject Return #{{ $return->id }}</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <div class="mb-3">
                                                                    <label class="form-label">Rejection Reason</label>
                                                                    <textarea name="reason" class="form-control" rows="3"
                                                                        placeholder="Enter reason for rejection" required></textarea>
                                                                </div>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                                <button type="submit" class="btn btn-danger">Reject Return</button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        @endif
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="8" class="text-center py-4">No returns found</td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
@endsection
