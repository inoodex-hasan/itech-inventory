@extends('layouts.app')

@section('title', 'Quotations')

@section('content')
    <div class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="page-title-box">
                        <h4 class="page-title">Quotations</h4>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="row mb-2">
                                <div class="col-sm-12 text-end">
                                    <a href="{{ route('quotations.create') }}" class="btn btn-primary">
                                        <i class="fas fa-plus"></i> Create Quotation
                                    </a>
                                </div>
                            </div>

                            <div class="table-fluid">
                                <table class="table table-centered table-striped dt-responsive nowrap w-100"
                                    id="quotations-datatable">
                                    <thead>
                                        <tr>
                                            <th>Quotation No.</th>
                                            <th>Client</th>
                                            <th>Date</th>
                                            <th>Expiry Date</th>
                                            <th>Total Amount</th>
                                            {{-- <th>Status</th> --}}
                                            <th style="width: 125px;">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @foreach ($quotations as $quotation)
                                            <tr>
                                                <td>
                                                    <a href="{{ route('quotations.show', $quotation->id) }}"
                                                        class="text-body fw-bold">
                                                        {{ $quotation->quotation_number }}
                                                    </a>
                                                </td>
                                                <td>{{ $quotation->client?->name ?? 'No Client' }}</td>
                                                <td>{{ $quotation->quotation_date->format('M d, Y') }}</td>
                                                <td>{{ $quotation->expiry_date->format('M d, Y') }}</td>
                                                <td>{{ number_format($quotation->total_amount, 2) }}</td>
                                                {{-- <td>
                                                    @if ($quotation->status == 'draft')
                                                        <span class="badge bg-warning">Draft</span>
                                                    @elseif($quotation->status == 'sent')
                                                        <span class="badge bg-info">Sent</span>
                                                    @elseif($quotation->status == 'accepted')
                                                        <span class="badge bg-success">Accepted</span>
                                                    @elseif($quotation->status == 'rejected')
                                                        <span class="badge bg-danger">Rejected</span>
                                                    @else
                                                        <span class="badge bg-secondary">Expired</span>
                                                    @endif
                                                </td> --}}
                                                <td class="d-flex align-items-center">
                                                    <div class="dropdown dropdown-action">
                                                        <a href="#" class="btn-action-icon" data-bs-toggle="dropdown">
                                                            <i class="fas fa-ellipsis-v"></i>
                                                        </a>
                                                        <div class="dropdown-menu dropdown-menu-end">
                                                            <ul>
                                                                <li>
                                                                    {{-- <a class="dropdown-item"
                                                                        href="{{ route('quotations.show', $quotation->id) }}">
                                                                        <i class="far fa-eye me-2"></i>Preview
                                                                    </a> --}}

                                                                </li>

                                                                <a class="dropdown-item"
                                                                    href="{{ route('quotations.pdf', $quotation->id) }}">
                                                                    <i class="fas fa-download me-2"></i>Download PDF
                                                                </a>

                                                                </li>
                                                                <li>
                                                                    <a onclick="if (confirm('Are you sure to delete?')) { document.getElementById('serviceDelete{{ $quotation->id }}').submit(); }"
                                                                        class="dropdown-item" href="javascript:void(0)">
                                                                        <i class="far fa-trash-alt me-2"></i>Delete
                                                                    </a>
                                                                    <form id="serviceDelete{{ $quotation->id }}"
                                                                        action="{{ route('quotations.destroy', $quotation->id) }}"
                                                                        method="POST" style="display:none;">
                                                                        @csrf
                                                                        @method('DELETE')
                                                                    </form>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        @endforeach
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

@push('scripts')
    <script>
        $(document).ready(function() {
            $('#quotations-datatable').DataTable({
                order: [
                    [0, 'desc']
                ],
                language: {
                    paginate: {
                        previous: "<i class='mdi mdi-chevron-left'>",
                        next: "<i class='mdi mdi-chevron-right'>"
                    }
                },
                drawCallback: function() {
                    $('.dataTables_paginate > .pagination').addClass('pagination-rounded');
                }
            });
        });
    </script>
@endpush
