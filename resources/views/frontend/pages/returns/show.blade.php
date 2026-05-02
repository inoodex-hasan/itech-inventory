@extends('frontend.layouts.app')

@section('content')
    <div class="content container-fluid">
        <div class="page-header">
            <div class="content-page-header d-flex justify-content-between align-items-center">
                <h5 class="card-title fw-bold mb-0">Return Details #{{ $return->id }}</h5>
                <div>
                    <a href="{{ route('returns.index') }}" class="btn btn-outline-secondary btn-sm">
                        <i class="fas fa-arrow-left me-2"></i>Back to List
                    </a>
                </div>
            </div>
        </div>

        <!-- Status Banner -->
        @php
            $statusConfig = [
                'pending' => ['class' => 'warning', 'icon' => 'clock', 'msg' => 'This return is pending approval'],
                'approved' => ['class' => 'info', 'icon' => 'check', 'msg' => 'Return approved. Waiting for stock update.'],
                'completed' => ['class' => 'success', 'icon' => 'check-double', 'msg' => 'Return completed and stock updated.'],
                'rejected' => ['class' => 'danger', 'icon' => 'times', 'msg' => 'Return was rejected.']
            ][$return->status] ?? ['class' => 'secondary', 'icon' => 'question', 'msg' => 'Unknown status'];
        @endphp
        <div class="alert alert-{{ $statusConfig['class'] }} d-flex align-items-center mb-4">
            <i class="fas fa-{{ $statusConfig['icon'] }} me-3 fa-lg"></i>
            <div>
                <strong>Status: {{ ucfirst($return->status) }}</strong><br>
                <small>{{ $statusConfig['msg'] }}</small>
            </div>
        </div>

        <div class="row">
            <!-- Return Info -->
            <div class="col-md-6">
                <div class="card mb-4">
                    <div class="card-header">
                        <h6 class="mb-0">Return Information</h6>
                    </div>
                    <div class="card-body">
                        <table class="table table-borderless">
                            <tr>
                                <td class="fw-bold" style="width: 40%">Return ID:</td>
                                <td>#{{ $return->id }}</td>
                            </tr>
                            <tr>
                                <td class="fw-bold">Return Date:</td>
                                <td>{{ $return->return_date->format('d M Y') }}</td>
                            </tr>
                            <tr>
                                <td class="fw-bold">Created At:</td>
                                <td>{{ $return->created_at->format('d M Y H:i') }}</td>
                            </tr>
                            <tr>
                                <td class="fw-bold">Total Refund:</td>
                                <td class="text-primary fw-bold">{{ number_format($return->total_refund_amount, 2) }}</td>
                            </tr>
                            @if($return->reason)
                                <tr>
                                    <td class="fw-bold">Reason:</td>
                                    <td>{{ $return->reason }}</td>
                                </tr>
                            @endif
                            @if($return->notes)
                                <tr>
                                    <td class="fw-bold">Notes:</td>
                                    <td>{{ $return->notes }}</td>
                                </tr>
                            @endif
                        </table>
                    </div>
                </div>
            </div>

            <!-- Sale & Customer Info -->
            <div class="col-md-6">
                <div class="card mb-4">
                    <div class="card-header">
                        <h6 class="mb-0">Sale & Customer Information</h6>
                    </div>
                    <div class="card-body">
                        <table class="table table-borderless">
                            <tr>
                                <td class="fw-bold" style="width: 40%">Order No:</td>
                                <td>
                                    @if($return->sale)
                                        <a href="{{ route('sales.show', $return->sale_id) }}">
                                            #{{ $return->sale->order_no }}
                                        </a>
                                    @else
                                        <span class="text-muted">N/A</span>
                                    @endif
                                </td>
                            </tr>
                            <tr>
                                <td class="fw-bold">Customer:</td>
                                <td>{{ $return->customer->name ?? 'N/A' }}</td>
                            </tr>
                            @if($return->customer && $return->customer->phone)
                                <tr>
                                    <td class="fw-bold">Phone:</td>
                                    <td>{{ $return->customer->phone }}</td>
                                </tr>
                            @endif
                            @if($return->processedBy)
                                <tr>
                                    <td class="fw-bold">Processed By:</td>
                                    <td>{{ $return->processedBy->name }}</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">Processed At:</td>
                                    <td>{{ $return->processed_at?->format('d M Y H:i') }}</td>
                                </tr>
                            @endif
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Return Items -->
        <div class="card">
            <div class="card-header">
                <h6 class="mb-0">Returned Items</h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>#</th>
                                <th>Product</th>
                                <th>Quantity</th>
                                <th>Unit Price</th>
                                <th>Total</th>
                                <th>Reason</th>
                                <th>Condition</th>
                                <th>Notes</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($return->items as $item)
                                <tr>
                                    <td>{{ $loop->iteration }}</td>
                                    <td>{{ $item->product->name ?? 'N/A' }}</td>
                                    <td>{{ $item->quantity }}</td>
                                    <td>{{ number_format($item->unit_price, 2) }}</td>
                                    <td>{{ number_format($item->total_price, 2) }}</td>
                                    <td>
                                        <span class="badge bg-secondary">
                                            {{ $item->reason_label }}
                                        </span>
                                    </td>
                                    <td>
                                        @php
                                            $conditionColors = [
                                                'good' => 'success',
                                                'damaged' => 'warning',
                                                'defective' => 'danger'
                                            ];
                                        @endphp
                                        <span class="badge bg-{{ $conditionColors[$item->condition] ?? 'secondary' }}">
                                            {{ $item->condition_label }}
                                        </span>
                                    </td>
                                    <td>{{ $item->notes ?? '-' }}</td>
                                </tr>
                            @endforeach
                        </tbody>
                        <tfoot class="table-light">
                            <tr>
                                <td colspan="4" class="text-end fw-bold">Total Refund:</td>
                                <td colspan="4" class="fw-bold text-primary">{{ number_format($return->total_refund_amount, 2) }}</td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>

        <!-- Action Buttons -->
        @if($return->isPending() || $return->isApproved())
            <div class="card mt-4">
                <div class="card-body">
                    <h6 class="mb-3">Actions</h6>
                    <div class="d-flex gap-2">
                        @if($return->isPending())
                            <form method="POST" action="{{ route('returns.approve', $return->id) }}" class="d-inline">
                                @csrf
                                @method('PATCH')
                                <button type="submit" class="btn btn-success" onclick="return confirm('Approve this return?')">
                                    <i class="fas fa-check me-2"></i>Approve Return
                                </button>
                            </form>
                            <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#rejectModal">
                                <i class="fas fa-times me-2"></i>Reject Return
                            </button>
                        @endif

                        @if($return->isApproved())
                            <form method="POST" action="{{ route('returns.complete', $return->id) }}" class="d-inline">
                                @csrf
                                @method('PATCH')
                                <button type="submit" class="btn btn-primary" onclick="return confirm('Complete return and update stock?')">
                                    <i class="fas fa-box me-2"></i>Complete & Update Stock
                                </button>
                            </form>
                        @endif
                    </div>
                </div>
            </div>

            <!-- Reject Modal -->
            @if($return->isPending())
                <div class="modal fade" id="rejectModal" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form method="POST" action="{{ route('returns.reject', $return->id) }}">
                                @csrf
                                @method('PATCH')
                                <div class="modal-header">
                                    <h5 class="modal-title">Reject Return #{{ $return->id }}</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body">
                                    <div class="mb-3">
                                        <label class="form-label">Rejection Reason <span class="text-danger">*</span></label>
                                        <textarea name="reason" class="form-control" rows="3"
                                            placeholder="Enter reason for rejection" required></textarea>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                    <button type="submit" class="btn btn-danger">Reject Return</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            @endif
        @endif
    </div>
@endsection
