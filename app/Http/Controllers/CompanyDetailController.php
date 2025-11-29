<?php

namespace App\Http\Controllers;

use App\Models\CompanyDetail;
use Illuminate\Http\Request;

class CompanyDetailController extends Controller
{
    public function index()
    {
        $companies = CompanyDetail::latest()->get();
        return view('frontend.pages.company-details.index', compact('companies'));
    }

    public function create()
    {
        return view('frontend.pages.company-details.create');
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'signatory_name' => 'required|string|max:255',
            'signatory_designation' => 'required|string|max:255',
            'phone' => 'nullable|string|max:255',
            'email' => 'nullable|email|max:255',
            'website' => 'nullable|string|max:255',
            'address' => 'nullable|string',
            'is_default' => 'sometimes|boolean',
            'is_active' => 'sometimes|boolean',
        ]);

        // If setting as default, remove default from others
        if ($request->is_default) {
            CompanyDetail::where('is_default', true)->update(['is_default' => false]);
        }

        CompanyDetail::create($request->all());

        return redirect()->route('company-details.index')
            ->with('success', 'Company details created successfully.');
    }

    public function edit(CompanyDetail $companyDetail)
    {
        return view('frontend.pages.company-details.edit', compact('companyDetail'));
    }

    public function update(Request $request, CompanyDetail $companyDetail)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'signatory_name' => 'required|string|max:255',
            'signatory_designation' => 'required|string|max:255',
            'phone' => 'nullable|string|max:255',
            'email' => 'nullable|email|max:255',
            'website' => 'nullable|string|max:255',
            'address' => 'nullable|string',
            'is_default' => 'sometimes|boolean',
            'is_active' => 'sometimes|boolean',
        ]);

        // If setting as default, remove default from others
        if ($request->is_default) {
            CompanyDetail::where('is_default', true)->where('id', '!=', $companyDetail->id)->update(['is_default' => false]);
        }

        $companyDetail->update($request->all());

        return redirect()->route('company-details.index')
            ->with('success', 'Company details updated successfully.');
    }

    public function destroy(CompanyDetail $companyDetail)
    {
        // Check if this company is used in any bills
        if ($companyDetail->bills()->exists()) {
            return redirect()->route('company-details.index')
                ->with('error', 'Cannot delete company details that are used in bills.');
        }

        // If deleting default, set another as default
        if ($companyDetail->is_default) {
            $newDefault = CompanyDetail::where('id', '!=', $companyDetail->id)->first();
            if ($newDefault) {
                $newDefault->update(['is_default' => true]);
            }
        }

        $companyDetail->delete();

        return redirect()->route('company-details.index')
            ->with('success', 'Company details deleted successfully.');
    }

    public function setDefault(CompanyDetail $companyDetail)
    {
        CompanyDetail::where('is_default', true)->update(['is_default' => false]);
        $companyDetail->update(['is_default' => true]);

        return redirect()->route('company-details.index')
            ->with('success', 'Default company details updated successfully.');
    }
}