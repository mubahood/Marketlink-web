<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class FinancialRecord extends Model
{
    use HasFactory;
 
    protected $fillable = [
        'financial_category_id',
        'company_id',
        'user_id',
        'amount',
        'quantity',
        'type',
        'payment_method',
        'recipient',
        'description',
        'receipt',
        'date',
        'financial_period_id',
        'created_by_id',
    ];

    //boot
    protected static function boot()
    {
        parent::boot();

        //creating
        static::creating(function ($model) {
            $user = User::find($model->created_by_id);
            if ($user == null) {
                throw new \Exception("Invalid User");
            }
            $financial_period = Utils::getActiveFinancialPeriod($user->company_id);

            if ($financial_period == null) {
                throw new \Exception("Financial Period is not active. Please activate the financial period.");
            }
            $model->financial_period_id = $financial_period->id;
            $model->company_id = $user->company_id;
        });

        static::deleting(function ($model) {
            $model->financial_category()->dissociate();
            $model->save();
        });
    }

    //appends
    protected $appends = ['financial_category_text'];


    //getter for financial_category_text
    public function getFinancialCategoryTextAttribute()
    {
        if ($this->financial_category) {
            return $this->financial_category->name;
        }
        return 'N/A';
    }

    //belongs financial_category
    public function financial_category()
    {
        return $this->belongsTo(FinancialCategory::class);
    }
}
