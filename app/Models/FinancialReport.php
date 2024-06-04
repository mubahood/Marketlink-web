<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\DB;

class FinancialReport extends Model
{
    use HasFactory;
    //boot
    protected static function boot()
    {
        parent::boot();
        //creating
        static::creating(function ($model) {
            $model = self::prepare($model);
        });
        //updating
        static::updating(function ($model) {
            if ($model->do_generate == 'Yes') {
                $model = self::prepare($model);
                $model->do_generate = 'No';
            }
            return $model;
        });
    }
    //get_inventory_categories
    public function get_inventory_categories()
    {
        $cats = [];
        foreach (StockCategory::where('company_id', $this->company_id)->get() as $cat) {
            $cat->total_sales = StockRecord::where('company_id', $this->company_id)
                ->where('type', 'Sale')
                ->where('stock_category_id', $cat->id)
                ->whereBetween('created_at', [$this->start_date, $this->end_date])
                ->sum('total_sales');
            $cat->profit = StockRecord::where('company_id', $this->company_id)
                ->where('stock_category_id', $cat->id)
                ->whereBetween('created_at', [$this->start_date, $this->end_date])
                ->sum('profit');

            $total_buying_price = StockItem::where('company_id', $this->company_id)
                ->where('stock_category_id', $cat->id)
                ->whereBetween('created_at', [$this->start_date, $this->end_date])
                ->sum('buying_price');
            $total_quantity = StockItem::where('company_id', $this->company_id)
                ->where('stock_category_id', $cat->id)
                ->whereBetween('created_at', [$this->start_date, $this->end_date])
                ->sum('original_quantity');
            $total_inventory = $total_buying_price * $total_quantity;
            $cat->total_inventory = $total_inventory;
            $cat->total_buying_price = $total_buying_price;
            $cat->total_quantity = $total_quantity;
            $cats[] = $cat;
        }
        return $cats;
    }


    //static prepare
    static public function prepare($model)
    {
        $user = User::find($model->user_id);
        if ($user == null) {
            throw new \Exception("Invalid User");
        }
        $company = Company::find($user->company_id);
        if ($company == null) {
            throw new \Exception("Invalid Company");
        }
        $start_date = null;
        $end_date = null;
        $now = Carbon::parse($model->created_at);

        switch ($model->period_type) {
            case 'Today':
                $start_date = $now->copy()->startOfDay();
                $end_date = $now->copy()->endOfDay();
                break;
            case 'Yesterday':
                $start_date = $now->copy()->subDay()->startOfDay();
                $end_date = $now->copy()->endOfDay();
                break;
            case 'Week':
                $start_date = $now->copy()->startOfWeek();
                $end_date = $now->copy()->endOfWeek();
                break;
            case 'Month':
                $start_date = $now->copy()->startOfMonth();
                $end_date = $now->copy()->endOfMonth();
                break;
            case 'Cycle':
                $financial_period = Utils::getActiveFinancialPeriod($user->company_id);
                if ($financial_period == null) {
                    throw new \Exception("Financial Period is not active. Please activate the financial period.");
                }
                $start_date = Carbon::parse($financial_period->start_date);
                $end_date = Carbon::parse($financial_period->end_date);
                break;
            case 'Year':
                $start_date = $now->copy()->startOfYear();
                $end_date = $now->copy()->endOfYear();
                break;
            case 'Custom':
                $start_date = Carbon::parse($model->start_date);
                $end_date = Carbon::parse($model->end_date);
                break;
        }




        $model->start_date = $start_date;
        $model->end_date = $end_date;
        $model->company_id = $user->company_id;
        $model->currency = $company->currency;
        if ($model->type == 'Financial') {
            //total total_income from financial records where category is income and date is between start_date and end_date
            $model->total_income = FinancialRecord::where('company_id', $user->company_id)
                ->where('type', 'Income')
                ->whereBetween('created_at', [$start_date, $end_date])
                ->sum('amount');
            $model->total_expense = FinancialRecord::where('company_id', $user->company_id)
                ->where('type', 'Expense')
                ->whereBetween('created_at', [$start_date, $end_date])
                ->sum('amount');
            $model->profit = $model->total_income - $model->total_expense;
        } else if ($model->type == 'Inventory') {
            //inventory_total_buying_price
            $inventory_total_buying_price = StockCategory::where('company_id', $user->company_id)
                ->whereBetween('created_at', [$start_date, $end_date])
                ->sum('buying_price');
            //inventory_total_selling_price
            $inventory_total_selling_price = StockCategory::where('company_id', $user->company_id)
                ->whereBetween('created_at', [$start_date, $end_date])
                ->sum('selling_price');
            //inventory_total_expected_profit
            $inventory_total_expected_profit = StockCategory::where('company_id', $user->company_id)
                ->whereBetween('created_at', [$start_date, $end_date])
                ->sum('expected_profit');
            //inventory_total_earned_profit
            $inventory_total_earned_profit = StockCategory::where('company_id', $user->company_id)
                ->whereBetween('created_at', [$start_date, $end_date])
                ->sum('earned_profit');
            $model->inventory_total_buying_price = $inventory_total_buying_price;
            $model->inventory_total_selling_price = $inventory_total_selling_price;
            $model->inventory_total_expected_profit = $inventory_total_expected_profit;
            $model->inventory_total_earned_profit = $inventory_total_earned_profit;
        }
        $table_name = $model->getTable();
        $sql = "UPDATE $table_name SET do_generate = 'No' WHERE id = $model->id";
        DB::update($sql);


        $pdf = App::make('dompdf.wrapper');
        $company = Company::find($user->company_id);
        if ($company->logo != null) {
        } else {
            $company->logo = null;
        }
        $pdf->loadHTML(view('reports.financial-report', [
            'data' => $model,
            'company' => $company
        ]));

        $pdf->render();
        $output = $pdf->output();
        $store_file_path = public_path('storage/files/report-' . $model->id . '.pdf');
        file_put_contents($store_file_path, $output);
        $model->file = 'files/report-' . $model->id . '.pdf';
        $model->file_generated = 'Yes';
        return $model;
    }

    //belongs to company
    public function company()
    {
        return $this->belongsTo(Company::class);
    }

    //appends 
    protected $appends = ['title'];

    //getter for title
    public function getTitleAttribute()
    {
        $t = $this->type . ' Report';
        $start_date = Carbon::parse($this->start_date);
        $end_date = Carbon::parse($this->end_date);
        $t .= ' for the period ' . $start_date->format('d/m/Y') . ' - ' . $end_date->format('d/m/Y') . '';
        $t .= ' (' . $this->period_type . ')';
        return $t;
    }

    public function finance_accounts()
    {

        $cats = [];
        foreach (FinancialCategory::where('company_id', $this->company_id)->get() as $cat) {

            $cat->total_income = FinancialRecord::where('company_id', $this->company_id)
                ->where('type', 'Income')
                ->where('financial_category_id', $cat->id)
                ->whereBetween('created_at', [$this->start_date, $this->end_date])
                ->sum('amount');

            $cat->total_expense = FinancialRecord::where('company_id', $this->company_id)
                ->where('type', 'Expense')
                ->where('financial_category_id', $cat->id)
                ->whereBetween('created_at', [$this->start_date, $this->end_date])
                ->sum('amount');
            $cats[] = $cat;
        }
        return $cats;
    }

    //finance_records
    public function finance_records()
    {
        return FinancialRecord::where('company_id', $this->company_id)
            ->whereBetween('created_at', [$this->start_date, $this->end_date])
            ->get();
    }


    //get_inventory_items
    public function get_inventory_items()
    {
        $items = [];
        foreach (StockItem::where('company_id', $this->company_id)
            ->whereBetween('created_at', [$this->start_date, $this->end_date])
            ->get() as $item) {
            $items[] = $item;
        }
        return $items;
    }
}
