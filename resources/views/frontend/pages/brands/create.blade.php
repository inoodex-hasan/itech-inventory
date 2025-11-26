@extends('frontend.layouts.app')

@section('content')
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />

    <div class="container-fluid d-flex justify-content-center" style="min-height: 80vh;">
        <div class="col-md-6">
            <div class="card shadow-sm rounded-3 my-5">
                <div class="card-body p-4">

                    <h3 class="text-center mb-4 fw-bold">{{ isset($brand) ? 'Edit Brand' : 'Add New Brand' }}</h3>

                    <form method="POST"
                        action="{{ isset($brand) ? route('brands.update', $brand->id) : route('brands.store') }}">
                        @csrf
                        @if (isset($brand))
                            @method('PUT')
                        @endif

                        <div class="mb-3">
                            <label for="name" class="form-label fw-semibold">Brand Name <span
                                    class="text-danger">*</span></label>
                            <input type="text" class="form-control form-control-lg" name="name" id="name"
                                placeholder="Enter brand name..." value="{{ old('name', $brand->name ?? '') }}" required>
                        </div>

                        <div class="mb-3">
                            <label for="status" class="form-label fw-semibold">Status <span
                                    class="text-danger">*</span></label>
                            <select class="form-select form-select-lg" name="status" required>
                                <option value="1" {{ old('status', $brand->status ?? 1) == 1 ? 'selected' : '' }}>
                                    Active
                                </option>
                                <option value="0" {{ old('status', $brand->status ?? 1) == 0 ? 'selected' : '' }}>
                                    Inactive</option>
                            </select>
                        </div>

                        <div class="d-flex justify-content-center mt-4">
                            <button type="submit" class="btn btn-primary px-5 py-2 rounded-pill fw-semibold">
                                {{ isset($brand) ? 'Update Brand' : 'Save Brand' }}
                            </button>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script>
        $(document).ready(function() {
            $('.js-example-basic-single').select2({});
            $('.js-example-basic-single-no-new-value').select2({});
        });
    </script>
@endsection
