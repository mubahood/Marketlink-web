<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class BudgetItemCategory extends Model
{
    use HasFactory;



    //update self
    public function updateSelf()
    {
        $target_amount = BudgetItem::where('budget_item_category_id', $this->id)->sum('target_amount');
        $invested_amount = BudgetItem::where('budget_item_category_id', $this->id)->sum('invested_amount');
        $table = (new BudgetItemCategory())->getTable();
        $balance = $target_amount - $invested_amount;
        $percentage_done = 0;
        if ($target_amount > 0) {
            $percentage_done = round(($invested_amount / $target_amount) * 100, 2);
        }
        $sql = "UPDATE {$table} SET target_amount = $target_amount, 
        balance = $balance, 
        percentage_done = $percentage_done, 
        invested_amount = $invested_amount WHERE id = $this->id";
        DB::update($sql);
    }

    //getter for percentage_done
    public function getPercentageDoneAttribute($percentage_done)
    {

        if ($percentage_done > 100) {
            return 100;
        }
        if ($percentage_done > 1) {
            return round($percentage_done, 2);
        }
        if ($this->target_amount == 0) {
            return 0;
        }
        $x = round(($this->invested_amount / $this->target_amount) * 100, 2);
        //save
        $this->percentage_done = $x;
        $this->save();
        return $x;
    }

    public function get_items()
    {
        $cats = BudgetItem::where('budget_item_category_id', $this->id)
            ->orderBy('target_amount', 'desc')
            ->get();
        return $cats;
    }
}
