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
                <h5>Products</h5>

                <div class="list-btn">
                    <ul class="filter-list">
                        <li>
                            <a class="btn btn-primary" href="javascript:void(0)" data-bs-toggle="modal"
                                data-bs-target="#add-payment-modal">
                                <i class="fa fa-plus-circle me-2" aria-hidden="true"></i>Add Product </a>
                        </li>
                    </ul>

                    <div id="add-payment-modal" class="modal fade" tabindex="-1" style="display: none;" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="add-payment-modal">Add Product</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    {{-- <div class="text-center mt-2 mb-4">
                            <div class="auth-logo">
                                <a href="{{ route('index') }}" class="logo logo-dark">
                                    <span class="logo-lg">
                                        <img src="{{asset('assets/img/logo.png')}}" alt="Logo" height="42">
                                    </span>
                                </a>
                            </div>
                        </div> --}}

                                    <form class="px-3" method="POST" action="{{ route('products.store') }}"
                                        enctype="multipart/form-data">
                                        @csrf
                                        <!-- Input for Product Name -->
                                        <div class="mb-3">
                                            <label for="name" class="form-label">Brand Name <span
                                                    class="text-danger">*</span></label>
                                            <select class="form-control select2" name="brand_id" id="brand_id" required>
                                                <option value="">Select Brand</option>
                                                @foreach ($brands as $brand)
                                                    <option {{ $brand->id == old('brand_id') ? 'selected' : '' }}
                                                        value="{{ $brand->id }}">{{ $brand->name }}</option>
                                                @endforeach
                                            </select>
                                        </div>
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
                                            <label for="photos" class="form-label">Product Photos</label>
                                            <input type="file" name="photos[]" id="photos" class="form-control"
                                                multiple accept="image/*">
                                        </div>
                                        <div class="mb-3">
                                            <label for="warranty" class="form-label">Warranty(Days)<span
                                                    class="text-danger">*</span></label>
                                            <input type="text" name="warranty" id="warranty" class="form-control"
                                                placeholder="Enter how many days" value="{{ old('warranty') }}" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="status" class="form-label">Status</label>
                                            <select class="form-select mb-3" name="status" required>
                                                <option selected="" value="1">Active</option>
                                                <option value="0">InActive</option>
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
                        <form action="{{ route('products.index') }}" method="GET">
                            <div class="row align-items-end">
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <label for="search" class="form-label">Search</label>
                                        <input type="text" class="form-control" id="search" name="search" 
                                            value="{{ request('search') }}" placeholder="Search by name, model...">
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="mb-3">
                                        <label for="brand_id" class="form-label">Brand</label>
                                        <select class="form-select select2" id="brand_id" name="brand_id">
                                            <option value="">All Brands</option>
                                            @foreach($brands as $brand)
                                                <option value="{{ $brand->id }}" {{ request('brand_id') == $brand->id ? 'selected' : '' }}>
                                                    {{ $brand->name }}
                                                </option>
                                            @endforeach
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="mb-3">
                                        <label for="category_id" class="form-label">Category</label>
                                        <select class="form-select select2" id="category_id" name="category_id">
                                            <option value="">All Categories</option>
                                            @foreach($categories as $category)
                                                <option value="{{ $category->id }}" {{ request('category_id') == $category->id ? 'selected' : '' }}>
                                                    {{ $category->name }}
                                                </option>
                                            @endforeach
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-2">
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
                                    <div class="mb-3 d-flex gap-2">
                                        <button type="submit" class="btn btn-primary flex-fill">
                                            <i class="fe fe-filter me-1"></i>Filter
                                        </button>
                                        <a href="{{ route('products.index') }}" class="btn btn-secondary">
                                            <i class="fe fe-refresh-ccw"></i>
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
                        <div class="table-responsive">
                            <table id="productTable" class="table table-center table-hover">
                                <thead class="thead-light">
                                    <tr>
                                        <th>#</th>
                                        <th>Brand Name</th>
                                        <th>Product Name</th>
                                        <th>Model</th>
                                        <th>Photos</th>
                                        <th>Warranty</th>
                                        <th>Status</th>
                                        <th class="no-sort">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @forelse ($products as $product)
                                        <tr>
                                            <td>{{ $loop->index + 1 }}</td>
                                            <td>{{ $product->brand->name ?? 'N/A' }}</td>
                                            <td>{{ Str::limit($product->name, 20) }}</td>
                                            <td>{{ Str::limit($product->model, 20) }}</td>
                                            <td>
                                                @if ($product->photos && count($product->photos) > 0)
                                                    <div class="d-flex gap-1 align-items-center">
                                                        @foreach ($product->photos as $index => $photo)
                                                            @if ($index < 2)
                                                                <img src="{{ asset('storage/' . $photo) }}"
                                                                    alt="Product Photo"
                                                                    style="height: 60px; width: 60px; object-fit: cover;"
                                                                    class="img-thumbnail rounded">
                                                            @endif
                                                        @endforeach

                                                        @if (count($product->photos) > 2)
                                                            <span
                                                                class="badge bg-secondary ms-1">+{{ count($product->photos) - 2 }}</span>
                                                        @endif
                                                    </div>
                                                @else
                                                    <span class="text-muted">No photos</span>
                                                @endif
                                            </td>
                                            <td>{{ $product->warranty ?? 'N/A' }}</td>
                                            <td>
                                                @if ($product->status == 1)
                                                    <span class="badge bg-success">Active</span>
                                                @else
                                                    <span class="badge bg-danger">Inactive</span>
                                                @endif
                                            </td>
                                            <td class="justify-content-center align-items-center">
                                                <div class="dropdown">
                                                    <a href="#" class="btn-action-icon" data-bs-toggle="dropdown">
                                                        <i class="fas fa-ellipsis-v"></i>
                                                    </a>
                                                    <div class="dropdown-menu dropdown-menu-end shadow-sm rounded-3">
                                                        <ul class="list-unstyled mb-0">
                                                            <li>
                                                                <a class="dropdown-item" href="javascript:void(0)"
                                                                    data-bs-toggle="modal"
                                                                    data-bs-target="#edit-product-modal{{ $product->id }}">
                                                                    <i class="far fa-edit me-2"></i>Edit
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a class="dropdown-item text-danger"
                                                                    href="javascript:void(0)"
                                                                    onclick="if(confirm('Are you sure to delete the product?')) { document.getElementById('serviceDelete{{ $product->id }}').submit(); }">
                                                                    <i class="far fa-trash-alt me-2"></i>Delete
                                                                </a>
                                                                <form id="serviceDelete{{ $product->id }}"
                                                                    action="{{ route('products.destroy', $product->id) }}"
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
                                            <td colspan="8" class="text-center py-4">
                                                <i class="fe fe-inbox fa-3x text-muted mb-3 d-block"></i>
                                                <span class="text-muted">No products found</span>
                                            </td>
                                        </tr>
                                    @endforelse
                                </tbody>
                            </table>

                            <!-- Modals should be outside the table -->
                            {{-- @foreach ($products as $product)
                                <div id="edit-product-modal{{ $product->id }}" class="modal fade" tabindex="-1"
                                    aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="edit-product-modal{{ $product->id }}">Edit
                                                    Product</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                    aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">

                                                <form class="px-3" method="POST"
                                                    action="{{ route('products.update', $product->id) }}">
                                                    @csrf
                                                    @method('PUT')
                                                    <div class="mb-3">
                                                        <label for="name" class="form-label">Brand Name <span
                                                                class="text-danger">*</span></label>
                                                        <select class="form-control select2" name="brand_id"
                                                            id="brand_id" required>
                                                            <option value="">Select Brand</option>
                                                            @foreach ($brands as $brand)
                                                                <option
                                                                    {{ $brand->id == $product->brand_id ? 'selected' : '' }}
                                                                    value="{{ $brand->id }}">{{ $brand->name }}
                                                                </option>
                                                            @endforeach
                                                        </select>
                                                    </div>
                                                    <!-- Product Name -->
                                                    <div class="mb-3">
                                                        <label for="name{{ $product->id }}" class="form-label">Product
                                                            Name <span class="text-danger">*</span></label>
                                                        <input type="text" name="name"
                                                            id="name{{ $product->id }}" class="form-control"
                                                            placeholder="Enter product name"
                                                            value="{{ old('name', $product->name) }}" required>
                                                    </div>

                                                    <!-- Product Model Name -->
                                                    <div class="mb-3">
                                                        <label for="model_name{{ $product->id }}"
                                                            class="form-label">Product Model Name <span
                                                                class="text-danger">*</span></label>
                                                        <input type="text" name="model_name"
                                                            id="model_name{{ $product->id }}" class="form-control"
                                                            placeholder="Enter product model name"
                                                            value="{{ old('model_name', $product->model ?? '') }}"
                                                            required>
                                                    </div>

                                                    <div class="mb-3">
                                                        <label for="warranty{{ $product->id }}"
                                                            class="form-label">Warranty (Days)<span
                                                                class="text-danger">*</span></label>
                                                        <input type="text" name="warranty"
                                                            id="warranty{{ $product->id }}" class="form-control"
                                                            placeholder="Enter how many days"
                                                            value="{{ old('model_name', $product->warranty ?? '') }}"
                                                            required>
                                                    </div>

                                                    <!-- Status -->
                                                    <div class="mb-3">
                                                        <label for="status{{ $product->id }}"
                                                            class="form-label">Status</label>
                                                        <select class="form-select mb-3" name="status"
                                                            id="status{{ $product->id }}" required>
                                                            <option value="1"
                                                                {{ old('status', $product->status) == 1 ? 'selected' : '' }}>
                                                                Active</option>
                                                            <option value="0"
                                                                {{ old('status', $product->status) == 0 ? 'selected' : '' }}>
                                                                Inactive</option>
                                                        </select>
                                                    </div>

                                                    <div class="mb-3">
                                                        <button type="submit" class="btn btn-primary">Update</button>
                                                    </div>
                                                </form>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            @endforeach --}}

                            @foreach ($products as $product)
                                <div id="edit-product-modal{{ $product->id }}" class="modal fade" tabindex="-1"
                                    aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="edit-product-modal{{ $product->id }}">Edit
                                                    Product</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                    aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <form class="px-3" method="POST"
                                                    action="{{ route('products.update', $product->id) }}"
                                                    enctype="multipart/form-data" id="edit-form-{{ $product->id }}">
                                                    @csrf
                                                    @method('PUT')

                                                    <!-- Brand Selection -->
                                                    <div class="mb-3">
                                                        <label for="name" class="form-label">Brand Name <span
                                                                class="text-danger">*</span></label>
                                                        <select class="form-control select2" name="brand_id"
                                                            id="brand_id" required>
                                                            <option value="">Select Brand</option>
                                                            @foreach ($brands as $brand)
                                                                <option
                                                                    {{ $brand->id == $product->brand_id ? 'selected' : '' }}
                                                                    value="{{ $brand->id }}">{{ $brand->name }}
                                                                </option>
                                                            @endforeach
                                                        </select>
                                                    </div>

                                                    <!-- Product Name -->
                                                    <div class="mb-3">
                                                        <label for="name{{ $product->id }}" class="form-label">Product
                                                            Name <span class="text-danger">*</span></label>
                                                        <input type="text" name="name"
                                                            id="name{{ $product->id }}" class="form-control"
                                                            placeholder="Enter product name"
                                                            value="{{ old('name', $product->name) }}" required>
                                                    </div>

                                                    <!-- Product Model Name -->
                                                    <div class="mb-3">
                                                        <label for="model_name{{ $product->id }}"
                                                            class="form-label">Product Model Name <span
                                                                class="text-danger">*</span></label>
                                                        <input type="text" name="model_name"
                                                            id="model_name{{ $product->id }}" class="form-control"
                                                            placeholder="Enter product model name"
                                                            value="{{ old('model_name', $product->model ?? '') }}"
                                                            required>
                                                    </div>

                                                    <!-- Warranty -->
                                                    <div class="mb-3">
                                                        <label for="warranty{{ $product->id }}"
                                                            class="form-label">Warranty (Days)<span
                                                                class="text-danger">*</span></label>
                                                        <input type="text" name="warranty"
                                                            id="warranty{{ $product->id }}" class="form-control"
                                                            placeholder="Enter how many days"
                                                            value="{{ old('model_name', $product->warranty ?? '') }}"
                                                            required>
                                                    </div>

                                                    <!-- Existing Photos with Delete Buttons -->
                                                    @if ($product->photos && count($product->photos) > 0)
                                                        <div class="mb-3">
                                                            <label class="form-label">Existing Photos</label>
                                                            <div class="d-flex flex-wrap gap-2"
                                                                id="photos-container-{{ $product->id }}">
                                                                @foreach ($product->photos as $index => $photo)
                                                                    <div class="position-relative photo-item"
                                                                        data-photo="{{ $photo }}">
                                                                        <img src="{{ asset('storage/' . $photo) }}"
                                                                            class="img-thumbnail"
                                                                            style="height: 80px; width: 80px; object-fit: cover;">
                                                                        <button type="button"
                                                                            class="btn btn-danger btn-sm position-absolute top-0 end-0 m-1 delete-photo-btn"
                                                                            data-product-id="{{ $product->id }}"
                                                                            data-photo="{{ $photo }}"
                                                                            style="width: 20px; height: 20px; padding: 0; border-radius: 50%;">
                                                                            ×
                                                                        </button>
                                                                        <small class="d-block text-center">Photo
                                                                            {{ $index + 1 }}</small>
                                                                    </div>
                                                                @endforeach
                                                            </div>
                                                            <input type="hidden" name="remaining_photos"
                                                                id="remaining-photos-{{ $product->id }}"
                                                                value="{{ json_encode($product->photos) }}">
                                                        </div>
                                                    @endif

                                                    <!-- New Photos Upload -->
                                                    <div class="mb-3">
                                                        <label for="photos{{ $product->id }}" class="form-label">Add New
                                                            Photos</label>
                                                        <input type="file" name="photos[]"
                                                            id="photos{{ $product->id }}" class="form-control" multiple
                                                            accept="image/*">
                                                        <div id="image-preview-{{ $product->id }}"
                                                            class="mt-2 d-flex flex-wrap gap-2"></div>
                                                    </div>

                                                    <!-- Status -->
                                                    <div class="mb-3">
                                                        <label for="status{{ $product->id }}"
                                                            class="form-label">Status</label>
                                                        <select class="form-select mb-3" name="status"
                                                            id="status{{ $product->id }}" required>
                                                            <option value="1"
                                                                {{ old('status', $product->status) == 1 ? 'selected' : '' }}>
                                                                Active</option>
                                                            <option value="0"
                                                                {{ old('status', $product->status) == 0 ? 'selected' : '' }}>
                                                                Inactive</option>
                                                        </select>
                                                    </div>

                                                    <div class="mb-3">
                                                        <button type="submit" class="btn btn-primary">Update</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            @endforeach

                        </div>
                    </div>
                </div>

                <!-- Pagination -->
                <div class="d-flex justify-content-end mt-3">
                    {{ $products->links('pagination::bootstrap-5') }}
                </div>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

    <!-- Add this single script at the bottom of your page -->
    <script>
        // Single event listener for all delete buttons
        document.addEventListener('click', function(e) {
            if (e.target.classList.contains('delete-photo-btn')) {
                e.preventDefault();

                if (confirm('Are you sure you want to delete this photo?')) {
                    const photoItem = e.target.closest('.photo-item');
                    const productId = e.target.getAttribute('data-product-id');

                    if (photoItem) {
                        photoItem.remove();
                        updateRemainingPhotos(productId);
                    }
                }
            }
        });

        // Single event listener for all file inputs
        document.addEventListener('change', function(e) {
            if (e.target && e.target.matches('input[type="file"][name="photos[]"]')) {
                const input = e.target;
                const productId = input.id.replace('photos', '');
                const preview = document.getElementById('image-preview-' + productId);

                if (preview) {
                    preview.innerHTML = '';
                    Array.from(input.files).forEach(file => {
                        const img = document.createElement('img');
                        img.src = URL.createObjectURL(file);
                        img.className = 'img-thumbnail';
                        img.style.height = '80px';
                        img.style.width = '80px';
                        img.style.objectFit = 'cover';
                        preview.appendChild(img);
                    });
                }
            }
        });

        function updateRemainingPhotos(productId) {
            const container = document.getElementById('photos-container-' + productId);
            const hiddenInput = document.getElementById('remaining-photos-' + productId);

            if (container && hiddenInput) {
                const remainingPhotos = [];
                container.querySelectorAll('.photo-item').forEach(item => {
                    remainingPhotos.push(item.getAttribute('data-photo'));
                });
                hiddenInput.value = JSON.stringify(remainingPhotos);
            }
        }
    </script>
@endsection
