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
                                        <label class="form-label">Bill Type</label>
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
                                        <label class="form-label">Reference Number</label>
                                        <input type="text" class="form-control" name="reference_number"
                                            value="BIL-{{ date('Ymd-His') }}" required>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="form-label">Bill Date</label>
                                        <input type="date" class="form-control" name="bill_date"
                                            value="{{ date('Y-m-d') }}" required>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="form-label">Work Order</label>
                                        <input type="text" class="form-control" name="work_order_number">
                                    </div>
                                </div>
                            </div>

                            <!-- Client Information Section (Always Required) -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <h5 class="border-bottom pb-2 mb-3 text-primary">Client Information</h5>
                                </div>

                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Client/Company Name *</label>
                                        <input type="text" class="form-control" id="client_name" name="client_name"
                                            placeholder="Enter client or company name" required>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Attention To</label>
                                        <input type="text" class="form-control" id="attention_to" name="attention_to"
                                            placeholder="Enter contact person name">
                                    </div>
                                </div>

                                <div class="col-12">
                                    <div class="form-group">
                                        <label class="form-label">Client Address </label>
                                        <textarea class="form-control" id="client_address" name="client_address" rows="3"
                                            placeholder="Enter client address" required></textarea>
                                    </div>
                                </div>
                            </div>

                            <!-- Auto-filled Information Section -->
                            <div class="row mb-4 p-2" id="auto-info-section" style="display: none;">
                                <div class="col-12">
                                    <h5 class="border-bottom pb-2 mb-3 text-success">
                                        Auto-filled Information
                                    </h5>
                                </div>

                                <div class="row w-100">
                                    <!-- Sale/Project Information -->
                                    <div class="col-md-12">
                                        <div class="card">
                                            <div class="card-header bg-light">
                                                <h6 class="mb-0" id="info-title">Details</h6>
                                            </div>
                                            <div class="card-body">
                                                <div class="row">
                                                    <div class="col-md-3 mb-2">
                                                        <strong>Reference No:</strong> <span id="detail-reference">-</span>
                                                    </div>
                                                    <div class="col-md-3 mb-2">
                                                        <strong>Date:</strong> <span id="detail-date">-</span>
                                                    </div>
                                                    <div class="col-md-3 mb-2">
                                                        <strong>Total Amount:</strong> <span id="detail-amount">-</span>
                                                    </div>
                                                    <div class="col-md-3 mb-2">
                                                        <strong>Due Payment:</strong> <span id="detail-due">-</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Bill Items Section -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <h5 class="mb-0">Bill Items</h5>
                                        <div>
                                            <span class="badge bg-info" id="items-count">0 items</span>
                                            {{-- <button type="button" class="btn btn-sm btn-outline-primary ms-2"
                                                id="add-manual-item">
                                                <i class="fas fa-plus"></i> Add Item
                                            </button> --}}
                                        </div>
                                    </div>

                                    <div id="items-container">
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
                                    {{-- <div class="card bg-light">
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
                                                    <span id="total-display">0.00</span> --}}
                                    <input type="hidden" id="total_amount" name="total_amount" value="0">
                                    <input type="hidden" id="subtotal" name="subtotal" value="0">
                                    {{-- </div>
                                            </div>
                                        </div>
                                    </div> --}}
                                </div>
                            </div>

                            <!-- Terms and Conditions Section -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <h5 class="border-bottom pb-2 mb-3">Terms and Conditions</h5>
                                    <div class="form-group">
                                        <label class="form-label">Custom Terms & Conditions *</label>
                                        <textarea class="form-control" name="terms_conditions" id="terms_conditions" rows="5"
                                            placeholder="Enter your custom terms and conditions here..." required></textarea>
                                    </div>
                                    <div class="form-check mb-3">
                                        <input class="form-check-input" type="checkbox" id="use_default_terms">
                                        <label class="form-check-label" for="use_default_terms">
                                            Use default terms and conditions
                                        </label>
                                    </div>
                                </div>
                            </div>

                            <!-- Subject Section -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <h5 class="border-bottom pb-2 mb-3">Bill Subject</h5>
                                </div>

                                <div class="col-12">
                                    <div class="form-group">
                                        <label class="form-label">Bill Subject *</label>
                                        <input type="text" class="form-control" name="subject"
                                            value="Bill for Supplying of Products/Services" required
                                            placeholder="Enter bill subject">
                                    </div>
                                </div>
                            </div>

                            <!-- Bank Details Section -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <h5 class="border-bottom pb-2 mb-3">Bank Details</h5>
                                </div>

                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Account Name</label>
                                        <input type="text" class="form-control" name="bank_account_name"
                                            value="Intelligent Technology" required>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Bank Name</label>
                                        <input type="text" class="form-control" name="bank_name"
                                            value="Bank Asia Ltd." required>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="form-label">Branch</label>
                                        <input type="text" class="form-control" name="bank_branch"
                                            value="Satmosjid Road" required>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="form-label">Account Number</label>
                                        <input type="text" class="form-control" name="bank_account_number"
                                            value="06933000526" required>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="form-label">Account Type</label>
                                        <input type="text" class="form-control" name="bank_account_type"
                                            value="Current" required>
                                    </div>
                                </div>
                            </div>

                            <!-- Sales Person Details Section -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <h5 class="border-bottom pb-2 mb-3">Company & Signatory Details</h5>
                                </div>

                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Company Name</label>
                                        <input type="text" class="form-control" name="company_name"
                                            value="Intelligent Technology" required>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Signatory Name</label>
                                        <input type="text" class="form-control" name="signatory_name"
                                            value="Engr. Shamsul Alam" required>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="form-label">Signatory Designation</label>
                                        <input type="text" class="form-control" name="signatory_designation"
                                            value="Director (Technical)" required>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="form-label">Phone</label>
                                        <input type="text" class="form-control" name="company_phone"
                                            value="+880 XXXX-XXXXXX">
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="form-label">Email</label>
                                        <input type="email" class="form-control" name="company_email"
                                            value="info@intelligenttech.com">
                                    </div>
                                </div>

                                <div class="col-12">
                                    <div class="form-group">
                                        <label class="form-label">Website</label>
                                        <input type="text" class="form-control" name="company_website"
                                            value="www.intelligenttech.com">
                                    </div>
                                </div>
                            </div>

                            {{-- <!-- Notes Section -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <div class="form-group">
                                        <label class="form-label">Additional Notes</label>
                                        <textarea class="form-control" name="notes" rows="3" placeholder="Additional notes or comments..."></textarea>
                                    </div>
                                </div>
                            </div> --}}

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
                                const useDefaultTerms = document.getElementById('use_default_terms');
                                const termsTextarea = document.getElementById('terms_conditions');
                                const billForm = document.getElementById('billForm');

                                // Default terms and conditions
                                const defaultTerms = `1. The products come with a 1-year limited warranty. Please note that the warranty does not cover physical damage or burn cases.
2. The delivered products & accessories will not be changeable after use.
3. The party will pay by Cash/ an account Payee Cheque/DD/Pay Order in favor of our company with a work order.
4. Govt. VAT & TAX: Prices are including of all kinds of TAX & VAT as per government rule.`;

                                // Set default terms
                                termsTextarea.value = defaultTerms;

                                // Get the base URL for API calls
                                const baseUrl = window.location.origin;

                                // Store loaded data globally so it persists
                                let loadedSalesData = null;
                                let loadedProjectsData = null;
                                let formSubmitted = false;

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

                                // Use default terms checkbox handler
                                useDefaultTerms.addEventListener('change', function() {
                                    if (this.checked) {
                                        termsTextarea.value = defaultTerms;
                                    } else {
                                        termsTextarea.value = '';
                                    }
                                });

                                function showSalesSelection() {
                                    let html = `
            <div class="form-group">
                <label class="form-label">Select Sale</label>
                <select class="form-control" name="sale_id" id="sale_select">
                    <option value="">Select a Sale (Optional)</option>
                </select>
            </div>
        `;
                                    dynamicSelection.innerHTML = html;

                                    console.log('Loading sales data...');

                                    fetch(`${baseUrl}/get-sales`)
                                        .then(response => {
                                            if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
                                            return response.json();
                                        })
                                        .then(data => {
                                            console.log('Sales API Response:', data);
                                            loadedSalesData = data;
                                            populateSalesSelect(data);
                                        })
                                        .catch(error => {
                                            console.error('Error loading sales:', error);
                                            document.getElementById('sale_select').innerHTML =
                                                '<option value="">Error loading sales</option>';
                                        });
                                }

                                function populateSalesSelect(data) {
                                    const select = document.getElementById('sale_select');

                                    if (data.sales && data.sales.length > 0) {
                                        select.innerHTML = '<option value="">Select a Sale (Optional)</option>';

                                        console.log('All sales from API:', data.sales);

                                        // GUARANTEED FILTERING: Only show INV-* orders
                                        const invSales = data.sales.filter(sale => {
                                            const isInv = sale.order_no && sale.order_no.startsWith('INV-');
                                            console.log(`Sale ${sale.id}: ${sale.order_no} -> INV: ${isInv}`);
                                            return isInv;
                                        });

                                        console.log('Filtered INV sales:', invSales);

                                        if (invSales.length > 0) {
                                            invSales.forEach(sale => {
                                                const customerName = sale.customer?.name || 'Unknown Customer';
                                                const displayText =
                                                    `${sale.order_no} - ${customerName} `;

                                                select.innerHTML += `<option value="${sale.id}">${displayText}</option>`;
                                            });

                                            console.log(
                                                `Displayed ${invSales.length} INV sales out of ${data.sales.length} total sales`);
                                        } else {
                                            select.innerHTML = '<option value="">No invoice sales found</option>';
                                            console.warn('No INV-* sales found after filtering');
                                        }

                                        select.addEventListener('change', function() {
                                            const saleId = this.value;
                                            if (saleId) {
                                                const sale = invSales.find(s => s.id == saleId);
                                                if (sale) {
                                                    autoFillSaleData(sale);
                                                } else {
                                                    console.error('Sale not found in filtered list:', saleId);
                                                }
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
                <label class="form-label">Select Project</label>
                <select class="form-control" name="project_id" id="project_select">
                    <option value="">Select a Project (Optional)</option>
                </select>
            </div>
        `;
                                    dynamicSelection.innerHTML = html;

                                    console.log('Loading projects data...');

                                    if (loadedProjectsData) {
                                        populateProjectsSelect(loadedProjectsData);
                                    } else {
                                        fetch(`${baseUrl}/get-projects`)
                                            .then(response => {
                                                if (!response.ok) {
                                                    console.error('Projects API error:', response.status);
                                                    throw new Error(`HTTP error! status: ${response.status}`);
                                                }
                                                return response.json();
                                            })
                                            .then(data => {
                                                console.log('Projects API Response:', data);
                                                loadedProjectsData = data;
                                                populateProjectsSelect(data);
                                            })
                                            .catch(error => {
                                                console.error('Error loading projects:', error);
                                                document.getElementById('project_select').innerHTML =
                                                    '<option value="">Error loading projects - check console</option>';
                                            });
                                    }
                                }

                                function populateProjectsSelect(data) {
                                    const select = document.getElementById('project_select');
                                    console.log('Populating projects select with:', data);

                                    if (data.projects && data.projects.length > 0) {
                                        select.innerHTML = '<option value="">Select a Project (Optional)</option>';

                                        data.projects.forEach(project => {
                                            const clientName = project.client?.name || project.client_name || 'Unknown Client';
                                            select.innerHTML +=
                                                `<option value="${project.id}">${project.name} - ${clientName}</option>`;
                                        });

                                        select.addEventListener('change', function() {
                                            const projectId = this.value;
                                            if (projectId) {
                                                const project = data.projects.find(p => p.id == projectId);
                                                console.log('Selected project:', project);
                                                autoFillProjectData(project);
                                            } else {
                                                autoInfoSection.style.display = 'none';
                                                clearItems();
                                            }
                                        });
                                    } else {
                                        select.innerHTML = '<option value="">No projects found</option>';
                                        console.log('No projects data found');
                                    }
                                }

                                function autoFillSaleData(sale) {
                                    console.log('Auto-filling sale data:', sale);
                                    document.getElementById('selected_sale_id').value = sale.id;
                                    document.getElementById('selected_project_id').value = '';

                                    // Auto-fill client information if available
                                    if (sale.customer) {
                                        document.getElementById('client_name').value = sale.customer.name || '';
                                        document.getElementById('client_address').value = sale.customer.address || '';
                                    }

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
                                    console.log('Auto-filling project data:', project);
                                    document.getElementById('selected_project_id').value = project.id;
                                    document.getElementById('selected_sale_id').value = '';

                                    // Auto-fill client information if available
                                    if (project.client) {
                                        document.getElementById('client_name').value = project.client.name || '';
                                        document.getElementById('client_address').value = project.client.address || '';
                                    }

                                    document.getElementById('info-title').innerHTML = 'Project Information';
                                    document.getElementById('detail-reference').textContent = project.reference || project.name ||
                                        'N/A';
                                    document.getElementById('detail-date').textContent = project.date || 'N/A';

                                    // Use the budget amount from total_amount
                                    document.getElementById('detail-amount').textContent = parseFloat(project.total_amount || 0)
                                        .toFixed(2);
                                    document.getElementById('detail-due').textContent = parseFloat(project.due_payment || 0).toFixed(2);

                                    autoInfoSection.style.display = 'block';

                                    const items = project.items || [];
                                    populateItems(items, 'project');
                                }

                                function populateItems(items, type) {
                                    noItemsMessage.style.display = 'none'; // Hide the "no items" message
                                    itemsContainer.innerHTML = '';

                                    items.forEach((item, index) => {
                                        const totalPrice = parseFloat(item.total || (item.quantity * item.unit_price) || 0)
                                            .toFixed(2);
                                        const itemHtml = `
                <div class="item-card card mb-3">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="form-label">Item Description *</label>
                                    <textarea class="form-control item-description" name="items[${index}][description]" rows="4" required readonly>${item.description || item.name || 'No description'}</textarea>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label class="form-label">Quantity *</label>
                                    <input type="number" class="form-control item-quantity" 
                                        name="items[${index}][quantity]" value="${item.quantity || 1}" min="1" required readonly>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label class="form-label">Unit</label>
                                    <input type="text" class="form-control" name="items[${index}][unit]" value="${item.unit || 'Piece'}" readonly>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label class="form-label">Unit Price *</label>
                                    <input type="number" class="form-control item-unit-price" 
                                        name="items[${index}][unit_price]" value="${item.unit_price || item.price || 0}" step="0.01" readonly>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label class="form-label">Total</label>
                                    <input type="text" class="form-control item-total" 
                                        value="${totalPrice}" readonly>
                                    <input type="hidden" name="items[${index}][total]" value="${totalPrice}">
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
                                    noItemsMessage.style.display = 'block'; // Show the "no items" message
                                    document.getElementById('items-count').textContent = '0 items';
                                    updateTotals([]);
                                }

                                function updateTotals(items) {
                                    const subtotal = items.reduce((sum, item) => sum + parseFloat(item.total || 0), 0);
                                    document.getElementById('subtotal').value = subtotal;
                                    document.getElementById('total_amount').value = subtotal;
                                }

                                // Form submission handler
                                function handleFormSubmit(e) {
                                    e.preventDefault();
                                    e.stopImmediatePropagation();

                                    console.log('Form submit triggered');

                                    if (formSubmitted) {
                                        console.log('BLOCKED: Form already submitting');
                                        return false;
                                    }

                                    // Validate required fields
                                    const clientName = document.getElementById('client_name').value;
                                    const clientAddress = document.getElementById('client_address').value;
                                    const termsConditions = document.getElementById('terms_conditions').value;

                                    if (!clientName.trim()) {
                                        alert('Please enter client/company name');
                                        return false;
                                    }

                                    if (!clientAddress.trim()) {
                                        alert('Please enter client address');
                                        return false;
                                    }

                                    if (!termsConditions.trim()) {
                                        alert('Please enter terms and conditions');
                                        return false;
                                    }

                                    formSubmitted = true;

                                    const formData = new FormData(this);
                                    const submitBtn = this.querySelector('button[type="submit"]');

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

                                                    setTimeout(() => {
                                                        window.URL.revokeObjectURL(url);
                                                        document.body.removeChild(a);
                                                        alert('PDF generated and downloaded successfully!');
                                                        console.log('PDF download completed');
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
                                            formSubmitted = false;
                                        })
                                        .finally(() => {
                                            submitBtn.disabled = false;
                                            submitBtn.innerHTML = originalText;

                                            setTimeout(() => {
                                                formSubmitted = false;
                                                console.log('Form unlocked and ready for new submission');
                                            }, 5000);
                                        });

                                    return false;
                                }

                                billForm.removeEventListener('submit', handleFormSubmit);
                                billForm.addEventListener('submit', handleFormSubmit);

                                console.log('Form handler attached successfully');
                            });
                        </script>

                        {{-- <script>
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
                                const useDefaultTerms = document.getElementById('use_default_terms');
                                const termsTextarea = document.getElementById('terms_conditions');
                                const billForm = document.getElementById('billForm');

                                // Default terms and conditions
                                const defaultTerms = `1. The products come with a 1-year limited warranty. Please note that the warranty does not cover physical damage or burn cases.
2. The delivered products & accessories will not be changeable after use.
3. The party will pay by Cash/ an account Payee Cheque/DD/Pay Order in favor of our company with a work order.
4. Govt. VAT & TAX: Prices are including of all kinds of TAX & VAT as per government rule.`;

                                // Set default terms
                                termsTextarea.value = defaultTerms;

                                // Get the base URL for API calls
                                const baseUrl = window.location.origin;

                                // Store loaded data globally so it persists
                                let loadedSalesData = null;
                                let loadedProjectsData = null;
                                let formSubmitted = false;

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

                                // Use default terms checkbox handler
                                useDefaultTerms.addEventListener('change', function() {
                                    if (this.checked) {
                                        termsTextarea.value = defaultTerms;
                                    } else {
                                        termsTextarea.value = '';
                                    }
                                });

                                function showSalesSelection() {
                                    let html = `
                <div class="form-group">
                    <label class="form-label">Select Sale</label>
                    <select class="form-control" name="sale_id" id="sale_select">
                        <option value="">Select a Sale (Optional)</option>
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
                                                console.error('Error loading sales:', error);
                                                document.getElementById('sale_select').innerHTML =
                                                    '<option value="">Error loading sales</option>';
                                            });
                                    }
                                }

                                function populateSalesSelect(data) {
                                    const select = document.getElementById('sale_select');

                                    if (data.sales && data.sales.length > 0) {
                                        select.innerHTML = '<option value="">Select a Sale (Optional)</option>';

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
                    <label class="form-label">Select Project</label>
                    <select class="form-control" name="project_id" id="project_select">
                        <option value="">Select a Project (Optional)</option>
                    </select>
                </div>
            `;
                                    dynamicSelection.innerHTML = html;

                                    if (loadedProjectsData) {
                                        populateProjectsSelect(loadedProjectsData);
                                    } else {
                                        fetch(`${baseUrl}/get-projects`)
                                            .then(response => {
                                                if (!response.ok) {
                                                    console.error('Projects API error:', response.status);
                                                    throw new Error(`HTTP error! status: ${response.status}`);
                                                }
                                                return response.json();
                                            })
                                            .then(data => {
                                                console.log('Projects data loaded:', data);
                                                loadedProjectsData = data;
                                                populateProjectsSelect(data);
                                            })
                                            .catch(error => {
                                                console.error('Error loading projects:', error);
                                                document.getElementById('project_select').innerHTML =
                                                    '<option value="">Error loading projects - check console</option>';
                                            });
                                    }
                                }

                                function populateProjectsSelect(data) {
                                    const select = document.getElementById('project_select');
                                    console.log('Populating projects select with:', data);

                                    if (data.projects && data.projects.length > 0) {
                                        select.innerHTML = '<option value="">Select a Project (Optional)</option>';

                                        data.projects.forEach(project => {
                                            const clientName = project.client?.name || project.client_name || 'Unknown Client';
                                            select.innerHTML +=
                                                `<option value="${project.id}">${project.name} - ${clientName}</option>`;
                                        });

                                        select.addEventListener('change', function() {
                                            const projectId = this.value;
                                            if (projectId) {
                                                const project = data.projects.find(p => p.id == projectId);
                                                console.log('Selected project:', project);
                                                autoFillProjectData(project);
                                            } else {
                                                autoInfoSection.style.display = 'none';
                                                clearItems();
                                            }
                                        });
                                    } else {
                                        select.innerHTML = '<option value="">No projects found</option>';
                                        console.log('No projects data found');
                                    }
                                }

                                function autoFillSaleData(sale) {
                                    console.log('Auto-filling sale data:', sale);
                                    document.getElementById('selected_sale_id').value = sale.id;
                                    document.getElementById('selected_project_id').value = '';

                                    // Auto-fill client information if available
                                    if (sale.customer) {
                                        document.getElementById('client_name').value = sale.customer.name || '';
                                        document.getElementById('client_address').value = sale.customer.address || '';
                                    }

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
                                    console.log('Auto-filling project data:', project);
                                    document.getElementById('selected_project_id').value = project.id;
                                    document.getElementById('selected_sale_id').value = '';

                                    // Auto-fill client information if available
                                    if (project.client) {
                                        document.getElementById('client_name').value = project.client.name || '';
                                        document.getElementById('client_address').value = project.client.address || '';
                                    }

                                    document.getElementById('info-title').innerHTML = 'Project Information';
                                    document.getElementById('detail-reference').textContent = project.reference || project.name ||
                                        'N/A';
                                    document.getElementById('detail-date').textContent = project.date || 'N/A';

                                    // Use the budget amount from total_amount
                                    document.getElementById('detail-amount').textContent = parseFloat(project.total_amount || 0)
                                        .toFixed(2);
                                    document.getElementById('detail-due').textContent = parseFloat(project.due_payment || 0).toFixed(2);

                                    autoInfoSection.style.display = 'block';

                                    const items = project.items || [];
                                    populateItems(items, 'project');
                                }

                                function populateItems(items, type) {
                                    noItemsMessage.style.display = 'none'; // Hide the "no items" message
                                    itemsContainer.innerHTML = '';

                                    items.forEach((item, index) => {
                                        const totalPrice = parseFloat(item.total || (item.quantity * item.unit_price) || 0)
                                            .toFixed(2);
                                        const itemHtml = `
                    <div class="item-card card mb-3">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="form-label">Item Description *</label>
                                        <textarea class="form-control item-description" name="items[${index}][description]" rows="4" required readonly>${item.description || item.name || 'No description'}</textarea>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label class="form-label">Quantity *</label>
                                        <input type="number" class="form-control item-quantity" 
                                            name="items[${index}][quantity]" value="${item.quantity || 1}" min="1" required readonly>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label class="form-label">Unit</label>
                                        <input type="text" class="form-control" name="items[${index}][unit]" value="${item.unit || 'Piece'}" readonly>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label class="form-label">Unit Price *</label>
                                        <input type="number" class="form-control item-unit-price" 
                                            name="items[${index}][unit_price]" value="${item.unit_price || item.price || 0}" step="0.01" readonly>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label class="form-label">Total</label>
                                        <input type="text" class="form-control item-total" 
                                            value="${totalPrice}" readonly>
                                        <input type="hidden" name="items[${index}][total]" value="${totalPrice}">
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
                                    noItemsMessage.style.display = 'block'; // Show the "no items" message
                                    document.getElementById('items-count').textContent = '0 items';
                                    updateTotals([]);
                                }

                                function updateTotals(items) {
                                    const subtotal = items.reduce((sum, item) => sum + parseFloat(item.total || 0), 0);
                                    // document.getElementById('subtotal-display').textContent = subtotal.toFixed(2);
                                    // document.getElementById('total-display').textContent = subtotal.toFixed(2);
                                    document.getElementById('subtotal').value = subtotal;
                                    document.getElementById('total_amount').value = subtotal;
                                }

                                // Form submission handler
                                function handleFormSubmit(e) {
                                    e.preventDefault();
                                    e.stopImmediatePropagation();

                                    console.log('Form submit triggered');

                                    if (formSubmitted) {
                                        console.log('BLOCKED: Form already submitting');
                                        return false;
                                    }

                                    // Validate required fields
                                    const clientName = document.getElementById('client_name').value;
                                    const clientAddress = document.getElementById('client_address').value;
                                    const termsConditions = document.getElementById('terms_conditions').value;

                                    if (!clientName.trim()) {
                                        alert('Please enter client/company name');
                                        return false;
                                    }

                                    if (!clientAddress.trim()) {
                                        alert('Please enter client address');
                                        return false;
                                    }

                                    if (!termsConditions.trim()) {
                                        alert('Please enter terms and conditions');
                                        return false;
                                    }

                                    formSubmitted = true;

                                    const formData = new FormData(this);
                                    const submitBtn = this.querySelector('button[type="submit"]');

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

                                                    setTimeout(() => {
                                                        window.URL.revokeObjectURL(url);
                                                        document.body.removeChild(a);
                                                        alert('PDF generated and downloaded successfully!');
                                                        console.log('PDF download completed');
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
                                            formSubmitted = false;
                                        })
                                        .finally(() => {
                                            submitBtn.disabled = false;
                                            submitBtn.innerHTML = originalText;

                                            setTimeout(() => {
                                                formSubmitted = false;
                                                console.log('Form unlocked and ready for new submission');
                                            }, 5000);
                                        });

                                    return false;
                                }

                                billForm.removeEventListener('submit', handleFormSubmit);
                                billForm.addEventListener('submit', handleFormSubmit);

                                console.log('Form handler attached successfully');
                            });
                        </script> --}}
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
