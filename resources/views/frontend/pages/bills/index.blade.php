@extends('layouts.app')

@section('content')
    <div class="container-fluid">
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <div class="d-flex justify-content-between align-items-center">
                            <h4 class="mb-0">Bills Management</h4>
                            <div>
                                <a href="{{ route('bills.create') }}" class="btn btn-primary">
                                    <i class="fas fa-plus"></i> Create New Bill
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <!-- Filters -->
                        <div class="row mb-4">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-body">
                                        <form action="{{ route('bills.index') }}" method="GET" id="filterForm">
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label>Bill Type</label>
                                                        <select name="type" class="form-control"
                                                            onchange="document.getElementById('filterForm').submit()">
                                                            <option value="">All Bills</option>
                                                            <option value="projects"
                                                                {{ request('type') == 'projects' ? 'selected' : '' }}>
                                                                Project Bills</option>
                                                            <option value="sales"
                                                                {{ request('type') == 'sales' ? 'selected' : '' }}>Sales
                                                                Bills</option>
                                                            {{-- <option value="purchases"
                                                                {{ request('type') == 'purchases' ? 'selected' : '' }}>
                                                                Purchase Bills</option> --}}
                                                        </select>
                                                    </div>
                                                </div>
                                                {{-- <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label>Status</label>
                                                        <select name="status" class="form-control"
                                                            onchange="document.getElementById('filterForm').submit()">
                                                            <option value="">All Status</option>
                                                            <option value="draft"
                                                                {{ request('status') == 'draft' ? 'selected' : '' }}>Draft
                                                            </option>
                                                            <option value="sent"
                                                                {{ request('status') == 'sent' ? 'selected' : '' }}>Sent
                                                            </option>
                                                            <option value="paid"
                                                                {{ request('status') == 'paid' ? 'selected' : '' }}>Paid
                                                            </option>
                                                            <option value="overdue"
                                                                {{ request('status') == 'overdue' ? 'selected' : '' }}>
                                                                Overdue</option>
                                                            <option value="cancelled"
                                                                {{ request('status') == 'cancelled' ? 'selected' : '' }}>
                                                                Cancelled</option>
                                                        </select>
                                                    </div>
                                                </div> --}}
                                                <div class="col-md-2">
                                                    <div class="form-group">
                                                        <label>From Date</label>
                                                        <input type="date" name="from_date" class="form-control"
                                                            value="{{ request('from_date') }}"
                                                            onchange="document.getElementById('filterForm').submit()">
                                                    </div>
                                                </div>
                                                <div class="col-md-2">
                                                    <div class="form-group">
                                                        <label>To Date</label>
                                                        <input type="date" name="to_date" class="form-control"
                                                            value="{{ request('to_date') }}"
                                                            onchange="document.getElementById('filterForm').submit()">
                                                    </div>
                                                </div>
                                                <div class="col-md-2">
                                                    <div class="form-group">
                                                        <label>&nbsp;</label>
                                                        <div>
                                                            <a href="{{ route('bills.index') }}"
                                                                class="btn btn-secondary">Clear</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <!-- Bills Table -->
                        <div class="card">
                            <div class="card-body">
                                <div class="table-fluid">
                                    <table class="table table-bordered table-hover" id="billsTable">
                                        <thead class="thead-light">
                                            <tr>
                                                <th>Bill Number</th>
                                                <th>Reference</th>
                                                <th>Bill Date</th>
                                                <th>Amount</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            @forelse($bills as $bill)
                                                <tr>
                                                    <td>
                                                        <strong>{{ $bill->bill_number }}</strong>
                                                    </td>
                                                    <td>{{ $bill->reference_number }}</td>
                                                    <td>{{ $bill->bill_date->format('M d, Y') }}</td>
                                                    <td>
                                                        <strong>৳{{ number_format($bill->total_amount, 2) }}</strong>
                                                    </td>
                                                    <td class="d-flex align-items-center">
                                                        <div class="dropdown dropdown-action">
                                                            <a href="#" class="btn-action-icon"
                                                                data-bs-toggle="dropdown">
                                                                <i class="fas fa-ellipsis-v"></i>
                                                            </a>
                                                            <div class="dropdown-menu dropdown-menu-end">
                                                                <ul>
                                                                    <li>
                                                                        <a class="dropdown-item"
                                                                            href="{{ route('bills.show', $bill->id) }}">
                                                                            <i class="far fa-eye me-2"></i>Preview
                                                                        </a>
                                                                        {{-- <a class="dropdown-item"
                                                                            href="{{ route('bills.show', $bill->id) }}">
                                                                            <i class="far fa-eye me-2"></i>View
                                                                        </a> --}}
                                                                    </li>

                                                                    <a class="dropdown-item"
                                                                        href="{{ route('bills.download', $bill->id) }}">
                                                                        <i class="fas fa-download me-2"></i>Download PDF
                                                                    </a>

                                                                    </li>
                                                                    <li>
                                                                        <a onclick="if (confirm('Are you sure to delete?')) { document.getElementById('serviceDelete{{ $bill->id }}').submit(); }"
                                                                            class="dropdown-item" href="javascript:void(0)">
                                                                            <i class="far fa-trash-alt me-2"></i>Delete
                                                                        </a>
                                                                        <form id="serviceDelete{{ $bill->id }}"
                                                                            action="{{ route('projects.destroy', $bill->id) }}"
                                                                            method="POST" style="display:none;">
                                                                            @csrf
                                                                            @method('DELETE')
                                                                        </form>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    {{-- <td>
                                                        <div class="btn-group" role="group">
                                                            <a href="{{ route('bills.show', $bill) }}"
                                                                class="btn btn-sm btn-info" title="View">
                                                                <i class="fas fa-eye"></i>
                                                            </a>
                                                            <a href="{{ route('bills.preview', $bill) }}" target="_blank"
                                                                class="btn btn-sm btn-warning" title="Preview PDF">
                                                                <i class="fas fa-file-pdf"></i>
                                                            </a>
                                                            <a href="{{ route('bills.download', $bill) }}"
                                                                class="btn btn-sm btn-success" title="Download PDF">
                                                                <i class="fas fa-download"></i>
                                                            </a>
                                                            <div class="btn-group" role="group">
                                                                <button id="statusDropdown{{ $bill->id }}"
                                                                    type="button"
                                                                    class="btn btn-sm btn-secondary dropdown-toggle"
                                                                    data-toggle="dropdown" aria-haspopup="true"
                                                                    aria-expanded="false">
                                                                    <i class="fas fa-cog"></i>
                                                                </button>
                                                                <div class="dropdown-menu"
                                                                    aria-labelledby="statusDropdown{{ $bill->id }}">
                                                                    <h6 class="dropdown-header">Change Status</h6>
                                                                    <a class="dropdown-item status-change" href="#"
                                                                        data-bill-id="{{ $bill->id }}"
                                                                        data-status="draft">
                                                                        <span class="badge badge-warning mr-2">●</span>
                                                                        Draft
                                                                    </a>
                                                                    <a class="dropdown-item status-change" href="#"
                                                                        data-bill-id="{{ $bill->id }}"
                                                                        data-status="sent">
                                                                        <span class="badge badge-info mr-2">●</span> Sent
                                                                    </a>
                                                                    <a class="dropdown-item status-change" href="#"
                                                                        data-bill-id="{{ $bill->id }}"
                                                                        data-status="paid">
                                                                        <span class="badge badge-success mr-2">●</span>
                                                                        Paid
                                                                    </a>
                                                                    <a class="dropdown-item status-change" href="#"
                                                                        data-bill-id="{{ $bill->id }}"
                                                                        data-status="cancelled">
                                                                        <span class="badge badge-secondary mr-2">●</span>
                                                                        Cancelled
                                                                    </a>
                                                                    <div class="dropdown-divider"></div>
                                                                    <a class="dropdown-item text-danger" href="#"
                                                                        onclick="confirmDelete({{ $bill->id }})">
                                                                        <i class="fas fa-trash mr-2"></i> Delete
                                                                    </a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </td> --}}
                                                </tr>
                                            @empty
                                                <tr>
                                                    <td colspan="8" class="text-center py-4">
                                                        <div class="text-muted">
                                                            {{-- <i class="fas fa-file-invoice fa-3x mb-3"></i> --}}
                                                            <h5>No bills found</h5>
                                                            {{-- <p>Create your first bill to get started</p>
                                                            <a href="{{ route('bills.create') }}"
                                                                class="btn btn-primary">
                                                                <i class="fas fa-plus"></i> Create Bill
                                                            </a> --}}
                                                        </div>
                                                    </td>
                                                </tr>
                                            @endforelse
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Pagination -->
                                @if ($bills->hasPages())
                                    <div class="d-flex justify-content-between align-items-center mt-4">
                                        <div class="text-muted">
                                            Showing {{ $bills->firstItem() }} to {{ $bills->lastItem() }} of
                                            {{ $bills->total() }} entries
                                        </div>
                                        <div>
                                            {{ $bills->links() }}
                                        </div>
                                    </div>
                                @endif
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Status Update Modal -->
    <div class="modal fade" id="statusModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Update Bill Status</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span>&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to update the bill status to <strong id="statusText"></strong>?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" id="confirmStatusUpdate">Update Status</button>
                </div>
            </div>
        </div>
    </div>
@endsection

@push('styles')
    <style>
        .table th {
            border-top: none;
            font-weight: 600;
            font-size: 0.875rem;
            text-transform: uppercase;
            color: #6c757d;
        }

        .badge {
            font-size: 0.75rem;
            padding: 0.35em 0.65em;
        }

        .btn-group .btn {
            border-radius: 0.25rem;
            margin-right: 0.25rem;
        }

        .card {
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
            border: 1px solid rgba(0, 0, 0, 0.125);
        }

        .stat-card {
            transition: transform 0.2s;
        }

        .stat-card:hover {
            transform: translateY(-2px);
        }
    </style>
@endpush

@push('scripts')
    <script>
        let currentBillId = null;
        let currentStatus = null;

        // Status change handler
        document.querySelectorAll('.status-change').forEach(button => {
            button.addEventListener('click', function(e) {
                e.preventDefault();
                currentBillId = this.dataset.billId;
                currentStatus = this.dataset.status;

                const statusText = this.dataset.status.charAt(0).toUpperCase() + this.dataset.status.slice(
                    1);
                document.getElementById('statusText').textContent = statusText;

                $('#statusModal').modal('show');
            });
        });

        // Confirm status update
        document.getElementById('confirmStatusUpdate').addEventListener('click', function() {
            if (!currentBillId || !currentStatus) return;

            fetch(`/bills/${currentBillId}/status`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'X-CSRF-TOKEN': '{{ csrf_token() }}'
                    },
                    body: JSON.stringify({
                        status: currentStatus
                    })
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        location.reload();
                    } else {
                        alert('Error updating status: ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Error updating status');
                })
                .finally(() => {
                    $('#statusModal').modal('hide');
                });
        });

        // Delete confirmation
        function confirmDelete(billId) {
            if (confirm('Are you sure you want to delete this bill? This action cannot be undone.')) {
                // Implement delete functionality here
                alert('Delete functionality to be implemented');
            }
        }

        // Auto-submit filter form on date changes
        document.querySelectorAll('input[type="date"]').forEach(input => {
            input.addEventListener('change', function() {
                document.getElementById('filterForm').submit();
            });
        });
    </script>
@endpush
