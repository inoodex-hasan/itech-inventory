@extends('frontend.layouts.app')
@section('content')
    <div class="content container-fluid">
        <div class="page-header">
            <div class="content-page-header mt-5">
                <h5>Service List</h5>
                <div class="list-btn">
                    <ul class="filter-list">
                        <li>
                            <a class="btn btn-primary" href="{{ route('service.create') }}">
                                <i class="fa fa-plus-circle me-2" aria-hidden="true"></i>Add Service
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-sm-12">
                <div class="card shadow-sm border-0 rounded-3">
                    <div class="card-body p-3">
                        <form action="{{ route('service.index') }}" method="get">
                            <div class="row align-items-end">
                                <div class="col-md-2">
                                    <div class="mb-3">
                                        <label class="form-label">From</label>
                                        <input type="date" name="from" class="form-control"
                                            value="{{ $request->from ?? '' }}">
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="mb-3">
                                        <label class="form-label">To</label>
                                        <input type="date" name="to" class="form-control"
                                            value="{{ $request->to ?? '' }}">
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="mb-3">
                                        <label class="form-label">Service Type</label>
                                        <select name="service_type" class="form-select">
                                            <option value="">All</option>
                                            <option value="paid"
                                                {{ ($request->service_type ?? '') == 'paid' ? 'selected' : '' }}>Paid
                                            </option>
                                            <option value="due"
                                                {{ ($request->service_type ?? '') == 'due' ? 'selected' : '' }}>Due</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="mb-3">
                                        <label class="form-label">Search By</label>
                                        <select name="serach_by" class="form-select">
                                            <option value="">-- Select --</option>
                                            <option value="name"
                                                {{ ($request->serach_by ?? '') == 'name' ? 'selected' : '' }}>Name</option>
                                            <option value="phone"
                                                {{ ($request->serach_by ?? '') == 'phone' ? 'selected' : '' }}>Phone
                                            </option>
                                            <option value="email"
                                                {{ ($request->serach_by ?? '') == 'email' ? 'selected' : '' }}>Email
                                            </option>
                                            <option value="product_name"
                                                {{ ($request->serach_by ?? '') == 'product_name' ? 'selected' : '' }}>
                                                Product Name</option>
                                            <option value="product_number"
                                                {{ ($request->serach_by ?? '') == 'product_number' ? 'selected' : '' }}>
                                                Product Number</option>
                                            <option value="repaired_by"
                                                {{ ($request->serach_by ?? '') == 'repaired_by' ? 'selected' : '' }}>
                                                Repaired By</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="mb-3">
                                        <label class="form-label">Search Key</label>
                                        <input type="text" name="key" class="form-control"
                                            value="{{ $request->key ?? '' }}" placeholder="Search...">
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="mb-3 d-flex gap-2">
                                        <button type="submit" name="search_for" value="filter"
                                            class="btn btn-primary flex-fill">
                                            <i class="fe fe-filter me-1"></i>Filter
                                        </button>
                                        {{-- <button type="submit" name="search_for" value="pdf" class="btn btn-secondary">
                                            <i class="fe fe-download"></i>
                                        </button>
                                        <a href="{{ route('service.index') }}" class="btn btn-secondary">
                                            <i class="fe fe-refresh-ccw"></i>
                                        </a> --}}
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="card-table">
                <div class="card-body">
                    <div class="table-fluid table-fluid">
                        <table class="table table-center table-hover table-nowrap">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Date</th>
                                    <th>Name</th>
                                    <th>Phone</th>
                                    <th>Product</th>
                                    {{-- <th>Total</th>
                                    <th>Discount</th> --}}
                                    <th>Bill</th>
                                    {{-- <th>Paid</th> --}}
                                    <th>Due</th>
                                    <th>Status</th>
                                    {{-- <th>Warranty</th>
                                <th>Remaining</th> --}}
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse ($services as $service)
                                    @php
                                        $warrantyPeriod = (int) ($service->warranty_duration ?? 0);
                                        $createdAt = \Carbon\Carbon::parse($service->created_at);
                                        $warrantyExpiresAt = $createdAt->copy()->addDays($warrantyPeriod);
                                        $remainingDays =
                                            $warrantyPeriod > 0 ? now()->diffInDays($warrantyExpiresAt, false) : 0;
                                    @endphp
                                    <tr>
                                        <td>{{ $loop->iteration }}</td>
                                        <td>{{ $service->created_at->format('Y-m-d') }}</td>
                                        <td>{{ $service->name }}</td>
                                        <td>{{ $service->phone }}</td>
                                        <td>{{ Str::limit(optional($service->product)->name ?? $service->product_name, 20) }}
                                        </td>
                                        {{-- <td>{{ $service->total }}</td>
                                        <td>{{ $service->discount }}</td> --}}
                                        <td>
                                            <span class="badge bg-primary"
                                                style="font-size: 0.9rem; padding: 0.5rem 0.75rem;">
                                                {{ number_format($service->bill, 2) }}
                                            </span>
                                        </td>
                                        {{-- <td>{{ $service->paid_amount }}</td> --}}
                                        <td>
                                            @if ($service->due_amount > 0)
                                                <span class="badge bg-danger"
                                                    style="font-size: 0.9rem; padding: 0.5rem 0.75rem;">
                                                    {{ number_format($service->due_amount, 2) }}
                                                </span>
                                            @else
                                                <span class="badge bg-success"
                                                    style="font-size: 0.9rem; padding: 0.5rem 0.75rem;">
                                                    0.00
                                                </span>
                                            @endif
                                        </td>
                                        <td>
                                            @if ($service->due_amount <= 0)
                                                <span class="badge bg-success">Paid</span>
                                            @else
                                                {!! $service->status_badge !!}
                                            @endif
                                        </td>
                                        {{-- <td>{{ $service->warranty_duration ?? 0 }}</td>
                                        <td>{{ max(0, $remainingDays) }}</td> --}}
                                        <td>
                                            <div class="dropdown">
                                                <a href="#" class="btn-action-icon" data-bs-toggle="dropdown">
                                                    <i class="fas fa-ellipsis-v"></i>
                                                </a>
                                                <div class="dropdown-menu dropdown-menu-end">
                                                    <a class="dropdown-item"
                                                        href="{{ route('service.payments', ['id' => $service->id, 'payment_for' => '1']) }}">
                                                        @if ($service->due_amount <= 0)
                                                            View
                                                        @else
                                                            Get Payments
                                                        @endif
                                                    </a>
                                                    <a class="dropdown-item" target="_blank"
                                                        href="{{ route('service.invoice', $service->id) }}">Invoice</a>
                                                    {{-- <a class="dropdown-item"
                                                        href="{{ route('service.edit', $service->id) }}">Edit</a> --}}
                                                    {{-- <a class="dropdown-item" href="javascript:void(0)"
                                                        onclick="if (confirm('Are you sure to complete the service?')) { document.getElementById('serviceConfirm{{ $service->id }}').submit(); }">Completed</a> --}}
                                                    <form id="serviceConfirm{{ $service->id }}"
                                                        action="{{ route('service.makecomplate', $service->id) }}"
                                                        method="post">
                                                        @csrf
                                                    </form>
                                                    <form method="POST"
                                                        action="{{ route('service.destroy', $service->id) }}">
                                                        @csrf
                                                        @method('DELETE')
                                                        <button type="submit" class="dropdown-item"
                                                            onclick="return confirm('Are you sure to delete the service?')">Delete</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                @empty
                                    <tr>
                                        <td colspan="13" class="text-center py-4">No services found.</td>
                                    </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
