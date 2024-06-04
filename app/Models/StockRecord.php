<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class StockRecord extends Model
{
    use HasFactory;
    /*         
            $table->foreignIdFor(Company::class);
            $table->foreignIdFor(StockItem::class);
            $table->foreignIdFor(StockCategory::class);
            $table->foreignIdFor(StockSubCategory::class);
            $table->foreignIdFor(User::class, 'created_by_id');
            $table->string('sku')->nullable();
            $table->string('name')->nullable();
            $table->string('measurement_unit');
            $table->string('description')->nullable();
            $table->string('type');
            $table->float('quantity');
            $table->float('selling_price');
            $table->float('total_sales'); */
    //fillables for above
    protected $fillable = [
        'company_id',
        'stock_item_id',
        'stock_category_id',
        'stock_sub_category_id',
        'financial_period_id',
        'created_by_id',
        'sku',
        'name',
        'measurement_unit',
        'description',
        'type',
        'quantity',
        'selling_price',
        'total_sales',
        'profit',
        'date',
    ];


    protected static function boot()
    {
        parent::boot();

        static::creating(function ($model) {

            $stock_item = StockItem::find($model->stock_item_id);
            if ($stock_item == null) {
                throw new \Exception("Invalid Stock Item.");
            }

            $financial_period = Utils::getActiveFinancialPeriod($stock_item->company_id);

            if ($financial_period == null) {
                throw new \Exception("Invalid Financial Period");
            }
            $model->financial_period_id = $financial_period->id;


            $model->company_id = $stock_item->company_id;
            $model->stock_category_id = $stock_item->stock_category_id;
            $model->stock_sub_category_id = $stock_item->stock_sub_category_id;
            $model->sku = $stock_item->sku;
            $model->name = $stock_item->name;
            $model->measurement_unit = $stock_item->stockSubCategory->measurement_unit;
            if ($model->description == null) {
                $model->description = $stock_item->type;
            }
            $quantity = abs($model->quantity);
            if ($quantity < 1) {
                throw new \Exception("Invalid Quantity.");
            }
            $model->selling_price = $stock_item->selling_price;
            $model->total_sales = $model->selling_price * $quantity;
            $model->quantity = $quantity;

            if (
                $model->type == 'Sale'
            ) {
                $model->total_sales = abs($model->total_sales);
                $model->profit = $model->total_sales - ($stock_item->buying_price * $quantity);
            } else {
                $model->total_sales = 0;
                $model->profit = 0;
            }

            $current_quantity = $stock_item->current_quantity;
            if ($current_quantity < $quantity) {
                throw new \Exception("Insufficient Stock.");
            }

            $new_quantity = $current_quantity - $quantity;
            $stock_item->current_quantity = $new_quantity;
            $stock_item->save();

            return $model;
        });

        //created 
        static::created(function ($model) {

            $stock_item = StockItem::find($model->stock_item_id);
            if ($stock_item == null) {
                throw new \Exception("Invalid Stock Item.");
            }
            $stock_item->stockSubCategory->update_self();
            $stock_item->stockSubCategory->stockCategory->update_self();

            $company = Company::find($model->company_id);
            if ($company == null) {
                throw new \Exception("Invalid Company.");
            }

            if ($model->type == 'Sale') {
                $financial_category = FinancialCategory::where([
                    ['company_id', '=', $company->id],
                    ['name', '=', 'Sales']
                ])->first();
                if ($financial_category == null) {
                    Company::prepare_account_categories($company->id);
                    $financial_category = FinancialCategory::where([
                        ['company_id', '=', $company->id],
                        ['name', '=', 'Sales']
                    ])->first();
                    if ($financial_category == null) {
                        throw new \Exception("Sales Account Category not found.");
                    }
                }
                $fin_rec = new FinancialRecord();
                $fin_rec->financial_category_id = $financial_category->id;
                $fin_rec->company_id = $company->id;
                $fin_rec->user_id = $model->created_by_id;
                $fin_rec->created_by_id = $model->created_by_id;
                $fin_rec->amount = $model->total_sales;
                $fin_rec->quantity = $model->quantity;
                $fin_rec->type = 'Income';
                $fin_rec->payment_method = 'Cash';
                $fin_rec->recipient = '';
                $fin_rec->receipt = '';
                $fin_rec->date = $model->date;
                $fin_rec->description = 'Sales of #' . $model->id;
                $fin_rec->financial_period_id = $model->financial_period_id;
                $fin_rec->save();
            }
            //
        });
    }

    /* 
    									


    */
}
