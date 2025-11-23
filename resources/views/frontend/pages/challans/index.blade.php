@extends('layouts.app')

@section('content')
    <div class="container-fluid">
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <div class="d-flex justify-content-between align-items-center">
                            <h4 class="mb-0">Challan Management</h4>
                            <a href="{{ route('challans.create') }}" class="btn btn-primary">
                                <i class="fas fa-plus me-2"></i>Create New Challan
                            </a>
                        </div>
                    </div>
                    <div class="card-body">
                        <!-- Filters -->
                        <div class="row mb-4">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label class="form-label">Search</label>
                                    <input type="text" class="form-control" id="searchInput"
                                        placeholder="Search challans...">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label class="form-label">Type</label>
                                    <select class="form-control" id="typeFilter">
                                        <option value="">All Types</option>
                                        <option value="sale">Sales Challan</option>
                                        <option value="project">Project Challan</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label class="form-label">Date From</label>
                                    <input type="date" class="form-control" id="dateFrom">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label class="form-label">Date To</label>
                                    <input type="date" class="form-control" id="dateTo">
                                </div>
                            </div>
                        </div>

                        <!-- Challan List -->
                        <div class="table-fluid">
                            <table class="table table-bordered table-hover" id="challansTable">
                                <thead class="table-light">
                                    <tr>
                                        <th width="8%">Challan No.</th>
                                        <th width="12%">Reference No.</th>
                                        <th width="10%">Date</th>
                                        <th width="12%">Type</th>
                                        <th>Recipient</th>
                                        <th width="10%">Items</th>
                                        <th width="15%">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @forelse($challans as $challan)
                                        <tr>
                                            <td>
                                                <span class="fw-bold text-primary">{{ $challan->challan_number }}</span>
                                            </td>
                                            <td>{{ $challan->reference_number }}</td>
                                            <td>{{ $challan->challan_date->format('M d, Y') }}</td>
                                            <td>
                                                <span class="badge bg-{{ $challan->type == 'sale' ? 'primary' : 'info' }}">
                                                    {{ ucfirst($challan->type) }} Challan
                                                </span>
                                            </td>
                                            <td>
                                                <div class="d-flex flex-column">
                                                    <span
                                                        class="fw-semibold">{{ Str::limit($challan->recipient_organization, 30) }}</span>
                                                    <small
                                                        class="text-muted">{{ Str::limit($challan->recipient_address, 25) }}</small>
                                                </div>
                                            </td>
                                            <td class="text-center">
                                                <span class="badge bg-secondary rounded-pill">
                                                    {{ $challan->challanItems->count() }} items
                                                </span>
                                            </td>
                                            <td>
                                                <div class="btn-group" role="group">
                                                    <a href="{{ route('challans.show', $challan->id) }}"
                                                        class="btn btn-sm btn-outline-primary" title="Preview">
                                                        <i class="far fa-eye"></i>
                                                    </a>
                                                    <a href="{{ route('challans.download', $challan->id) }}"
                                                        class="btn btn-sm btn-outline-success" title="Download PDF">
                                                        <i class="fas fa-download"></i>
                                                    </a>
                                                    <button type="button" class="btn btn-sm btn-outline-danger"
                                                        title="Delete" onclick="confirmDelete({{ $challan->id }})">
                                                        <i class="far fa-trash-alt"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    @empty
                                        <tr>
                                            <td colspan="7" class="text-center py-4">
                                                <div class="text-muted">

                                                    <h5>No Challans Found</h5>

                                                </div>
                                            </td>
                                        </tr>
                                    @endforelse
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination -->
                        @if ($challans->hasPages())
                            <div class="d-flex justify-content-between align-items-center mt-4">
                                <div class="text-muted">
                                    Showing {{ $challans->firstItem() }} to {{ $challans->lastItem() }} of
                                    {{ $challans->total() }} entries
                                </div>
                                <nav>
                                    {{ $challans->links() }}
                                </nav>
                            </div>
                        @endif
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Confirm Delete</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete this challan? This action cannot be undone.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <form id="deleteForm" method="POST" style="display: inline;">
                        @csrf
                        @method('DELETE')
                        <button type="submit" class="btn btn-danger">Delete Challan</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
@endsection

@push('scripts')
    <script>
        // Search functionality
        document.getElementById('searchInput').addEventListener('input', function() {
            const searchValue = this.value.toLowerCase();
            const rows = document.querySelectorAll('#challansTable tbody tr');

            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(searchValue) ? '' : 'none';
            });
        });

        // Filter by type
        document.getElementById('typeFilter').addEventListener('change', function() {
            const filterValue = this.value;
            const rows = document.querySelectorAll('#challansTable tbody tr');

            rows.forEach(row => {
                if (!filterValue) {
                    row.style.display = '';
                    return;
                }

                const typeCell = row.cells[3];
                const typeText = typeCell.textContent.toLowerCase();
                row.style.display = typeText.includes(filterValue) ? '' : 'none';
            });
        });

        // Date filter functionality
        function filterByDate() {
            const dateFrom = document.getElementById('dateFrom').value;
            const dateTo = document.getElementById('dateTo').value;
            const rows = document.querySelectorAll('#challansTable tbody tr');

            rows.forEach(row => {
                if (!dateFrom && !dateTo) {
                    row.style.display = '';
                    return;
                }

                const dateCell = row.cells[2];
                const dateText = dateCell.textContent.trim();
                const rowDate = new Date(dateText);

                let showRow = true;

                if (dateFrom) {
                    const fromDate = new Date(dateFrom);
                    if (rowDate < fromDate) showRow = false;
                }

                if (dateTo) {
                    const toDate = new Date(dateTo);
                    if (rowDate > toDate) showRow = false;
                }

                row.style.display = showRow ? '' : 'none';
            });
        }

        document.getElementById('dateFrom').addEventListener('change', filterByDate);
        document.getElementById('dateTo').addEventListener('change', filterByDate);

        // Delete confirmation
        function confirmDelete(challanId) {
            const form = document.getElementById('deleteForm');
            form.action = `/challans/${challanId}`;
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }

        // Reset filters
        function resetFilters() {
            document.getElementById('searchInput').value = '';
            document.getElementById('typeFilter').value = '';
            document.getElementById('dateFrom').value = '';
            document.getElementById('dateTo').value = '';

            const rows = document.querySelectorAll('#challansTable tbody tr');
            rows.forEach(row => row.style.display = '');
        }
    </script>

    <style>
        .table th {
            border-top: none;
            font-weight: 600;
            color: #495057;
            background-color: #f8f9fa;
        }

        .btn-group .btn {
            border-radius: 0.375rem;
            margin-right: 0.25rem;
        }

        .btn-group .btn:last-child {
            margin-right: 0;
        }

        .badge {
            font-size: 0.75em;
        }

        #challansTable tbody tr:hover {
            background-color: #f8f9fa;
        }
    </style>
@endpush
