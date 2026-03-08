@extends('frontend.layouts.app')
@section('content')
    <div class="content container-fluid">
        <div class="row">
            <div class="col-sm-12">
                <!-- Page Header -->
                <div class="page-header mb-3">
                    <div class="content-page-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Categories</h5>
                        <a class="btn btn-primary" href="{{ route('categories.create') }}">
                            <i class="fa fa-plus-circle me-2"></i>Add Category
                        </a>
                    </div>
                </div>

                <!-- Filter Section -->
                <div class="card shadow-sm border-0 rounded-3 mb-3">
                    <div class="card-body p-3">
                        <form action="{{ route('categories.index') }}" method="GET">
                            <div class="row align-items-end">
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="search" class="form-label">Search</label>
                                        <input type="text" class="form-control" id="search" name="search" 
                                            value="{{ request('search') }}" placeholder="Search by name, slug...">
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
                                        <a href="{{ route('categories.index') }}" class="btn btn-secondary w-100">
                                            <i class="fe fe-refresh-ccw me-1"></i>Reset
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Card with Table -->
                <div class="card shadow-sm border-0 rounded-3">
                    <div class="card-body p-4">
                        @include('layouts.flash-message')

                        <div class="table-responsive">
                            <table id="categoryTable" class="table table-hover align-middle text-center w-100">
                                <thead class="bg-light">
                                    <tr>
                                        <th class="w-auto">#</th>
                                        <th class="w-auto">Image</th>
                                        <th class="w-auto">Name</th>
                                        <th class="w-auto">Slug</th>
                                        <th class="w-auto">Order</th>
                                        <th class="w-auto">Status</th>
                                        <th class="w-auto">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @forelse ($categories as $category)
                                        <tr>
                                            <td>{{ $loop->iteration }}</td>
                                            <td>
                                                @if ($category->image)
                                                    <img src="{{ asset($category->image) }}" alt="{{ $category->name }}"
                                                        style="width: 50px; height: 50px; object-fit: cover; border-radius: 5px;">
                                                @else
                                                    <span class="text-muted">No Image</span>
                                                @endif
                                            </td>
                                            <td>{{ $category->name }}</td>
                                            <td>{{ $category->slug }}</td>
                                            <td>{{ $category->order_by }}</td>
                                            <td>
                                                @if ($category->status == 1)
                                                    <span class="badge bg-success">Active</span>
                                                @else
                                                    <span class="badge bg-danger">Inactive</span>
                                                @endif
                                            </td>
                                            <td class="d-flex justify-content-center align-items-center">
                                                <div class="dropdown">
                                                    <a href="#" class="btn-action-icon" data-bs-toggle="dropdown">
                                                        <i class="fas fa-ellipsis-v"></i>
                                                    </a>
                                                    <div class="dropdown-menu dropdown-menu-end shadow-sm rounded-3">
                                                        <a class="dropdown-item"
                                                            href="{{ route('categories.edit', $category->id) }}">
                                                            <i class="far fa-edit me-2"></i>Edit
                                                        </a>
                                                        <a onclick="if (confirm('Are you sure to delete this category?')) { document.getElementById('deleteCategory{{ $category->id }}').submit(); }"
                                                            class="dropdown-item" href="javascript:void(0)">
                                                            <i class="far fa-trash-alt me-2"></i>Delete
                                                        </a>
                                                        <form id="deleteCategory{{ $category->id }}"
                                                            action="{{ route('categories.destroy', $category->id) }}"
                                                            method="POST" style="display: none;">
                                                            @csrf
                                                            @method('DELETE')
                                                        </form>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    @empty
                                        <tr>
                                            <td colspan="7" class="text-center py-4">
                                                <i class="fe fe-inbox fa-3x text-muted mb-3 d-block"></i>
                                                <span class="text-muted">No categories found</span>
                                            </td>
                                        </tr>
                                    @endforelse
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Pagination -->
                <div class="d-flex justify-content-end mt-3">
                    {{ $categories->links('pagination::bootstrap-5') }}
                </div>
            </div>
        </div>
    </div>

    @push('scripts')
        <script>
            $(document).ready(function() {
                $('#categoryTable').DataTable({
                    "order": [[0, 'asc']],
                    "paging": false,
                    "info": false
                });
            });
        </script>
    @endpush
@endsection
