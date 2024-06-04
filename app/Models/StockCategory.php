<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class StockCategory extends Model
{

    //fillables
    protected $fillable = [
        'company_id',
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
    ]; 

    use HasFactory;

    public function update_self()
    {
        $active_financial_period = Utils::getActiveFinancialPeriod($this->company_id);
        if ($active_financial_period == null) {
            return;
        }
        $total_buying_price = 0;
        $total_selling_price = 0;

        $stock_items = StockItem::where('stock_category_id', $this->id)
            ->where('financial_period_id', $active_financial_period->id)
            ->get();
        foreach ($stock_items as $key => $value) {
            $total_buying_price += ($value->buying_price * $value->original_quantity);
            $total_selling_price += ($value->selling_price * $value->original_quantity);
        }

        $total_expected_profit = $total_selling_price - $total_buying_price;


        $this->earned_profit = StockRecord::where('stock_category_id', $this->id)
            ->where('financial_period_id', $active_financial_period->id)
            ->sum('profit');


        $this->buying_price = $total_buying_price;
        $this->selling_price = $total_selling_price;
        $this->expected_profit = $total_expected_profit;
        $this->save();
    }


    protected $appends = ['name_text'];

    //name_text
    public function getNameTextAttribute()
    {
        return $this->name . " (" . $this->code . ")";
    }
    /* 
        "earned_profit" => 0
*/
}
