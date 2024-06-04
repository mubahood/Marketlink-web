<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class BudgetItem extends Model
{
    use HasFactory;

    //boot
    protected static function boot()
    {
        parent::boot();

        //disable deleting
        static::deleting(function ($model) {
            //throw new \Exception('Deleting is not allowed');
        });

        static::creating(function ($model) {

            $model->name = trim($model->name);
            $withSameName  = BudgetItem::where([
                'name' => $model->name,
                'budget_item_category_id' => $model->budget_item_category_id,
            ])->first();

            if ($withSameName) {
                throw new \Exception('Name already exists');
            }


            $model = self::prepare($model);
            return $model;
        });

        static::updating(function ($model) {
            $model->name = trim($model->name);
            $withSameName  = BudgetItem::where([
                'name' => $model->name,
                'budget_item_category_id' => $model->budget_item_category_id,
            ])->where('id', '!=', $model->id)->first();
            if ($withSameName) {
                throw new \Exception('Name already exists');
            }

            $model = self::prepare($model);
            return $model;
        });

        //updated
        static::updated(function ($model) {
            self::finalizer($model);
        });

        //created
        static::created(function ($model) {
            self::finalizer($model);
        });
    }

    //public static function prepare
    public static function prepare($data)
    {
        $data->target_amount = $data->unit_price * $data->quantity;
        $loggedUser = User::find($data->created_by_id);
        if ($loggedUser == null) {
            throw new \Exception('User not found');
        }
        $data->company_id = $loggedUser->company_id;
        $data->changed_by_id = $loggedUser->id;
        $cat = BudgetItemCategory::find($data->budget_item_category_id);
        if ($cat == null) {
            throw new \Exception('Category not found');
        }
        return $data;
    }

    //public static function finalizer
    public static function finalizer($data)
    {
        $balance = $data->target_amount - $data->invested_amount;
        $is_complete = 'No';
        $percentage_done = 0;

        if ($data->target_amount == 0) {
            $percentage_done = 0;
        } else {
            $percentage_done = ($data->invested_amount / $data->target_amount) * 100;
        }

        if ($percentage_done >= 98) {
            $is_complete = 'Yes';
        } else {
            $is_complete = 'No';
        }
        $table = (new self())->getTable();
        $sql = "UPDATE $table SET 
        balance = $balance, 
        percentage_done = $percentage_done, 
        is_complete = '$is_complete' WHERE id = $data->id";
        DB::update($sql);
        $cat = BudgetItemCategory::find($data->budget_item_category_id);
        
        try {
            $cat->updateSelf();
        } catch (\Throwable $th) {
            //throw $th;
        }

        $budget_download_link = url('budget-program-print?id=' . $data->budget_program_id);
        $unit_price = number_format($data->unit_price);
        $quantity = number_format($data->quantity);
        $invested_amount = number_format($data->invested_amount);
        $balance = number_format($data->balance);
        $mail_body = <<<EOD
                    <p>Dear Admin,</p><br>
                    <p>Budget item <b>{$data->name} - {$data->category->name}</b> has been updated.</p>
                    <p><b>Quantity:</b> $unit_price</p>
                    <p><b>Unit price:</b> {$quantity}</p>
                    <p><b>Invested Amount:</b> {$invested_amount}</p>
                    <p><b>Percentage Done:</b> {$percentage_done}%</p>
                    <p><b>Balance:</b> {$balance}</p>
                    <p><b>Details:</b> {$cat->details}</p>
                    <p>Click <a href="{$budget_download_link}">here to DOWNLOAD UPDATED Budget</a> pdf.</p>
                    <br><p>Thank you.</p>
                EOD;
        $users = User::where([
            'company_id' => $data->company_id
        ])->get();
        $emails = [];
        foreach ($users as $key => $user) {
            if (filter_var($user->email, FILTER_VALIDATE_EMAIL)) {
                $emails[] = $user->email;
            }
            if (filter_var($user->username, FILTER_VALIDATE_EMAIL)) {
                if (in_array($user->username, $emails)) {
                    continue;
                }
                $emails[] = $user->username;
            }
        }
        if (!in_array('mubahood360@gmail.com', $emails)) {
            $emails[] = 'mubahood360@gmail.com';
        }
        $program = BudgetProgram::find($data->budget_program_id);
        $title = $program->name . " -  Budget Updates.";

        $data['email'] = $emails;
        $date = date('Y-m-d');
        $data['subject'] = $title;
        $data['body'] = $mail_body;
        $data['data'] = $data['body'];
        $data['name'] = 'Admin';

        try {
            Utils::mail_sender($data);
        } catch (\Throwable $th) {
        }
    }

    public function category()
    {
        return $this->belongsTo(BudgetItemCategory::class, 'budget_item_category_id');
    }
    //getter for budget_item_category_text
    public function getBudgetItemCategoryTextAttribute()
    {
        if ($this->category == null) {
            return 'N/A';
        }
        return $this->category->name;
    }

    //appends budget_item_category_text
    protected $appends = ['budget_item_category_text'];
}
