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
        input {
            border-color: #000 !important;
            border-width: 1px;
            box-shadow: none !important;
        }

        /* Make labels black (you can remove this if using dark backgrounds) */
        label {
            color: #000 !important;
            font-weight: 500;
        }

        /* Customize Select2 box styling */
        .select2-container--default .select2-selection--single {
            background-color: #fff !important;
            border: 1px solid #000 !important;
            border-radius: 4px;
            height: 30px !important;
            display: flex;
            align-items: center;
            width: 100% !important;
            padding-left: 8px;
        }

        /* Align the Select2 text vertically */
        .select2-selection__rendered {
            line-height: 30px !important;
        }

        /* Fix the dropdown width to match input width */
        .select2-container {
            width: 100% !important;
        }
    </style>
    
    
<div class="content container-fluid">
    <div class="page-header">
        <div class="row align-items-center">
            <div class="col">
                <h3 class="page-title">Add Project Item</h3>
            </div>
            <div class="col-auto">
                <a href="{{ route('project-items.index') }}" class="btn btn-secondary">Back</a>
            </div>
        </div>
    </div>

    <div class="row justify-content-center">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                    <form action="{{ route('project-items.store') }}" method="POST">
                        @csrf

                        <div class="row">
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <label class="form-label">Project *</label>
                                    <select name="project_id" class="form-control" required>
                                        <option value="">Select Project</option>
                                        @foreach($projects as $project)
                                            <option value="{{ $project->id }}">{{ $project->project_name }}</option>
                                        @endforeach
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="card mb-0">
                            <div class="card-body">
                                <div class="page-header mb-3">
                                    <div class="content-page-header mb-3">
                                        <h6>Project Items</h6>
                                    </div>
                                </div>
                                
                                <!-- Preview Item Row -->
                                <div class="group-item" data-itemnumber="1" id="form-group-item1"
                                    style="background:#198754; color:#fff !important; padding: 10px 5px; border-radius: 5px;">
                                    <div class="row align-items-end">
                                        <div class="col-md-2">
                                            <label style="color:#fff !important;">Product Name</label>
                                            <select onchange="selectProduct(1)" id="product1"
                                                class="form-control js-example-basic-single" style="height: 30px;">
                                                <option value=""></option>
                                                @foreach ($products as $product)
                                                    <option value="{{ $product->id }}"
                                                        data-name="{{ $product->name }}({{ $product->model }})"
                                                        data-stock="{{ $product->inventory->current_stock ?? 0 }}"
                                                        data-price="{{ $product->latestPurchase->unit_price ?? 0 }}"
                                                        data-warranty="{{ $product->warranty ?? 0 }}">
                                                        {{ $product->name }}({{ $product->model }})
                                                    </option>
                                                @endforeach
                                            </select>
                                        </div>
                                        <div class="col-md-1">
                                            <label style="color:#fff !important;">Stock</label>
                                            <input type="number" id="stock1" style="height: 30px;" class="form-control"
                                                readonly>
                                        </div>
                                        <div class="col-md-1">
                                            <label style="color:#fff !important;"> Warranty (Days)</label>
                                            <input type="number" id="warranty1" style="height: 30px;" class="form-control"
                                                readonly>
                                        </div>
                                        <div class="col-md-2">
                                            <label style="color:#fff !important;"> Purchase Price</label>
                                            <input type="number" id="purchase_price1" style="height: 30px;"
                                                class="form-control" readonly>
                                        </div>
                                        <div class="col-md-2">
                                            <label style="color:#fff !important;"> Unit Price</label>
                                            <input onchange="calculateTotal()" type="number" id="unit_price1"
                                                style="height: 30px;" class="form-control unit-price">
                                        </div>
                                        <div class="col-md-1">
                                            <label style="color:#fff !important;">Qty</label>
                                            <input onchange="calculateTotal()" type="number" id="qty1"
                                                style="height: 30px;" class="form-control qty" min="0">
                                        </div>
                                        <div class="col-md-2">
                                            <label style="color:#fff !important;">Total</label>
                                            <input type="number" id="total1" style="height: 30px;"
                                                class="form-control total" readonly>
                                        </div>
                                        <div class="col-md-1 text-end btn-holder">
                                            <button onclick="addItem()" type="button"
                                                class=" btn btn-primary addItemBtn">Add</button>
                                        </div>
                                    </div>
                                </div>

                                <hr>

                                <!-- Items Header -->
                                <div class="" style="color:#000 !important;">
                                    <div class="row align-items-end">
                                        <div class="col-md-4">
                                            <label style="color:#000 !important;">Product Name</label>
                                        </div>
                                        <div class="col-md-2">
                                            <label style="color:#000 !important;"> Unit Price</label>
                                        </div>
                                        <div class="col-md-2">
                                            <label style="color:#000 !important;">Qty</label>
                                        </div>
                                        <div class="col-md-2">
                                            <label style="color:#000 !important;">Total</label>
                                        </div>
                                        <div class="col-md-2 text-end">
                                            <label style="color:#000 !important;">Action</label>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Items Container -->
                                <div id="item_container"></div>
                                <hr>

                                <!-- Summary Section -->
                                <div id="summerySection" class="row align-items-end justify-content-end mt-3 d-none"
                                    style="color:#000;">
                                    <div class="col-md-2">
                                        <label>Sub Total</label>
                                        <input type="number" id="subTotal" name="subTotal"
                                            class="form-control total" style="height: 30px;" readonly>
                                    </div>

                                    <div class="col-md-2">
                                        <label>Grand Total</label>
                                        <input type="number" id="grandTotal" name="grandTotal" class="form-control total"
                                            style="height: 30px;" readonly>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Form Buttons -->
                        <div class="text-end mt-3">
                            <button type="submit" class="btn btn-primary">Add Item</button>
                            <a href="{{ route('project-items.index') }}" class="btn btn-secondary">Cancel</a>
                        </div>
                    </form>
                    </div>
            </div>
        </div>
    </div>
</div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<script>
    var itemNumber = 2;

    $(document).ready(function() {
        $('.js-example-basic-single').select2({
            placeholder: "Select a product",
            allowClear: true
        });
    });

    function addItem() {
        var product = document.getElementById('product1').value;
        var qty = document.getElementById('qty1').value;

        if (product == "") {
            alert("Please select a product");
            return;
        }

        let selectedName = document.getElementById('product1').options[document.getElementById('product1')
            .selectedIndex].text;

        const price = document.getElementById('unit_price1').value;
        if (price.trim() === "") {
            alert("Please enter unit price");
            return;
        }

        if (qty.trim() === "") {
            alert("Please enter quantity");
            return;
        }

        const stock = parseFloat(document.getElementById('stock1').value) || 0;
        if (parseFloat(qty) > stock) {
            alert("Quantity exceeds available stock!");
            return;
        }

        var html = `
            <div class="item${product} group-item mt-2" data-itemnumber="${itemNumber}" id="form-group-item${itemNumber}">
                <div class="row align-items-end">
                    <div class="col-md-4">
                        <input type="hidden" name="products[${itemNumber}][product_id]" value="${product}">
                        <input type="hidden" name="products[${itemNumber}][product_name]" value="${selectedName}">
                        <p><strong>${selectedName}</strong></p>
                    </div>
                    <div class="col-md-2">
                        <input onchange="calculateTotal()" type="number" name="products[${itemNumber}][unit_price]" id="unit_price${itemNumber}" style="height: 30px;" class="form-control unit-price" value="${price}" step="0.01">
                    </div>
                    <div class="col-md-2">
                        <input onchange="calculateTotal()" type="number" name="products[${itemNumber}][quantity]" id="qty${itemNumber}" style="height: 30px;" class="form-control qty" min="1" value="${qty}">
                    </div>
                    <div class="col-md-2">
                        <input type="number" name="products[${itemNumber}][total]" id="total${itemNumber}" style="height: 30px;" class="form-control total" readonly step="0.01">
                    </div>
                    <div class="col-md-2 text-end btn-holder">
                        <button onclick="removeItem(${itemNumber})" type="button" class="btn btn-danger remove-item me-1">×</button>
                    </div>
                </div>
            </div>
        `;

        $('#item_container').append(html);
        itemNumber++;
        calculateTotal();

        // Reset the first row
        document.getElementById('product1').value = '';
        document.getElementById('product1').dispatchEvent(new Event('change'));
        document.getElementById('unit_price1').value = '';
        document.getElementById('qty1').value = '';
        document.getElementById('total1').value = '';
        document.getElementById('stock1').value = '';
        document.getElementById('warranty1').value = '';
        document.getElementById('purchase_price1').value = '';

        $('.js-example-basic-single').trigger('change');
        
        // Show summary section
        document.getElementById("summerySection").classList.remove('d-none');
    }

    function removeItem(item) {
        document.getElementById('form-group-item' + item).remove();
        calculateTotal();
        
        // Hide summary section if no items
        const hasItems = document.querySelectorAll('#item_container .group-item').length > 0;
        if (!hasItems) {
            document.getElementById("summerySection").classList.add('d-none');
        }
    }

    function selectProduct(item) {
        var selected = $('#product' + item + ' option:selected');
        var selectedPrice = selected.data('price') || 0;
        var selectedWarranty = selected.data('warranty') || 0;
        var selectedStock = selected.data('stock') || 0;

        if (document.getElementById('purchase_price' + item))
            document.getElementById('purchase_price' + item).value = selectedPrice;
        if (document.getElementById('warranty' + item))
            document.getElementById('warranty' + item).value = selectedWarranty;
        if (document.getElementById('stock' + item))
            document.getElementById('stock' + item).value = selectedStock;

        // Auto-fill unit price with purchase price
        if (document.getElementById('unit_price' + item)) {
            document.getElementById('unit_price' + item).value = selectedPrice;
        }

        calculateTotal();
    }

    function calculateTotal() {
        let subTotal = 0;

        // Calculate items in the container
        const containerItems = document.querySelectorAll('#item_container .group-item');
        containerItems.forEach(item => {
            const itemNumber = item.dataset.itemnumber;
            const unit_price = parseFloat(document.getElementById('unit_price' + itemNumber)?.value) || 0;
            const qty = parseFloat(document.getElementById('qty' + itemNumber)?.value) || 0;
            const totalEle = document.getElementById('total' + itemNumber);

            const total = qty * unit_price;
            if (totalEle) totalEle.value = total.toFixed(2);
            subTotal += total;
        });

        // Calculate preview item (first row)
        const previewUnitPrice = parseFloat(document.getElementById('unit_price1')?.value) || 0;
        const previewQty = parseFloat(document.getElementById('qty1')?.value) || 0;
        const previewTotal = previewUnitPrice * previewQty;
        const previewTotalInput = document.getElementById('total1');
        if (previewTotalInput) previewTotalInput.value = previewTotal.toFixed(2);

        // Update summary
        if (document.getElementById('subTotal')) document.getElementById('subTotal').value = subTotal.toFixed(2);
        if (document.getElementById('grandTotal')) document.getElementById('grandTotal').value = subTotal.toFixed(2);
    }
</script>

@endsection