<?php

namespace App\Models;

use Carbon\Carbon;
use Dflydev\DotAccessData\Util;
use Encore\Admin\Facades\Admin;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;
use SplFileObject;

class Utils
{


    public static function my_date_3($t)
    {
        $c = Carbon::parse($t);
        //set timezone
        if ($t == null) {
            return $t;
        }
        $c->setTimezone('Africa/Nairobi');
        return $c->format('D d-m-Y');
    }
    //money shortten to to K, M, B
    public static function money_short($money)
    {
        if ($money < 1000) {
            return number_format($money);
        }
        if ($money < 1000000) {
            return round($money / 1000, 2) . "K";
        }
        if ($money < 1000000000) {
            return round($money / 1000000, 2) . "M";
        }
        return round($money / 1000000000, 2) . "B";
    }


    public static function my_date($t)
    {
        $c = Carbon::parse($t);
        if ($t == null) {
            return $t;
        }
        $c->setTimezone('Africa/Nairobi');
        return $c->format('d M, Y');
    }

    public static function my_date_time($t)
    {
        $c = Carbon::parse($t);
        $c->setTimezone('Africa/Nairobi');
        if ($t == null) {
            return $t;
        }
        return $c->format('d M, Y - h:m a');
    }

    public static function to_date_time($raw)
    {
        $t = Carbon::parse($raw);
        if ($t == null) {
            return  "-";
        }
        $my_t = $t->toDateString();

        return $my_t . " " . $t->toTimeString();
    }

    public static function file_upload($file)
    {
        if ($file == null) {
            return '';
        }
        //get file extension
        $file_extension = $file->getClientOriginalExtension();
        $file_name = time() . "_" . rand(1000, 100000) . "." . $file_extension;
        $public_path = public_path() . "/storage/images";
        $file->move($public_path, $file_name);
        $url = 'images/' . $file_name;
        return $url;
    }

    public static function get_user(Request $r)
    {
        $logged_in_user_id = $r->get('logged_in_user_id');
        $u = User::find($logged_in_user_id);
        return $u;
    }

    public static function success($data, $message)
    {
        //set header response to json
        header('Content-Type: application/json');
        http_response_code(200);
        echo json_encode([
            'code' => 1,
            'message' => $message,
            'data' => $data,
        ]);
        die();
    }

    public static function error($message)
    {
        header('Content-Type: application/json');
        http_response_code(200);
        echo json_encode([
            'code' => 0,
            'message' => $message,
            'data' => null,
        ]);
        die();
    }

    static function getActiveFinancialPeriod($company_id)
    {
        return FinancialPeriod::where('company_id', $company_id)
            ->where('status', 'Active')->first();
    }

    static public function generateSKU($sub_category_id)
    {
        //year-subcategory-id-serial
        $year = date('Y');
        $sub_category = StockSubCategory::find($sub_category_id);
        $serial = StockItem::where('stock_sub_category_id', $sub_category_id)->count() + 1;
        $sku = $year . "-" . $sub_category->id . "-" . $serial;
        return $sku;
    }


    static public function get_table_names()
    {
        $tables = DB::select('SHOW TABLES');
        $db_name = env('DB_DATABASE');
        $table_names = [];
        $db_name = 'Tables_in_' . $db_name;
        foreach ($tables as $key => $table) {
            $table_names[$table->$db_name] = $table->$db_name;
        }
        return $table_names;
    }


    static public function generate_dummy($u)
    {
        $user = $u;
        $company = $user->company;
        //Utils::demo_categories($company); 
        //Utils::demo_sub_categories($company);
        //Utils::demo_stock_items($company);
        //Utils::demo_stock_records($company);
        //Utils::demo_financial_periods($company);
        //Utils::demo_financial_record($company);
    }

    static public function demo_financial_record($company)
    {
        //based on FinancialCategory
        $financial_categories = FinancialCategory::where('company_id', $company->id)->get();

        // FinancialRecord based on following fields 
        /*  
created_at
updated_at
financial_category_id
company_id
user_id
amount
quantity
type
payment_method
recipient
description
receipt
date
financial_period_id
created_by_id 
    */
        foreach ($financial_categories as $key => $financial_category) {
            $financial_records = [
                ['amount' => 100, 'quantity' => 10, 'type' => 'Income', 'payment_method' => 'Cash', 'recipient' => 'Recipient 1', 'description' => 'Description 1', 'receipt' => 'Receipt 1'],
                ['amount' => 100, 'quantity' => 10, 'type' => 'Income', 'payment_method' => 'Cash', 'recipient' => 'Recipient 2', 'description' => 'Description 2', 'receipt' => 'Receipt 2'],
                ['amount' => 100, 'quantity' => 10, 'type' => 'Income', 'payment_method' => 'Cash', 'recipient' => 'Recipient 3', 'description' => 'Description 3', 'receipt' => 'Receipt 3'],
                ['amount' => 100, 'quantity' => 10, 'type' => 'Income', 'payment_method' => 'Cash', 'recipient' => 'Recipient 4', 'description' => 'Description 4', 'receipt' => 'Receipt 4'],
                ['amount' => 100, 'quantity' => 10, 'type' => 'Income', 'payment_method' => 'Cash', 'recipient' => 'Recipient 5', 'description' => 'Description 5', 'receipt' => 'Receipt 5'],
            ];
            foreach ($financial_records as $key => $financial_record) {
                $financial_record['company_id'] = $company->id;
                $financial_record['user_id'] = $company->owner_id;
                $financial_record['financial_category_id'] = $financial_category->id;
                $financial_record['financial_period_id'] = Utils::getActiveFinancialPeriod($company->id)->id;
                $financial_record['created_by_id'] = $company->owner_id;
                FinancialRecord::create($financial_record);
            }
        }
    }
    static public function demo_stock_records($company)
    {
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
        $stock_items = StockItem::where('company_id', $company
            ->id)->get();
        foreach ($stock_items as $key => $stock_item) {
            $stock_records = [
                ['name' => 'Stock Record 1', 'description' => 'Stock Record 1', 'quantity' => 10, 'selling_price' => 150, 'type' => 'sale'],
                ['name' => 'Stock Record 2', 'description' => 'Stock Record 2', 'quantity' => 10, 'selling_price' => 150, 'type' => 'sale'],
                ['name' => 'Stock Record 3', 'description' => 'Stock Record 3', 'quantity' => 10, 'selling_price' => 150, 'type' => 'sale'],
                ['name' => 'Stock Record 4', 'description' => 'Stock Record 4', 'quantity' => 10, 'selling_price' => 150, 'type' => 'sale'],
                ['name' => 'Stock Record 5', 'description' => 'Stock Record 5', 'quantity' => 10, 'selling_price' => 150, 'type' => 'sale'],
            ];
            foreach ($stock_records as $key => $stock_record) {
                $stock_record['company_id'] = $company->id;
                $stock_record['stock_item_id'] = $stock_item->id;
                $stock_record['stock_category_id'] = $stock_item->stock_category_id;
                $stock_record['stock_sub_category_id'] = $stock_item->stock_sub_category_id;
                $stock_record['created_by_id'] = $company->owner_id;
                $stock_record['sku'] = $stock_item->sku;
                $stock_record['measurement_unit'] = 'Kg';
                $stock_record['total_sales'] = $stock_record['quantity'] * $stock_record['selling_price'];
                StockRecord::create($stock_record);
            }
        }
    }
    static public function demo_stock_items($company)
    {
        /*  
id	
created_at	
updated_at	
company_id	
created_by_id	
stock_category_id	
stock_sub_category_id	
financial_period_id	
name	
description	
image	
barcode	
sku	
generate_sku	
update_sku	
gallery	
buying_price	
selling_price	
original_quantity	
current_quantity 
*/
        $sub_categories = StockSubCategory::where('company_id', $company->id)->get();
        foreach ($sub_categories as $key => $sub_category) {
            $stock_items = [
                ['name' => 'Stock Item 1', 'description' => 'Stock Item 1', 'buying_price' => 100, 'selling_price' => 150, 'original_quantity' => 100],
                ['name' => 'Stock Item 2', 'description' => 'Stock Item 2', 'buying_price' => 100, 'selling_price' => 150, 'original_quantity' => 100],
                ['name' => 'Stock Item 3', 'description' => 'Stock Item 3', 'buying_price' => 100, 'selling_price' => 150, 'original_quantity' => 100],
                ['name' => 'Stock Item 4', 'description' => 'Stock Item 4', 'buying_price' => 100, 'selling_price' => 150, 'original_quantity' => 100],
                ['name' => 'Stock Item 5', 'description' => 'Stock Item 5', 'buying_price' => 100, 'selling_price' => 150, 'original_quantity' => 100],
            ];
            foreach ($stock_items as $key => $stock_item) {
                $stock_item['company_id'] = $company->id;
                $stock_item['stock_category_id'] = $sub_category->stock_category_id;
                $stock_item['stock_sub_category_id'] = $sub_category->id;
                $stock_item['created_by_id'] = $company->created_by_id;
                $stock_item['financial_period_id'] = Utils::getActiveFinancialPeriod($company->id)->id;
                $stock_item['image'] = 'images/placeholder.jpg';
                $stock_item['barcode'] = 'barcode';
                $stock_item['sku'] = Utils::generateSKU($sub_category->id);
                $stock_item['generate_sku'] = 'No';
                $stock_item['update_sku'] = 'No';
                $stock_item['gallery'] = '[]';
                $stock_item['current_quantity'] = 0;
                $stock_item['created_by_id'] = $company->owner_id;
                StockItem::create($stock_item);
            }
        }
    }
    static public function demo_sub_categories($company)
    {
        $categories = StockCategory::where('company_id', $company
            ->id)->get();
        foreach ($categories as $key => $category) {
            $sub_categories = [
                ['name' => 'Sub Category 1', 'description' => 'Sub Category 1', 'status' => 'active', 'measurement_unit' => 'Kg', 'reorder_level' => 10],
                ['name' => 'Sub Category 2', 'description' => 'Sub Category 2', 'status' => 'active', 'measurement_unit' => 'Kg', 'reorder_level' => 10],
                ['name' => 'Sub Category 3', 'description' => 'Sub Category 3', 'status' => 'active', 'measurement_unit' => 'Kg', 'reorder_level' => 10],
                ['name' => 'Sub Category 4', 'description' => 'Sub Category 4', 'status' => 'active', 'measurement_unit' => 'Kg', 'reorder_level' => 10],
                ['name' => 'Sub Category 5', 'description' => 'Sub Category 5', 'status' => 'active', 'measurement_unit' => 'Kg', 'reorder_level' => 10],
            ];
            foreach ($sub_categories as $key => $sub_category) {
                $sub_category['company_id'] = $company->id;
                $sub_category['stock_category_id'] = $category->id;
                $sub_category['image'] = 'images/placeholder.jpg';
                $sub_category['buying_price'] = 0;
                $sub_category['selling_price'] = 0;
                $sub_category['expected_profit'] = 0;
                $sub_category['earned_profit'] = 0;
                $sub_category['current_quantity'] = 0;
                StockSubCategory::create($sub_category);
            }
        }
    }

    static public function demo_categories($company)
    {
        $categories = [
            ['name' => 'Electronics', 'description' => 'Electronics', 'status' => 'active'],
            ['name' => 'Furniture', 'description' => 'Furniture', 'status' => 'active'],
            ['name' => 'Clothing', 'description' => 'Clothing', 'status' => 'active'],
            ['name' => 'Food', 'description' => 'Food', 'status' => 'active'],
            ['name' => 'Stationery', 'description' => 'Stationery', 'status' => 'active'],
        ];
        foreach ($categories as $key => $category) {
            $category['company_id'] = $company->id;
            $category['image'] = 'images/placeholder.jpg';
            $category['buying_price'] = 0;
            $category['selling_price'] = 0;
            $category['expected_profit'] = 0;
            $category['earned_profit'] = 0;
            StockCategory::create($category);
        }
    }


    //public static function importRecs
    public static function importRecs()
    {
        return;
        $path = public_path('storage/files/budget.csv');
        //check if file exists
        if (!file_exists($path)) {
            dd("File not found");
        }

        set_time_limit(-1);
        $isFirst = true;
        $items = [];
        $csv = new SplFileObject($path);
        $csv->setFlags(SplFileObject::READ_CSV);
        $u = Admin::user();
        $cat = BudgetItemCategory::where('name', 'Hom Renovation')->first();
        if ($cat == null) {
            die("Cat not found.");
        }
        foreach ($csv as $line) {
            if ($isFirst) {
                $isFirst = false;
                continue;
            }
            $cat_name = $line[0];
            if ($cat->name != $cat_name) {
                continue;
            }
            $name = trim($line[1]);
            $ex = BudgetItem::where([
                'name' => $name,
                'budget_item_category_id' => $cat->id
            ])->first();
            if ($ex != null) {
                echo ("<br>Skipped $name because already exists.");
                continue;
            }
            $item = new BudgetItem();
            $item->name = $name;
            $item->unit_price = ((int)($line[2]));
            $item->quantity = ((int)$line[3]);
            $item->target_amount = $item->unit_price * $item->quantity;
            $item->invested_amount = ((int)$line[5]);
            $item->approved = 'No';
            $item->budget_program_id = $cat->budget_program_id;
            $item->budget_item_category_id = $cat->id;
            $item->company_id = $cat->company_id;
            $item->created_by_id = $u->id;
            $item->changed_by_id = $u->id;
            $item->save();
            echo $item->id . ". saved " . $item->name . "<br>";
        }
        //die("done");
    }


    //mail sender
    public static function mail_sender($data)
    {
        /* die(view('mails/mail-1',
        [
            'body' => $data['body'],
            'title' => $data['subject']
        ])); */
        try {
            Mail::send(
                'mails/mail-1',
                [
                    'body' => $data['body'],
                    'title' => $data['subject']
                ],
                function ($m) use ($data) {
                    $m->to($data['email'], $data['name'])
                        ->subject($data['subject']);
                    $m->from(env('MAIL_FROM_ADDRESS'), $data['subject']);
                }
            );
        } catch (\Throwable $th) {
            $msg = 'failed';
            throw $th;
        }
    }
}
