@extends('layouts.app')

@section('content')
    <div class="container-fluid">
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <div class="d-flex justify-content-between align-items-center">
                            <h4 class="mb-0">Create New Bill</h4>
                            <div>
                                <a href="{{ route('bills.index') }}" class="btn btn-secondary">
                                    Back
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <form id="billForm" action="{{ route('bills.store') }}" method="POST">
                            @csrf

                            <!-- Bill Basic Information -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <h5 class="border-bottom pb-2 mb-3">Bill Information</h5>
                                </div>

                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Bill Type *</label>
                                        <select class="form-control" name="bill_type" id="bill_type" required>
                                            <option value="">Select Bill Type</option>
                                            <option value="sale">Sales Bill</option>
                                            <option value="project">Project Bill</option>
                                        </select>
                                    </div>
                                </div>

                                <!-- Dynamic Selection Area -->
                                <div class="col-md-6" id="dynamic-selection">
                                    <!-- Will be populated by JavaScript -->
                                </div>

                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="form-label">Reference Number *</label>
                                        <input type="text" class="form-control" name="reference_number"
                                            value="BIL-{{ date('Ymd-His') }}" required>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="form-label">Bill Date *</label>
                                        <input type="date" class="form-control" name="bill_date"
                                            value="{{ date('Y-m-d') }}" required>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="form-label">Work Order (Optional)</label>
                                        <input type="text" class="form-control" name="work_order_number">
                                    </div>
                                </div>

                                <!-- Client/Project Information (Auto-filled) -->
                                <div class="row mb-4 p-2" id="auto-info-section" style="display: none;">
                                    <div class="col-12">
                                        <h5 class="border-bottom pb-2 mb-3 text-success">
                                            Auto-filled Information
                                        </h5>
                                    </div>

                                    <!-- Add this row wrapper for side-by-side layout -->
                                    <div class="row w-100">
                                        <!-- Customer Information -->
                                        <div class="col-md-6">
                                            <div class="card">
                                                <div class="card-header bg-light">
                                                    <h6 class="mb-0"> Customer Information</h6>
                                                </div>
                                                <div class="card-body">
                                                    <div class="row">
                                                        <div class="col-12 mb-2">
                                                            <strong>Name:</strong> <span id="client-name">-</span>
                                                        </div>
                                                        <div class="col-12 mb-2">
                                                            <strong>Email:</strong> <span id="client-email">-</span>
                                                        </div>
                                                        <div class="col-12 mb-2">
                                                            <strong>Phone:</strong> <span id="client-phone">-</span>
                                                        </div>
                                                        <div class="col-12">
                                                            <strong>Address:</strong> <span id="client-address">-</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Sale/Project Information -->
                                        <div class="col-md-6">
                                            <div class="card">
                                                <div class="card-header bg-light">
                                                    <h6 class="mb-0" id="info-title">
                                                        Details</h6>
                                                </div>
                                                <div class="card-body">
                                                    <div class="row">
                                                        <div class="col-12 mb-2">
                                                            <strong>Reference No:</strong> <span
                                                                id="detail-reference">-</span>
                                                        </div>
                                                        <div class="col-12 mb-2">
                                                            <strong>Date:</strong> <span id="detail-date">-</span>
                                                        </div>
                                                        <div class="col-12 mb-2">
                                                            <strong>Total Amount:</strong> <span id="detail-amount">-</span>
                                                        </div>
                                                        <div class="col-12 mb-2">
                                                            <strong>Due Payment:</strong> <span id="detail-due">-</span>
                                                        </div>
                                                        {{-- <div class="col-12">
                                                        <strong>Status:</strong> <span id="detail-status">-</span>
                                                    </div> --}}
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Bill Items Section (Auto-filled from Sale/Project) -->
                                <div class="row mb-4">
                                    <div class="col-12">
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <h5 class="mb-0">Bill Items</h5>
                                            <span class="badge bg-info" id="items-count">0 items</span>
                                        </div>

                                        <div id="items-container">
                                            <!-- Items will be auto-populated here -->
                                            <div class="text-center p-4" id="no-items-message">
                                                <i class="fas fa-shopping-cart fa-2x text-muted mb-2"></i>
                                                <p class="text-muted">Select a sale or project to auto-fill items</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Totals Section -->
                                <div class="row mb-4">
                                    <div class="col-md-6 offset-md-6">
                                        <div class="card bg-light">
                                            <div class="card-body">
                                                <div class="row mb-2">
                                                    <div class="col-6">
                                                        <strong>Subtotal:</strong>
                                                    </div>
                                                    <div class="col-6 text-end">
                                                        <span id="subtotal-display">0.00</span>
                                                    </div>
                                                </div>
                                                <div class="row mb-2">
                                                    <div class="col-6">
                                                        <strong>Total Amount:</strong>
                                                    </div>
                                                    <div class="col-6 text-end">
                                                        <span id="total-display">0.00</span>
                                                        <input type="hidden" id="total_amount" name="total_amount"
                                                            value="0">
                                                        <input type="hidden" id="subtotal" name="subtotal"
                                                            value="0">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Notes Section -->
                                <div class="row mb-4">
                                    <div class="col-12">
                                        <div class="form-group">
                                            <label class="form-label">Notes</label>
                                            <textarea class="form-control" name="notes" rows="3" placeholder="Additional notes or terms..."></textarea>
                                        </div>
                                    </div>
                                </div>

                                <!-- Submit Button -->
                                <div class="row">
                                    <div class="col-12">
                                        <div class="d-flex justify-content-end">
                                            <button type="submit" class="btn btn-success btn-lg">
                                                Generate Bill
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <!-- Hidden fields to store selected data -->
                                <input type="hidden" name="selected_sale_id" id="selected_sale_id">
                                <input type="hidden" name="selected_project_id" id="selected_project_id">
                                <input type="hidden" name="client_id" id="client_id">
                        </form>
                        <script>
                            document.addEventListener('DOMContentLoaded', function() {
                                console.log('Script loaded - checking for duplicates');
                                if (window.billFormHandlerLoaded) {
                                    console.error('WARNING: Script already loaded!');
                                    return;
                                }
                                window.billFormHandlerLoaded = true;

                                const billTypeSelect = document.getElementById('bill_type');
                                const dynamicSelection = document.getElementById('dynamic-selection');
                                const autoInfoSection = document.getElementById('auto-info-section');
                                const itemsContainer = document.getElementById('items-container');
                                const noItemsMessage = document.getElementById('no-items-message');
                                const billForm = document.getElementById('billForm');

                                // Get the base URL for API calls
                                const baseUrl = window.location.origin;

                                // Store loaded data globally so it persists
                                let loadedSalesData = null;
                                let loadedProjectsData = null;
                                let formSubmitted = false; // SINGLE submission flag

                                // Bill type change handler
                                billTypeSelect.addEventListener('change', function() {
                                    const billType = this.value;
                                    console.log('Bill type selected:', billType);
                                    dynamicSelection.innerHTML = '';
                                    autoInfoSection.style.display = 'none';
                                    clearItems();

                                    if (billType === 'sale') {
                                        showSalesSelection();
                                    } else if (billType === 'project') {
                                        showProjectsSelection();
                                    }
                                });

                                function showSalesSelection() {
                                    let html = `
            <div class="form-group">
                <label class="form-label">Select Sale *</label>
                <select class="form-control" name="sale_id" id="sale_select" required>
                    <option value="">Loading sales...</option>
                </select>
            </div>
        `;
                                    dynamicSelection.innerHTML = html;

                                    if (loadedSalesData) {
                                        populateSalesSelect(loadedSalesData);
                                    } else {
                                        fetch(`${baseUrl}/get-sales`)
                                            .then(response => {
                                                if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
                                                return response.json();
                                            })
                                            .then(data => {
                                                loadedSalesData = data;
                                                populateSalesSelect(data);
                                            })
                                            .catch(error => {
                                                document.getElementById('sale_select').innerHTML =
                                                    '<option value="">Error loading sales</option>';
                                            });
                                    }
                                }

                                function populateSalesSelect(data) {
                                    const select = document.getElementById('sale_select');

                                    if (data.sales && data.sales.length > 0) {
                                        select.innerHTML = '<option value="">Select a Sale</option>';

                                        data.sales.forEach(sale => {
                                            const customerName = sale.customer?.name || 'Unknown Customer';
                                            select.innerHTML +=
                                                `<option value="${sale.id}">${sale.order_no} - ${customerName}</option>`;
                                        });

                                        select.addEventListener('change', function() {
                                            const saleId = this.value;
                                            if (saleId) {
                                                const sale = data.sales.find(s => s.id == saleId);
                                                autoFillSaleData(sale);
                                            } else {
                                                autoInfoSection.style.display = 'none';
                                                clearItems();
                                            }
                                        });
                                    } else {
                                        select.innerHTML = '<option value="">No sales found</option>';
                                    }
                                }

                                function showProjectsSelection() {
                                    let html = `
            <div class="form-group">
                <label class="form-label">Select Project *</label>
                <select class="form-control" name="project_id" id="project_select" required>
                    <option value="">Loading projects...</option>
                </select>
            </div>
        `;
                                    dynamicSelection.innerHTML = html;

                                    if (loadedProjectsData) {
                                        populateProjectsSelect(loadedProjectsData);
                                    } else {
                                        fetch(`${baseUrl}/get-projects`)
                                            .then(response => {
                                                if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
                                                return response.json();
                                            })
                                            .then(data => {
                                                loadedProjectsData = data;
                                                populateProjectsSelect(data);
                                            })
                                            .catch(error => {
                                                document.getElementById('project_select').innerHTML =
                                                    '<option value="">Error loading projects</option>';
                                            });
                                    }
                                }

                                function populateProjectsSelect(data) {
                                    const select = document.getElementById('project_select');

                                    if (data.projects && data.projects.length > 0) {
                                        select.innerHTML = '<option value="">Select a Project</option>';

                                        data.projects.forEach(project => {
                                            const clientName = project.client?.name || 'Unknown Client';
                                            select.innerHTML +=
                                                `<option value="${project.id}">${project.name} - ${clientName}</option>`;
                                        });

                                        select.addEventListener('change', function() {
                                            const projectId = this.value;
                                            if (projectId) {
                                                const project = data.projects.find(p => p.id == projectId);
                                                autoFillProjectData(project);
                                            } else {
                                                autoInfoSection.style.display = 'none';
                                                clearItems();
                                            }
                                        });
                                    } else {
                                        select.innerHTML = '<option value="">No projects found</option>';
                                    }
                                }

                                function autoFillSaleData(sale) {
                                    document.getElementById('selected_sale_id').value = sale.id;
                                    document.getElementById('selected_project_id').value = '';
                                    document.getElementById('client_id').value = sale.customer?.id || '';

                                    document.getElementById('client-name').textContent = sale.customer?.name || 'N/A';
                                    document.getElementById('client-email').textContent = sale.customer?.email || 'N/A';
                                    document.getElementById('client-phone').textContent = sale.customer?.phone || 'N/A';
                                    document.getElementById('client-address').textContent = sale.customer?.address || 'N/A';

                                    document.getElementById('info-title').innerHTML = 'Sale Information';
                                    document.getElementById('detail-reference').textContent = sale.order_no || 'N/A';
                                    document.getElementById('detail-date').textContent = sale.date || 'N/A';
                                    document.getElementById('detail-amount').textContent = parseFloat(sale.total_amount || 0).toFixed(
                                        2);
                                    document.getElementById('detail-due').textContent = parseFloat(sale.due_payment || 0).toFixed(2);

                                    autoInfoSection.style.display = 'block';
                                    populateItems(sale.items || [], 'sale');
                                }

                                function autoFillProjectData(project) {
                                    document.getElementById('selected_project_id').value = project.id;
                                    document.getElementById('selected_sale_id').value = '';
                                    document.getElementById('client_id').value = project.client?.id || '';

                                    document.getElementById('client-name').textContent = project.client?.name || 'N/A';
                                    document.getElementById('client-email').textContent = project.client?.email || 'N/A';
                                    document.getElementById('client-phone').textContent = project.client?.phone || 'N/A';
                                    document.getElementById('client-address').textContent = project.client?.address || 'N/A';

                                    document.getElementById('info-title').innerHTML = 'Project Information';
                                    document.getElementById('detail-reference').textContent = project.reference || 'N/A';
                                    document.getElementById('detail-date').textContent = project.date || 'N/A';
                                    document.getElementById('detail-amount').textContent = parseFloat(project.total_amount || 0)
                                        .toFixed(2);
                                    document.getElementById('detail-due').textContent = parseFloat(project.due_payment || 0).toFixed(2);

                                    autoInfoSection.style.display = 'block';
                                    populateItems(project.items || [], 'project');
                                }

                                function populateItems(items, type) {
                                    noItemsMessage.style.display = 'none';
                                    itemsContainer.innerHTML = '';

                                    if (items.length === 0) {
                                        itemsContainer.innerHTML = `
                <div class="text-center p-4">
                    <i class="fas fa-exclamation-triangle fa-2x text-warning mb-2"></i>
                    <p class="text-muted">No items found for this ${type}</p>
                </div>
            `;
                                        document.getElementById('items-count').textContent = '0 items';
                                        updateTotals([]);
                                        return;
                                    }

                                    items.forEach((item, index) => {
                                        const itemHtml = `
                <div class="item-card card mb-3">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Item Description *</label>
                                    <textarea class="form-control item-description" name="items[${index}][description]" rows="2" required readonly>${item.description || 'No description'}</textarea>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label class="form-label">Quantity *</label>
                                    <input type="number" class="form-control item-quantity" 
                                        name="items[${index}][quantity]" value="${item.quantity || 1}" min="1" required readonly>
                                    <input type="text" class="form-control mt-1" value="${item.unit || 'Piece'}" readonly>
                                    <input type="hidden" name="items[${index}][unit]" value="${item.unit || 'Piece'}">
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label class="form-label">Unit Price *</label>
                                    <input type="number" class="form-control item-unit-price" 
                                        name="items[${index}][unit_price]" value="${item.unit_price || 0}" step="0.01" readonly>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label class="form-label">Total Price</label>
                                    <input type="text" class="form-control item-total" 
                                        value="${parseFloat(item.total || 0).toFixed(2)}" readonly>
                                    <input type="hidden" name="items[${index}][total]" value="${item.total || 0}">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            `;
                                        itemsContainer.innerHTML += itemHtml;
                                    });

                                    document.getElementById('items-count').textContent = items.length + ' item(s)';
                                    updateTotals(items);
                                }

                                function clearItems() {
                                    itemsContainer.innerHTML = '';
                                    noItemsMessage.style.display = 'block';
                                    document.getElementById('items-count').textContent = '0 items';
                                    updateTotals([]);
                                }

                                function updateTotals(items) {
                                    const subtotal = items.reduce((sum, item) => sum + parseFloat(item.total || 0), 0);
                                    document.getElementById('subtotal-display').textContent = subtotal.toFixed(2);
                                    document.getElementById('total-display').textContent = subtotal.toFixed(2);
                                    document.getElementById('subtotal').value = subtotal;
                                    document.getElementById('total_amount').value = subtotal;
                                }

                                // SINGLE form submission handler with aggressive duplicate prevention
                                function handleFormSubmit(e) {
                                    e.preventDefault();
                                    e.stopImmediatePropagation(); // Prevent other listeners

                                    console.log('Form submit triggered');

                                    // Double submission protection
                                    if (formSubmitted) {
                                        console.log('BLOCKED: Form already submitting');
                                        return false;
                                    }
                                    formSubmitted = true;

                                    const formData = new FormData(this);
                                    const submitBtn = this.querySelector('button[type="submit"]');

                                    // Show loading state
                                    const originalText = submitBtn.innerHTML;
                                    submitBtn.disabled = true;
                                    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Generating PDF...';

                                    console.log('Starting form submission...');

                                    fetch(this.action, {
                                            method: 'POST',
                                            body: formData,
                                            headers: {
                                                'X-Requested-With': 'XMLHttpRequest',
                                            }
                                        })
                                        .then(response => {
                                            if (!response.ok) throw new Error('Network response was not ok: ' + response.status);

                                            const contentType = response.headers.get('content-type');
                                            if (contentType && contentType.includes('application/pdf')) {
                                                return response.blob().then(blob => {
                                                    const url = window.URL.createObjectURL(blob);
                                                    const a = document.createElement('a');
                                                    a.style.display = 'none';
                                                    a.href = url;

                                                    const contentDisposition = response.headers.get('content-disposition');
                                                    let filename = 'bill.pdf';
                                                    if (contentDisposition) {
                                                        const filenameMatch = contentDisposition.match(/filename="(.+)"/);
                                                        if (filenameMatch) filename = filenameMatch[1];
                                                    }

                                                    a.download = filename;
                                                    document.body.appendChild(a);
                                                    a.click();

                                                    // Cleanup
                                                    setTimeout(() => {
                                                        window.URL.revokeObjectURL(url);
                                                        document.body.removeChild(a);
                                                        alert('PDF generated and downloaded successfully!');
                                                        console.log('PDF download completed - SINGLE');
                                                    }, 100);
                                                });
                                            } else {
                                                return response.text().then(text => {
                                                    throw new Error('Server returned an unexpected response');
                                                });
                                            }
                                        })
                                        .catch(error => {
                                            console.error('Error:', error);
                                            alert('Error generating PDF: ' + error.message);
                                            formSubmitted = false; // Reset on error
                                        })
                                        .finally(() => {
                                            submitBtn.disabled = false;
                                            submitBtn.innerHTML = originalText;
                                            console.log('Form submission process completed - SINGLE');

                                            // Keep form locked for 5 seconds to prevent rapid resubmission
                                            setTimeout(() => {
                                                formSubmitted = false;
                                                console.log('Form unlocked and ready for new submission');
                                            }, 5000);
                                        });

                                    return false;
                                }

                                // Remove any existing listeners and attach fresh
                                billForm.removeEventListener('submit', handleFormSubmit);
                                billForm.addEventListener('submit', handleFormSubmit);

                                console.log('Form handler attached successfully');
                            });
                        </script>

                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection

@push('styles')
    {{-- <style>
        .bill-type-section {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 4px solid #007bff;
        }

        .item-card {
            border-left: 4px solid #28a745;
            transition: all 0.3s ease;
        }

        .item-card:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .form-label {
            font-weight: 600;
            color: #495057;
        }

        .card-header {
            background-color: #f8f9fa;
            border-bottom: 1px solid #dee2e6;
        }
    </style> --}}
@endpush
