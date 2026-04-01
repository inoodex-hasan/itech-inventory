@extends('frontend.layouts.app')
@section('content')

    <div class="content container-fluid">
        <!-- Page Header -->
        <div class="page-header">
            <div class="content-page-header d-flex justify-content-between align-items-start flex-wrap">
                <div>
                    <h5 class="mb-1">Service Payments</h5>
                    <p class="text-muted">Manage payment records and generate reports for service transactions.</p>
                </div>
            </div>
        </div>

        {{-- <div class="row g-3 mb-3">
            <div class="col-md-3 col-6">
                <div class="card shadow-sm">
                    <div class="card-body p-3">
                        <h6 class="mb-2">Total Received</h6>
                        <h3 class="mb-0">
                            {{ number_format($payments->sum('amount') ?? 0, 2) }}
                        </h3>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="card shadow-sm">
                    <div class="card-body p-3">
                        <h6 class="mb-2">Transactions</h6>
                        <h3 class="mb-0">{{ $payments->count() }}</h3>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="card shadow-sm">
                    <div class="card-body p-3">
                        <h6 class="mb-2">From</h6>
                        <p class="mb-0">{{ $request->from ?? now()->startOfMonth()->format('Y-m-d') }}</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="card shadow-sm">
                    <div class="card-body p-3">
                        <h6 class="mb-2">To</h6>
                        <p class="mb-0">{{ $request->to ?? now()->endOfMonth()->format('Y-m-d') }}</p>
                    </div>
                </div>
            </div>
        </div> --}}

        <div class="card mb-3 shadow-sm">
            <div class="card-body">
                <form action="{{ route('service.payments') }}" method="get" class="row g-2 align-items-end">
                    <div class="col-sm-12 col-md-3">
                        <label class="form-label">From</label>
                        <input type="date" name="from" class="form-control" value="{{ $request->from ?? '' }}">
                    </div>
                    <div class="col-sm-12 col-md-3">
                        <label class="form-label">To</label>
                        <input type="date" name="to" class="form-control" value="{{ $request->to ?? '' }}">
                    </div>
                    <div class="col-sm-12 col-md-3">
                        <label class="form-label">Payment Method</label>
                        <select name="payments_method" class="form-select">
                            <option value="">All methods</option>
                            @foreach (paymentMethods() as $key => $value)
                                <option value="{{ $key }}"
                                    {{ ($request->payments_method ?? '') == $key ? 'selected' : '' }}>{{ $value }}
                                </option>
                            @endforeach
                        </select>
                    </div>
                    @if (isset($service))
                        <input type="hidden" name="id" value="{{ $service->id }}" />
                    @endif
                    <div class="col-sm-12 col-md-3 d-flex gap-2">
                        <button type="submit" name="search_for" value="filter" class="btn btn-primary w-100">Apply</button>
                        {{-- <button type="submit" name="search_for" value="pdf" class="btn btn-outline-secondary w-100"><i
                                class="fe fe-download"></i> Export</button> --}}
                    </div>
                </form>
            </div>
        </div>

        @if (isset($service))
            <div class="card mb-3">
                <div class="card-body">
                    {{-- <h5 class="mb-3">Take Due Payment for Service #{{ $service->name }}</h5> --}}
                    <div class="row mb-3">
                        <div class="col-md-3">
                            <strong>Customer</strong><br>
                            {{ $service->name }}
                        </div>
                        <div class="col-md-3">
                            <strong>Due Amount</strong><br>
                            <span class="badge bg-danger"
                                style="font-size: 1rem; padding: 0.65rem 0.9rem;">{{ number_format($service->due_amount, 2) }}</span>
                        </div>
                        <div class="col-md-3">
                            <strong>Paid</strong><br>
                            <span class="badge bg-primary"
                                style="font-size: 1rem; padding: 0.65rem 0.9rem;">{{ number_format($service->paid_amount, 2) }}</span>
                        </div>
                        <div class="col-md-3">
                            <strong>Total</strong><br>
                            <span class="badge bg-success"
                                style="font-size: 1rem; padding: 0.65rem 0.9rem;">{{ number_format($service->bill, 2) }}</span>
                        </div>
                    </div>
                    @if ($service->due_amount > 0)
                        <form method="POST" action="{{ route('add.payment') }}" class="row g-2 align-items-end">
                            @csrf
                            <input type="hidden" name="id" value="{{ $service->id }}" />
                            <input type="hidden" name="payment_for" value="1" />
                            <div class="col-md-4">
                                <label class="form-label">Payment Method</label>
                                <select name="payment_method_id" class="form-select" required>
                                    <option value="">Select Method</option>
                                    @foreach (paymentMethods() as $key => $value)
                                        <option value="{{ $key }}">{{ $value }}</option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Amount</label>
                                <input type="number" name="amount" step="0.01" min="0.01"
                                    max="{{ max(0, $service->due_amount) }}" class="form-control" required>
                            </div>
                            <div class="col-md-4">
                                <button type="submit" class="btn btn-success w-100">Submit Payment</button>
                            </div>
                        </form>
                    @else
                        <div class="alert alert-success" role="alert">
                            <strong>Fully Paid</strong> — no further payments needed.
                        </div>
                    @endif
                </div>
            </div>
        @endif

        <div class="row">
            <div class="col-sm-12">
                <div class="card-table">
                    <div class="card-body">
                        <div>
                            <div>
                                <table class="table table-center table-hover ">
                                    <thead class="thead-light">
                                        <tr role="row">
                                            <th>#</th>
                                            <th>Date</th>
                                            <th>Payment Method</th>
                                            <th>Amount</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        @foreach ($payments as $payment)
                                            <tr role="row">
                                                <td>{{ $loop->index + 1 }}</td>
                                                <td>{{ $payment->created_at->format('Y-m-d') }}</td>
                                                <td>{{ getArrayData(paymentMethods(), $payment->payment_method) }}</td>
                                                <td>{{ $payment->amount }}</td>
                                            </tr>
                                            @php
                                                if (!isset($methodWise[$payment->payment_method])) {
                                                    $methodWise[$payment->payment_method] = 0;
                                                }
                                                $methodWise[$payment->payment_method] += $payment->amount;
                                                if (!isset($total)) {
                                                    $total = 0;
                                                }
                                                $total += $payment->amount;
                                            @endphp
                                        @endforeach

                                        @if (isset($methodWise))
                                            @foreach ($methodWise as $key => $value)
                                                <tr>
                                                    <th colspan="3" style="text-align:right;">
                                                        {{ getArrayData(paymentMethods(), $key) }}</th>
                                                    <th>{{ $value }}</th>
                                                </tr>
                                            @endforeach
                                            <tr>
                                                <th colspan="3" style="text-align:right;">Total</th>
                                                <th>{{ $total }}</th>
                                            </tr>
                                        @endif

                                    </tbody>
                                </table>



                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

@endsection
