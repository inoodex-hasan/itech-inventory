@extends('frontend.layouts.app')

@section('content')
<div class="content container-fluid">

    <div class="row">
        <div class="col-md-12 mx-auto">
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title">Edit Cost Category</h5>
                </div>
                <div class="card-body">
                    <form action="{{ route('cost-categories.update', $category->id) }}" method="POST">
                        @csrf
                        @method('PUT')

                        <div class="mb-3">
                            <label class="form-label">Category Name <span class="text-danger">*</span></label>
                            <input type="text" name="name" class="form-control @error('name') is-invalid @enderror" 
                                   value="{{ old('name', $category->name) }}" placeholder="Enter category name" required>
                            @error('name')
                                <div class="invalid-feedback">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea name="description" class="form-control @error('description') is-invalid @enderror" 
                                      rows="4" placeholder="Enter category description">{{ old('description', $category->description) }}</textarea>
                            @error('description')
                                <div class="invalid-feedback">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="row align-items-end">
    <div class="col-md-2">
        <div class="mb-3">
            <label class="form-label">Status</label>
            <select name="is_active" class="form-control" required>
                <option value="1" {{ $category->is_active ? 'selected' : '' }}>Active</option>
                <option value="0" {{ !$category->is_active ? 'selected' : '' }}>Inactive</option>
            </select>
        </div>
    </div>
    <div class="col-md-10">
        <div class="mb-3 text-end">
            <button type="submit" class="btn btn-primary">
                Update
            </button>
            <a href="{{ route('cost-categories.index') }}" class="btn btn-secondary">
                Cancel
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