@extends('frontend.layouts.app')
@section('content')
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />

    <style>
        .content.container-fluid .select2-container--default.select2-container--open .select2-selection--single .select2-selection__arrow b {
            border-color: transparent transparent #888 transparent !important;
            border-width: 0 !important;
        }

        .content.container-fluid .select2-container--default .select2-selection--single .select2-selection__arrow b {
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

        .content.container-fluid .card select,
        .content.container-fluid .card input {
            border-color: #000 !important;
            border-width: 1px;
            box-shadow: none !important;
        }

        .content.container-fluid .card label {
            color: #000 !important;
            font-weight: 500;
        }

        .content.container-fluid .select2-container--default .select2-selection--single {
            background-color: #fff !important;
            border: 1px solid #000 !important;
            border-radius: 4px;
            height: 30px !important;
            display: flex;
            align-items: center;
            width: 100% !important;
            padding-left: 8px;
        }

        .content.container-fluid .select2-selection__rendered {
            line-height: 30px !important;
        }

        .content.container-fluid .select2-container {
            width: 100% !important;
        }

        .content.container-fluid .card {
            border: 1px solid #ddd;
            border-radius: 8px;
        }

        .content.container-fluid .card-body {
            padding: 20px;
        }

        .content.container-fluid .content-page-header h6 {
            color: #198754;
            font-weight: 600;
            margin-bottom: 15px;
        }
    </style>

{{-- Debug info --}}
<div class="alert alert-info">
    <strong>Debug Info:</strong><br>
    Project Item ID: {{ $projectItem->id }}<br>
    Current Product ID: {{ $projectItem->product_id }}<br>
    Current Product Name: {{ $projectItem->product->name ?? 'N/A' }}<br>
    Form Action: {{ route('project-items.update', $projectItem->id) }}
</div>

<div class="content container-fluid">
    <div class="page-header">
        <div class="row align-items-center">
            <div class="col">
                <h3 class="page-title">Edit Project Items</h3>
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
                    <form action="{{ route('project-items.update', $projectItem->id) }}" method="POST">
                        @csrf
                        @method('PUT')

                        <div class="row mb-4">
                            <div class="col-md-4">
                                <label class="form-label">Project *</label>
                                <select name="project_id" class="form-control" required>
                                    <option value="">Select Project</option>
                                    @foreach($projects as $project)
                                        <option value="{{ $project->id }}" 
                                            {{ $projectItem->project_id == $project->id ? 'selected' : '' }}>
                                            {{ $project->project_name }}
                                        </option>
                                    @endforeach
                                </select>
                            </div>
                        </div>

                        <!-- Current Items -->
                        <div class="card mb-4">
                            <div class="card-header bg-success text-white">
                                <h6 class="mb-0">Current Items</h6>
                            </div>
                            <div class="card-body">
                                <!-- Items Header -->
                                <div class="mb-3">
                                    <div class="row align-items-end">
                                        <div class="col-md-4">
                                            <label>Product Name</label>
                                        </div>
                                        <div class="col-md-2">
                                            <label>Unit Price</label>
                                        </div>
                                        <div class="col-md-2">
                                            <label>Qty</label>
                                        </div>
                                        <div class="col-md-2">
                                            <label>Total</label>
                                        </div>
                                       
                                    </div>
                                </div>

                                <!-- Existing Items Container -->
                                {{-- <div id="item_container">
                                    @if($project->items && $project->items->count() > 0)
                                        @foreach($project->items as $index => $item)
                                        <div class="group-item mt-2" data-itemnumber="{{ $index + 2 }}" id="form-group-item{{ $index + 2 }}">
                                            <div class="row align-items-end">
                                                <div class="col-md-4">
                                                    <input type="hidden" name="items[{{ $item->id }}][product_id]" value="{{ $item->product_id }}">
                                                    <p><strong>{{ $item->product->name }}({{ $item->product->model }})</strong></p>
                                                </div>
                                                <div class="col-md-2">
                                                    <input onchange="calculateTotal()" type="number" name="items[{{ $item->id }}][unit_price]" id="unit_price{{ $index + 2 }}" class="form-control unit-price" value="{{ $item->unit_price }}" step="0.01">
                                                </div>
                                                <div class="col-md-2">
                                                    <input onchange="calculateTotal()" type="number" name="items[{{ $item->id }}][quantity]" id="qty{{ $index + 2 }}" class="form-control qty" min="1" value="{{ $item->quantity }}">
                                                </div>
                                                <div class="col-md-2">
                                                    <input type="number" name="items[{{ $item->id }}][total_price]" id="total{{ $index + 2 }}" class="form-control total" readonly value="{{ $item->total_price }}" step="0.01">
                                                </div>
                                                
                                            </div>
                                        </div>
                                        @endforeach
                                    @endif
                                </div> --}}
                                <div id="item_container">
    @if($project->items && $project->items->count() > 0)
        @foreach($project->items as $item)
<div class="group-item mt-3 border rounded p-3 bg-light">
    <div class="row align-items-center">
        <div class="col-md-4">
            <input type="hidden" name="items[{{ $item->id }}][product_id]" value="{{ $item->product_id }}">
            <strong>{{ $item->product->name }}</strong>
            @if($item->product->model)
                <br><small class="text-muted">{{ $item->product->model }}</small>
            @endif
        </div>
        <div class="col-md-2">
            <input type="number" step="0.01"
                   name="items[{{ $item->id }}][unit_price]"
                   class="form-control unit-price"
                   value="{{ $item->unit_price }}"
                   onchange="calculateTotal()" required>
        </div>
        <div class="col-md-2">
            <input type="number" min="1"
                   name="items[{{ $item->id }}][quantity]"
                   class="form-control qty"
                   value="{{ $item->quantity }}"
                   onchange="calculateTotal()" required>
        </div>
        <div class="col-md-2">
            <input type="text"
                   class="form-control total text-end fw-bold bg-white"
                   value="{{ number_format($item->total_price, 2) }}"
                   readonly>
        </div>
        <div class="col-md-2 text-center">
            <button type="button" onclick="this.closest('.group-item').remove(); calculateTotal()"
                    class="btn btn-danger btn-sm">
                <i class="fas fa-trash"></i>
            </button>
        </div>
    </div>
</div>
@endforeach
    @endif
</div>
                            </div>
                        </div>

                        <!-- Summary Section -->
                        <div class="card">
                            <div class="card-body">
                                <div class="row justify-content-end">
                                    <div class="col-md-3">
                                        <label>Sub Total</label>
                                        <input type="number" id="subTotal" name="subTotal" class="form-control" readonly>
                                    </div>
                                    <div class="col-md-3">
                                        <label>Grand Total</label>
                                        <input type="number" id="grandTotal" name="grandTotal" class="form-control" readonly>
                                    </div>
                                    <div class="col-md-2">
                                        <label>&nbsp;</label>
                                        <button type="submit" class="btn btn-success w-100">Update</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<script>
    $(document).ready(function() {
        // Initialize Select2 on the product dropdown
        $('.js-example-basic-single').select2({
            placeholder: "Select Product",
            allowClear: true
        });

        // Re-calculate totals on page load (for existing items)
        calculateTotal();
    });

    let itemCounter = {{ $project->items->count() + 1 ?? 1 }}; // Start counter after existing items

    function selectProduct(rowNum) {
        const select = $('#product' + rowNum);
        const selectedOption = select.find('option:selected');

        const stock = selectedOption.data('stock') || 0;
        const price = selectedOption.data('price') || 0;
        const warranty = selectedOption.data('warranty') || 0;

        $('#stock' + rowNum).val(stock);
        $('#purchase_price' + rowNum).val(price);
        $('#warranty' + rowNum).val(warranty);
        $('#unit_price' + rowNum).val(price.toFixed(2)); // Pre-fill unit price with purchase price

        calculateTotal(); // Update totals when product changes
    }

    function addItem() {
        const select = $('#product1');
        if (!select.val()) {
            alert('Please select a product first!');
            return;
        }

        const selectedOption = select.find('option:selected');
        const productId = select.val();
        const productName = selectedOption.text();
        const stock = selectedOption.data('stock') || 0;
        const warranty = selectedOption.data('warranty') || 0;
        const purchasePrice = selectedOption.data('price') || 0;
        const unitPrice = $('#unit_price1').val() || purchasePrice;
        const qty = $('#qty1').val() || 1;
        const total = (unitPrice * qty).toFixed(2);

        // Check if product already exists
        let exists = false;
        $('#item_container .group-item').each(function() {
            if ($(this).find('input[name*="product_id"]').val() == productId) {
                alert('This product has already been added!');
                exists = true;
                return false;
            }
        });

        if (exists) return;

        const newRow = `
            <div class="group-item mt-2" data-itemnumber="${itemCounter}" id="form-group-item${itemCounter}">
                <div class="row align-items-end">
                    <div class="col-md-4">
                        <input type="hidden" name="items[new_${itemCounter}][product_id]" value="${productId}">
                        <p><strong>${productName}</strong></p>
                        <small class="text-muted">Stock: ${stock} | Warranty: ${warranty} days</small>
                    </div>
                    <div class="col-md-2">
                        <input onchange="calculateTotal()" type="number" name="items[new_${itemCounter}][unit_price]" 
                               id="unit_price${itemCounter}" class="form-control unit-price" value="${parseFloat(unitPrice).toFixed(2)}" step="0.01">
                    </div>
                    <div class="col-md-2">
                        <input onchange="calculateTotal()" type="number" name="items[new_${itemCounter}][quantity]" 
                               id="qty${itemCounter}" class="form-control qty" min="1" value="${qty}">
                    </div>
                    <div class="col-md-2">
                        <input type="number" name="items[new_${itemCounter}][total_price]" 
                               id="total${itemCounter}" class="form-control total" readonly value="${total}" step="0.01">
                    </div>
                    <div class="col-md-2 text-end">
                        <button type="button" onclick="removeItem(${itemCounter})" class="btn btn-danger btn-sm">×</button>
                    </div>
                </div>
            </div>
        `;

        $('#item_container').append(newRow);
        itemCounter++;

        // Reset the "Add New Item" section
        $('#product1').val('').trigger('change');
        $('#stock1, #warranty1, #purchase_price1, #unit_price1').val('');
        $('#qty1').val(1);

        calculateTotal();
    }

    function removeItem(rowNum) {
        $(`#form-group-item${rowNum}`).remove();
        calculateTotal();
    }

    function calculateTotal() {
        let subTotal = 0;

        $('.group-item').each(function() {
            const unitPriceInput = $(this).find('.unit-price');
            const qtyInput = $(this).find('.qty');
            const totalInput = $(this).find('.total');

            if (unitPriceInput.length && qtyInput.length && totalInput.length) {
                const unitPrice = parseFloat(unitPriceInput.val()) || 0;
                const qty = parseFloat(qtyInput.val()) || 0;
                const total = unitPrice * qty;

                totalInput.val(total.toFixed(2));
                subTotal += total;
            }
        });

        $('#subTotal').val(subTotal.toFixed(2));
        $('#grandTotal').val(subTotal.toFixed(2)); // You can add discount/tax later here
    }
</script>

@endsection