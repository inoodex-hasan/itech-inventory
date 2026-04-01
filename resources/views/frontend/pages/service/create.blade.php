@extends('frontend.layouts.app')
@section('content')
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />

    <style>
        /* Fix Select2 arrow alignment and remove unwanted triangle when open */
        .select2-container--default.select2-container--open .select2-selection--single .select2-selection__arrow b {
            border-color: transparent transparent #888 transparent !important;
            border-width: 0 !important;
        }

        /* Customize Select2 arrow (closed state) */
        .select2-container--default .select2-selection--single .select2-selection__arrow b {
            border-color: #888 transparent transparent transparent !important;
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

        /* Make all inputs and selects have a clean black border */
        select,
        input,
        textarea {
            border-color: #000 !important;
            border-width: 1px;
            box-shadow: none !important;
        }

        /* Make labels black */
        label {
            color: #000 !important;
            font-weight: 500;
        }

        /* Customize Select2 box styling */
        .select2-container--default .select2-selection--single {
            background-color: #fff !important;
            border: 1px solid #000 !important;
            border-radius: 4px;
            height: 38px !important;
            display: flex;
            align-items: center;
            width: 100% !important;
            padding-left: 8px;
        }

        .select2-selection__rendered {
            line-height: 38px !important;
        }

        .select2-container {
            width: 100% !important;
        }
    </style>

    <div class="content container-fluid">
        <form action="{{ route('service.store') }}" method="post">
            @csrf
            <div class="card mb-3">
                <div class="card-body">
                    <div class="page-header mb-3">
                        <div class="content-page-header mb-0">
                            <h5>Add Service - Customer Info</h5>
                        </div>
                    </div>

                    <div class="row mb-4">
                        <div class="col-md-4">
                            <div class="input-block mb-3">
                                <label class="form-label">Customer Type <span class="text-danger">*</span></label>
                                <div class="d-flex gap-3">
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="client_type" id="newClient" value="new" checked>
                                        <label class="form-check-label" for="newClient">New Customer</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="client_type" id="existingClient" value="existing">
                                        <label class="form-check-label" for="existingClient">Existing Customer</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- New Client Form -->
                    <div id="newClientForm">
                        <div class="row">
                            <div class="col-lg-4 col-md-6 col-sm-12">
                                <div class="input-block mb-3">
                                    <label class="form-label">Customer Name <span class="text-danger">*</span></label>
                                    <input type="text" name="name" class="form-control" id="newClientName" placeholder="Enter Name" autocomplete="off">
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-6 col-sm-12">
                                <div class="input-block mb-3">
                                    <label class="form-label">Phone <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <select name="country_code" id="country_code" class="form-select phoneCode" style="max-width:110px;">
                                            @foreach (country_codes() as $key => $data)
                                                <option value="{{$key}}" data-show="{{$data['flag'].' '.$data['code']}}" data-showdefault="{{$data['flag'].' '.$data['code'].' '.$data['name']}}">{{$data['flag'].' '.$data['code']}}</option>
                                            @endforeach
                                        </select>
                                        <input type="text" class="form-control" placeholder="Phone Number" name="phone" id="newClientPhone" autocomplete="off">
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-6 col-sm-12">
                                <div class="input-block mb-3">
                                    <label class="form-label">Email</label>
                                    <input type="email" name="email" class="form-control" id="newClientEmail" placeholder="Enter Email" autocomplete="off">
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <div class="input-block mb-3">
                                    <label class="form-label">Address</label>
                                    <textarea name="address" class="form-control" id="newClientAddress" placeholder="Enter Address" rows="1"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Existing Client Form -->
                    <div id="existingClientForm" style="display: none;">
                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-12">
                                <div class="input-block mb-3">
                                    <label class="form-label">Select Customer <span class="text-danger">*</span></label>
                                    <select name="existing_client_id" class="form-control js-example-basic-single" id="clientSelect">
                                        <option value="">-- Select Customer --</option>
                                        @foreach (App\Models\Customer::orderBy('name')->get() as $client)
                                            <option value="{{ $client->id }}">
                                                {{ $client->name }} ({{ $client->phone }})
                                            </option>
                                        @endforeach
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card mb-3">
                <div class="card-body">
                    <div class="page-header mb-3">
                        <div class="content-page-header mb-0">
                            <h5>Service & Product Details</h5>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-4 col-md-6 col-sm-12">
                            <div class="input-block mb-3">
                                <label>Product Name <span class="text-danger">*</span></label>
                                <select name="product_name" class="form-control js-example-basic-single" id="product_select" required>
                                    <option value="">-- Select Product --</option>
                                    @foreach ($products as $product)
                                        <option value="{{$product->id}}">{{$product->name}} ({{$product->model}})</option>
                                    @endforeach
                                </select>
                            </div>
                        </div>

                        <div class="col-lg-4 col-md-6 col-sm-12">
                            <div class="input-block mb-3">
                                <label>IMEI / Serial Number</label>
                                <input type="text" name="product_number" class="form-control" placeholder="Enter IMEI or Serial Number" autocomplete="off">
                            </div>
                        </div>

                        <div class="col-lg-4 col-md-6 col-sm-12">
                            <div class="input-block mb-3">
                                <label>Warranty Duration (Days) <span class="text-danger">*</span></label>
                                <input type="number" name="warranty_duration" class="form-control" placeholder="Days" value="0" required>
                            </div>
                        </div>

                        <div class="col-lg-4 col-md-6 col-sm-12">
                            <div class="input-block mb-3">
                                <label>Repaired By <span class="text-danger">*</span></label>
                                <select class="form-select" name="repaired_by" required>
                                    <option value="">-- Select Staff --</option>
                                    @foreach ($users as $user)
                                        <option value="{{$user->id}}">{{$user->name}}</option>
                                    @endforeach
                                </select>
                            </div>
                        </div>

                        <div class="col-lg-8 col-md-12 col-sm-12">
                            <div class="input-block mb-3">
                                <label>Service Details / Issue Description</label>
                                <textarea name="details" class="form-control" placeholder="Describe the problem..." rows="1"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card mb-0">
                <div class="card-body">
                    <div class="page-header mb-3">
                        <div class="content-page-header mb-0">
                            <h5>Payment Info</h5>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-3 col-md-6 col-sm-12">
                            <div class="input-block mb-3">
                                <label>Total Price <span class="text-danger">*</span></label>
                                <input type="number" id="total" name="total" class="form-control" value="0" step="0.01" required>
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-6 col-sm-12">
                            <div class="input-block mb-3">
                                <label>Discount</label>
                                <input type="number" id="discount" name="discount" class="form-control" value="0" step="0.01">
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-6 col-sm-12">
                            <div class="input-block mb-3">
                                <label>Final Bill</label>
                                <input type="number" id="bill" name="bill" class="form-control" value="0" step="0.01" readonly>
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-6 col-sm-12">
                            <div class="input-block mb-3">
                                <label>Paid Amount</label>
                                <input type="number" id="paid_amount" name="paid_amount" class="form-control" value="0" step="0.01">
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-6 col-sm-12">
                            <div class="input-block mb-3">
                                <label>Due Amount</label>
                                <input type="number" id="due_amount" name="due_amount" class="form-control" value="0" step="0.01" readonly>
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-6 col-sm-12">
                            <div class="input-block mb-3">
                                <label>Payment Method</label>
                                <select class="form-select" name="payment_method_id">
                                    <option value="">-- Select --</option>
                                    @foreach (paymentMethods() as $key => $name)
                                        <option value="{{$key}}">{{$name}}</option>
                                    @endforeach
                                </select>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-12 col-sm-12 d-flex align-items-end justify-content-end pb-3">
                            <button type="submit" class="btn btn-primary btn-lg w-100" style="height: 50px;">
                                <i class="fe fe-check-circle me-2"></i> Confirm & Save Service
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script>
        $(document).ready(function() {
            $('.js-example-basic-single').select2({
                placeholder: "-- Select --",
                allowClear: true
            });

            // Customer Type Toggle Logic
            const newClientRadio = $('#newClient');
            const existingClientRadio = $('#existingClient');
            const newClientForm = $('#newClientForm');
            const existingClientForm = $('#existingClientForm');

            function toggleClientForms() {
                if (newClientRadio.is(':checked')) {
                    newClientForm.show();
                    existingClientForm.hide();
                    $('#newClientName, #newClientPhone').attr('required', true);
                    $('#clientSelect').attr('required', false);
                } else {
                    newClientForm.hide();
                    existingClientForm.show();
                    $('#newClientName, #newClientPhone').attr('required', false);
                    $('#clientSelect').attr('required', true);
                }
            }

            newClientRadio.on('change', toggleClientForms);
            existingClientRadio.on('change', toggleClientForms);

            // Calculations
            function calculateTotals() {
                let total = parseFloat($('#total').val()) || 0;
                let discount = parseFloat($('#discount').val()) || 0;
                let bill = Math.max(0, total - discount);
                $('#bill').val(bill.toFixed(2));

                let paid = parseFloat($('#paid_amount').val()) || 0;
                let due = Math.max(0, bill - paid);
                $('#due_amount').val(due.toFixed(2));
            }

            $('#total, #discount, #paid_amount').on('input change', calculateTotals);

            // Country codes flags logic (reused from existing)
            const selectElements = document.querySelectorAll('.phoneCode');
            selectElements.forEach(selectElement => {
                selectElement.addEventListener('focus', function() {
                    Array.from(selectElement.options).forEach(option => {
                        option.text = option.dataset.showdefault;
                    });
                });
                selectElement.addEventListener('blur', function() {
                    Array.from(selectElement.options).forEach(option => {
                        option.text = option.dataset.show;
                    });
                });
                selectElement.addEventListener('change', function() {
                    Array.from(selectElement.options).forEach(option => {
                        option.text = option.dataset.show;
                    });
                    selectElement.blur();
                });
            });
        });
    </script>
@endsection