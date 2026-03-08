@extends('frontend.layouts.app')

@section('content')
    <div class="content container-fluid col-sm-12">
        <div class="page-header">
            <div class="row align-items-center">
                <div class="col">
                    <h3 class="page-title">Clients</h3>
                </div>
            </div>
        </div>

        <!-- Filter Section -->
        <div class="row mb-3">
            <div class="col-md-12">
                <div class="card shadow-sm border-0 rounded-3">
                    <div class="card-body p-3">
                        <form action="{{ route('clients.index') }}" method="GET">
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
                                        <button type="submit" class="btn btn-primary w-100">
                                            <i class="fe fe-filter me-1"></i>Filter
                                        </button>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="mb-3">
                                        <a href="{{ route('clients.index') }}" class="btn btn-secondary w-100">
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

        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <div class="table-fluid">
                            <table class="table table-hover table-center mb-0">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Client Name</th>
                                        <th>Phone</th>
                                        <th>Email</th>
                                        <th>Address</th>
                                        <th>Projects</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @forelse ($clients as $client)
                                        <tr>
                                            <td>{{ $loop->iteration }}</td>
                                            <td>{{ $client->name }}</td>
                                            <td>{{ $client->phone }}</td>
                                            <td>{{ $client->email }}</td>
                                            <td>{{ $client->address }}</td>
                                            <td>
                                                <span class="badge bg-info">{{ $client->projects->count() ?? 0 }}</span>
                                            </td>
                                            <td class="d-flex align-items-center">
                                                <div class="dropdown dropdown-action">
                                                    <a href="#" class="btn-action-icon" data-bs-toggle="dropdown">
                                                        <i class="fas fa-ellipsis-v"></i>
                                                    </a>
                                                    <div class="dropdown-menu dropdown-menu-end">
                                                        <ul>
                                                            {{-- <li>
                                                            <a class="dropdown-item"
                                                                href="{{ route('clients.show', $client->id) }}">
                                                                <i class="far fa-eye me-2"></i>View
                                                            </a>
                                                        </li> --}}
                                                            <li>
                                                                <a class="dropdown-item"
                                                                    href="{{ route('clients.edit', $client->id) }}">
                                                                    <i class="far fa-edit me-2"></i>Edit
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a onclick="if (confirm('Are you sure to delete the client?')) { document.getElementById('serviceDelete{{ $client->id }}').submit(); }"
                                                                    class="dropdown-item" href="javascript:void(0)">
                                                                    <i class="far fa-trash-alt me-2"></i>Delete
                                                                </a>
                                                                <form id="serviceDelete{{ $client->id }}"
                                                                    action="{{ route('clients.destroy', $client->id) }}"
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
                                                <span class="text-muted">No clients found</span>
                                            </td>
                                        </tr>
                                    @endforelse
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination -->
                        <div class="d-flex justify-content-end mt-3">
                            {{ $clients->links('pagination::bootstrap-5') }}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
