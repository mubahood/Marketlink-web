<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BudgetProgram extends Model
{
    use HasFactory;

    //boot
    protected static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            //stop with same name and company_id is the same
            if (BudgetProgram::where('name', $model->name)->where('company_id', $model->company_id)->exists()) {
                throw new \Exception('Name already exists');
            }
            $model = self::prepare($model);
            return $model;
        });

        static::updating(function ($model) {
            //stop with same name but not the same id and company_id is the same
            if (BudgetProgram::where('name', $model->name)->where('id', '!=', $model->id)->where('company_id', $model->company_id)->exists()) {
                throw new \Exception('Name already exists');
            }
            $model = self::prepare($model);
            return $model;
        });
    }

    //public static function prepare
    public static function prepare($data)
    {
        $loggedUser = auth()->user();
        if ($loggedUser == null) {
            throw new \Exception('User not found');
        }
        $data->company_id = $loggedUser->company_id;
        return $data;
    }

    //belongs to company
    public function company()
    {
        return $this->belongsTo(Company::class);
    }

    //get categories
    public function categories()
    {
        return $this->hasMany(BudgetItemCategory::class);
    }
    public function get_categories(){
        $cats = BudgetItemCategory::where('budget_program_id', $this->id)
        ->orderBy('target_amount', 'desc')
        ->get();
        return $cats;
    }

    //getter for budget_spent
    public function getBudgetSpentAttribute($budget_spent)
    {
        $cats = BudgetItemCategory::where('budget_program_id', $this->id)
            ->get();
        $total = 0;
        foreach ($cats as $cat) {
            $total += $cat->invested_amount;
        }
        return $total;
    } 

    //getter for budget_total
    public function getBudgetTotalAttribute($budget_total)
    {
        $cats = BudgetItemCategory::where('budget_program_id', $this->id)
            ->get();
        $total = 0;
        foreach ($cats as $cat) {
            $total += $cat->target_amount;
        }
        return $total;
    } 

    //getter for budget_balance
    public function getBudgetBalanceAttribute($budget_balance)
    {
        $cats = BudgetItemCategory::where('budget_program_id', $this->id)
            ->get();
        $total = 0;
        foreach ($cats as $cat) {
            $total += $cat->balance;
        }
        return $total;
    } 
/* 


total_expected
total_in_pledge
budget_total

	
*/
    //update self
    public static function update_self(){
        
    }
    
}
