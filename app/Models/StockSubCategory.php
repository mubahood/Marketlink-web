<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class StockSubCategory extends Model
{
    use HasFactory;

    //fillables
    protected $fillable = [
        'company_id',
        'stock_category_id',
        'name',
        'description',
        'status',
        'image',
        'buying_price',
        'selling_price',
        'expected_profit',
        'earned_profit',
        'measurement_unit',
        'current_quantity',
        'reorder_level',
        'in_stock',
    ]; 
    


    //update_self
    public function update_self()
    {
        $active_financial_period = Utils::getActiveFinancialPeriod($this->company_id);
        if ($active_financial_period == null) {
            return;
        }
        $total_buying_price = 0;
        $total_selling_price = 0;
        $current_quantity = 0;

        $stock_items = StockItem::where('stock_sub_category_id', $this->id)
            ->where('financial_period_id', $active_financial_period->id)
            ->get();

        foreach ($stock_items as $key => $value) {
            $total_buying_price += ($value->buying_price * $value->original_quantity);
            $total_selling_price += ($value->selling_price * $value->original_quantity);
            $current_quantity += $value->current_quantity;
        }

        $total_expected_profit = $total_selling_price - $total_buying_price;

        $this->buying_price = $total_buying_price;
        $this->selling_price = $total_selling_price;
        $this->expected_profit = $total_expected_profit;
        $this->current_quantity = $current_quantity;

        //check if in_stock
        if ($current_quantity > $this->reorder_level) {
            $this->in_stock = 'Yes';
        } else {
            $this->in_stock = 'No';
        }

        //earned_profit
        $this->earned_profit = StockRecord::where('stock_sub_category_id', $this->id)
            ->where('financial_period_id', $active_financial_period->id)
            ->sum('profit');

        $this->save();
    }

    public function stockCategory()
    {
        return $this->belongsTo(StockCategory::class);
    }

    protected $appends = ['name_text'];

    //getter for name_text
    public function getNameTextAttribute()
    {
        $name_text = $this->name;
        if ($this->stockCategory != null) {
            $name_text =  $name_text . " - " . $this->stockCategory->name;
        }
        return $name_text;
    }
}
