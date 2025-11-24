@extends('layouts.app')

@section('content')
    <div class="container-fluid">
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <div class="d-flex justify-content-between align-items-center">
                            <h4 class="mb-0">Create New Challan</h4>
                            <div>
                                <a href="{{ route('challans.index') }}" class="btn btn-secondary">Back</a>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <form id="challanForm" action="{{ route('challans.store') }}" method="POST">
                            @csrf

                            <!-- Client Information -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <h5 class="border-bottom pb-2 mb-3 text-primary">Recipient Information</h5>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Organization Name *</label>
                                        <input type="text" class="form-control" name="recipient_organization" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Designation</label>
                                        <input type="text" class="form-control" name="recipient_designation"
                                            value="The Managing Director">
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="form-group">
                                        <label class="form-label">Address *</label>
                                        <textarea class="form-control" name="recipient_address" rows="3" required></textarea>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="form-group">
                                        <label class="form-label">Attention To</label>
                                        <input type="text" class="form-control" name="attention_to">
                                    </div>
                                </div>
                            </div>

                            <!-- Challan Information -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <h5 class="border-bottom pb-2 mb-3">Challan Information</h5>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Challan Type *</label>
                                        <select class="form-control" name="type" id="challan_type" required>
                                            <option value="">Select Type</option>
                                            <option value="sale">Sales Challan</option>
                                            <option value="project">Project Challan</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6" id="dynamic-selection">
                                    <!-- Dynamic content -->
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="form-label">Reference Number *</label>
                                        <input type="text" class="form-control" name="reference_number"
                                            value="IT-CHALLAN-{{ date('dmY-His') }}" required>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="form-label">Challan Date *</label>
                                        <input type="date" class="form-control" name="challan_date"
                                            value="{{ date('Y-m-d') }}" required>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="form-label">Subject *</label>
                                        <input type="text" class="form-control" name="subject"
                                            value="CHALLAN FOR PLASTIC ID CARD PRINTING ACCESSORIES" required>
                                    </div>
                                </div>
                            </div>

                            <!-- Challan Items -->
                            {{-- <div class="row mb-4">
                                <div class="col-12">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <h5 class="mb-0">Challan Items</h5>
                                        <button type="button" class="btn btn-sm btn-outline-primary" id="add-item">
                                            <i class="fas fa-plus"></i> Add Item
                                        </button>
                                    </div>
                                    <div id="items-container">
                                        <div class="text-center p-4" id="no-items-message">
                                            <i class="fas fa-boxes fa-2x text-muted mb-2"></i>
                                            <p class="text-muted">Add items for the challan</p>
                                        </div>
                                    </div>
                                </div>
                            </div> --}}

                            <!-- Company Details -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <h5 class="border-bottom pb-2 mb-3">Company Details</h5>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Company Name *</label>
                                        <input type="text" class="form-control" name="company_name"
                                            value="Intelligent Technology" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Signatory Name *</label>
                                        <input type="text" class="form-control" name="signatory_name"
                                            value="Engr. Shamsul Alam" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Signatory Designation *</label>
                                        <input type="text" class="form-control" name="signatory_designation"
                                            value="Director (Technical)" required>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="form-group">
                                        <label class="form-label">Notes</label>
                                        <textarea class="form-control" name="notes" rows="3" placeholder="Additional notes...">We assure you that we provide our best service at all times. Thank you once again.</textarea>
                                    </div>
                                </div>
                            </div>

                            <!-- Submit -->
                            <div class="row">
                                <div class="col-12">
                                    <div class="d-flex justify-content-end">
                                        <button type="submit" class="btn btn-success btn-lg">
                                            Generate Challan
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <input type="hidden" name="selected_sale_id" id="selected_sale_id">
                            <input type="hidden" name="selected_project_id" id="selected_project_id">
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const challanTypeSelect = document.getElementById('challan_type');
            const dynamicSelection = document.getElementById('dynamic-selection');
            const selectedSaleId = document.getElementById('selected_sale_id');
            const selectedProjectId = document.getElementById('selected_project_id');
            const itemsContainer = document.getElementById('items-container');
            const noItemsMessage = document.getElementById('no-items-message');
            const addItemBtn = document.getElementById('add-item');

            const baseUrl = window.location.origin;
            let itemCount = 0;

            // Initialize with one item
            addManualItem();

            // Challan type change handler
            challanTypeSelect.addEventListener('change', function() {
                const type = this.value;
                dynamicSelection.innerHTML = '';
                selectedSaleId.value = '';
                selectedProjectId.value = '';

                if (type === 'sale') {
                    showSalesSelection();
                } else if (type === 'project') {
                    showProjectsSelection();
                }
            });

            // Add item button handler
            addItemBtn.addEventListener('click', function() {
                addManualItem();
            });

            function showSalesSelection() {
                let html = `
            <div class="form-group">
                <label class="form-label">Select Sale *</label>
                <select class="form-control" name="sale_select" id="sale_select" required>
                    <option value="">Loading sales...</option>
                </select>
            </div>
        `;
                dynamicSelection.innerHTML = html;

                fetch(`${baseUrl}/get-sales-challan`)
                    .then(response => {
                        if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
                        return response.json();
                    })
                    .then(data => {
                        const select = document.getElementById('sale_select');
                        if (data.sales && data.sales.length > 0) {
                            select.innerHTML = '<option value="">Select a Sale</option>';
                            data.sales.forEach(sale => {
                                const customerName = sale.customer?.name || 'Unknown Customer';
                                select.innerHTML +=
                                    `<option value="${sale.id}">${sale.order_no} - ${customerName}</option>`;
                            });

                            select.addEventListener('change', function() {
                                selectedSaleId.value = this.value;
                            });
                        } else {
                            select.innerHTML = '<option value="">No sales found</option>';
                        }
                    })
                    .catch(error => {
                        console.error('Error loading sales:', error);
                        document.getElementById('sale_select').innerHTML =
                            '<option value="">Error loading sales</option>';
                    });
            }

            function showProjectsSelection() {
                let html = `
            <div class="form-group">
                <label class="form-label">Select Project *</label>
                <select class="form-control" name="project_select" id="project_select" required>
                    <option value="">Loading projects...</option>
                </select>
            </div>
        `;
                dynamicSelection.innerHTML = html;

                fetch(`${baseUrl}/get-projects-challan`)
                    .then(response => {
                        if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
                        return response.json();
                    })
                    .then(data => {
                        const select = document.getElementById('project_select');
                        if (data.projects && data.projects.length > 0) {
                            select.innerHTML = '<option value="">Select a Project</option>';
                            data.projects.forEach(project => {
                                const clientName = project.client?.name || 'Unknown Client';
                                select.innerHTML +=
                                    `<option value="${project.id}">${project.name} - ${clientName}</option>`;
                            });

                            select.addEventListener('change', function() {
                                selectedProjectId.value = this.value;
                            });
                        } else {
                            select.innerHTML = '<option value="">No projects found</option>';
                        }
                    })
                    .catch(error => {
                        console.error('Error loading projects:', error);
                        document.getElementById('project_select').innerHTML =
                            '<option value="">Error loading projects</option>';
                    });
            }

            function addManualItem() {
                noItemsMessage.style.display = 'none';
                const itemId = itemCount++;

                const itemHtml = `
            <div class="item-card card mb-3" data-item-id="${itemId}">
                <div class="card-header bg-light d-flex justify-content-between align-items-center">
                    <h6 class="mb-0">Item ${itemId + 1}</h6>
                    <button type="button" class="btn btn-sm btn-danger remove-item" data-item-id="${itemId}">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-8">
                            <div class="form-group">
                                <label class="form-label">Item Description *</label>
                                <textarea class="form-control item-description" name="items[${itemId}][description]" rows="3" required placeholder="Enter item description"></textarea>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label class="form-label">Quantity *</label>
                                <input type="number" class="form-control item-quantity" name="items[${itemId}][quantity]" value="1" min="1" required>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label class="form-label">Unit</label>
                                <input type="text" class="form-control" name="items[${itemId}][unit]" value="Piece" placeholder="e.g., Piece, Set">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        `;

                itemsContainer.insertAdjacentHTML('beforeend', itemHtml);

                // Add remove functionality
                const newItem = itemsContainer.querySelector(`[data-item-id="${itemId}"]`);
                const removeBtn = newItem.querySelector('.remove-item');

                removeBtn.addEventListener('click', function() {
                    if (document.querySelectorAll('.item-card').length > 1) {
                        newItem.remove();
                        itemCount--;
                    } else {
                        alert('At least one item is required');
                    }
                });
            }

            // Form validation
            document.getElementById('challanForm').addEventListener('submit', function(e) {
                const type = challanTypeSelect.value;
                const saleId = selectedSaleId.value;
                const projectId = selectedProjectId.value;

                if (type === 'sale' && !saleId) {
                    e.preventDefault();
                    alert('Please select a sale');
                    return false;
                }

                if (type === 'project' && !projectId) {
                    e.preventDefault();
                    alert('Please select a project');
                    return false;
                }

                // Validate at least one item
                const items = document.querySelectorAll('.item-card');
                if (items.length === 0) {
                    e.preventDefault();
                    alert('Please add at least one item');
                    return false;
                }
            });
        });
    </script>
@endsection
