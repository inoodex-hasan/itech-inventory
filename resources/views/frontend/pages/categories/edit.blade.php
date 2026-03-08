@extends('frontend.layouts.app')
@section('content')
    <div class="content container-fluid">
        <div class="row">
            <div class="col-sm-12">
                <!-- Page Header -->
                <div class="page-header mb-3">
                    <div class="content-page-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Edit Category</h5>
                        <a class="btn btn-primary" href="{{ route('categories.index') }}">
                            <i class="fas fa-arrow-left me-2"></i>Back
                        </a>
                    </div>
                </div>

                <!-- Form -->
                <div class="card shadow-sm border-0 rounded-3">
                    <div class="card-body p-4">
                        <form action="{{ route('categories.update', $category->id) }}" method="POST" enctype="multipart/form-data">
                            @csrf
                            @method('PUT')
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="name" class="form-label">Category Name <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control @error('name') is-invalid @enderror"
                                            id="name" name="name" value="{{ old('name', $category->name) }}" required>
                                        @error('name')
                                            <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="description" class="form-label">Description</label>
                                        <textarea class="form-control @error('description') is-invalid @enderror"
                                            id="description" name="description" rows="4">{{ old('description', $category->description) }}</textarea>
                                        @error('description')
                                            <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="image" class="form-label">Category Image</label>
                                        @if($category->image)
                                            <div class="mb-2">
                                                <img src="{{ asset($category->image) }}" alt="{{ $category->name }}" 
                                                    style="width: 100px; height: 100px; object-fit: cover; border-radius: 5px;">
                                            </div>
                                        @endif
                                        <input type="file" class="form-control @error('image') is-invalid @enderror" 
                                            id="image" name="image" accept="image/*">
                                        <small class="text-muted">Allowed: jpeg, png, jpg, gif (Max 2MB)</small>
                                        @error('image')
                                            <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <label for="order_by" class="form-label">Order</label>
                                        <input type="number" class="form-control @error('order_by') is-invalid @enderror" 
                                            id="order_by" name="order_by" value="{{ old('order_by', $category->order_by) }}">
                                        @error('order_by')
                                            <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <label for="status" class="form-label">Status <span class="text-danger">*</span></label>
                                        <select class="form-select @error('status') is-invalid @enderror" 
                                            id="status" name="status" required>
                                            <option value="1" {{ old('status', $category->status) == 1 ? 'selected' : '' }}>Active</option>
                                            <option value="0" {{ old('status', $category->status) == 0 ? 'selected' : '' }}>Inactive</option>
                                        </select>
                                        @error('status')
                                            <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                </div>

                                <div class="col-md-12">
                                    <div class="d-flex gap-2">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save me-2"></i>Update Category
                                        </button>
                                        <a href="{{ route('categories.index') }}" class="btn btn-secondary">
                                            <i class="fas fa-times me-2"></i>Cancel
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
