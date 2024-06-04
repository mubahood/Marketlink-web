<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Company extends Model
{
    use HasFactory;

    //boot
    protected static function boot()
    {
        parent::boot();

        //creatd
        static::updated(function ($company) {
            $owner = User::find($company->owner_id);
            if ($owner == null) {
                throw new \Exception("Owner not found");
            }
            $owner->company_id = $company->id;
            $owner->save();
        });

        static::created(function ($company) {
            $owner = User::find($company->owner_id);
            if ($owner == null) {
                throw new \Exception("Owner not found");
            }
            $owner->company_id = $company->id;
            $owner->save();

            //prepare
            self::prepare_account_categories($company->id);
        });
    }



    static public function prepare_account_categories($company_id)
    {
        $company = Company::find($company_id);
        if ($company == null) {
            throw new \Exception("Company not found");
        }
        $sales_account_category = FinancialCategory::where([
            ['company_id', '=', $company_id],
            ['name', '=', 'Sales']
        ])->first();
        if ($sales_account_category == null) {
            $sales_account_category = new FinancialCategory();
            $sales_account_category->company_id = $company_id;
            $sales_account_category->name = 'Sales';
            $sales_account_category->save();
        }

        $purchase_account_category = FinancialCategory::where([
            ['company_id', '=', $company_id],
            ['name', '=', 'Purchase']
        ])->first();
        if ($purchase_account_category == null) {
            $purchase_account_category = new FinancialCategory();
            $purchase_account_category->company_id = $company_id;
            $purchase_account_category->name = 'Purchase';
            $purchase_account_category->save();
        }

        $expense_account_category = FinancialCategory::where([
            ['company_id', '=', $company_id],
            ['name', '=', 'Expense']
        ])->first();

        if ($expense_account_category == null) {
            $expense_account_category = new FinancialCategory();
            $expense_account_category->company_id = $company_id;
            $expense_account_category->name = 'Expense';
            $expense_account_category->save();
        }
    }
}
