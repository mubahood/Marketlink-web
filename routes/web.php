<?php

use App\Models\BudgetProgram;
use App\Models\ContributionRecord;
use App\Models\DataExport;
use App\Models\FinancialReport;
use App\Models\Gen;
use App\Models\Utils;
use Carbon\Carbon;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Route;

Route::get('thanks', function () {
    $thanks = [
        '[NAME] - [AMOUNT], Thank you so much.<br><br>May Allah bless you abundantly.<br>🧎',
        '[NAME] - [AMOUNT], May Allah reward you abundantly.<br>🧎',
        '[NAME] - [AMOUNT], Thank you so much for your contribution.<br>🧎',
        '[NAME] - [AMOUNT], May Allah bless you abundantly.<br>🧎',
        '[NAME] - [AMOUNT], May Allah reward you abundantly.<br>🧎',
        '[NAME] - [AMOUNT], Thank you so much for your contribution.<br>🧎',
        '[NAME] - [AMOUNT], May Allah bless you abundantly.<br>🧎',
    ];
    $record = ContributionRecord::find($_GET['id']);
    $msg = $thanks[array_rand($thanks)];
    $msg = str_replace('[NAME]', $record->name, $msg);
    $paid = '✅';
    if ($record->not_paid_amount > 0) {
        $paid = '🅿️';
    }
    $msg = str_replace('[AMOUNT]', Utils::money_short($record->amount) . $paid, $msg);
    echo $msg;
    die();
});
Route::get('data-exports-print', function () {
    $id = $_GET['id'];
    $d = DataExport::find($id);
    $conds = [
        'category_id' => $d->category_id,
    ];
    if ($d->treasurer_id != null && $d->treasurer_id != 0) {
        $t = \App\Models\User::find($d->treasurer_id);
        if ($t != null) {
            $conds = ['treasurer_id' => $t->id];
        }
    }
    $recs
        = ContributionRecord::where($conds)
        ->orderBy('not_paid_amount', 'desc')->get();
    $patially_paid = [];
    $not_paid = [];
    $fully_paid = [];
    $pledged = 0;
    $paid = 0;
    $not_paid_amount = 0;
    foreach ($recs as $rec) {
        $pledged += $rec->amount;
        $paid += $rec->paid_amount;
        $not_paid_amount += $rec->not_paid_amount;
        if ($rec->fully_paid == 'Yes') {
            $fully_paid[] = $rec;
        } else if ($rec->paid_amount > 0) {
            $patially_paid[] = $rec;
        } else {
            $not_paid[] = $rec;
        }
    }

    //last day 10th may
    $last_dat = Carbon::create(2024, 5, 12, 0, 0, 0);
    $days_left = Carbon::now()->diffInDays($last_dat);

    if($days_left < 0){
        $days_left = 0;
    }

    $days_word = 'days';
    if ($days_left == 1) {
        $days_word = 'day';
    }

    echo '📌 *MUBARAKA\'s WEDDING CONTRIBUTIONS*';
    echo '<br><br> 🗓️ : ' . $days_left . " $days_word left";
    echo '<br><br>_*-----SUMMARY-------*_<br>' . "";

    /*     echo '<br>*TOAL PLEDGED:* ' . number_format($pledged) . "<br>"; */
    echo '*Cash Paid:✅* ' . number_format($paid) . "<br>";
    echo '*PLEDGED:🅿️* ' . number_format($not_paid_amount) . "<br>";
    echo '<br>*Fully Paid:* ' . count($fully_paid) . "<br>";
    /* echo '*Partially Paid:* ' . count($patially_paid) . "<br>"; */
    echo '*Not Paid:* ' . (count($not_paid) + count($patially_paid)) . "<br>";
    echo '<br> *_PLEDGED MEMBERS_*' . "";
    $i = 1;
    foreach ($not_paid as $rec) {
        echo "<br>$i. " . $rec->name . " - " . Utils::money_short($rec->not_paid_amount) . '🅿️';
        $i++;
    }

    /*  echo '<br><br> *_PARTIALLY PAID MEMBERS_*' . "";
    $i = 1; */
    foreach ($patially_paid as $rec) {
        echo "<br>$i. " . $rec->name . " - " . Utils::money_short($rec->paid_amount) . '✅' . $rec->tr() . ', ' . Utils::money_short($rec->not_paid_amount) . '🅿️';
        $i++;
    }

    echo '<br><br> *_FULLY PAID MEMBERS_*' . "";
    $i = 1;
    foreach ($fully_paid as $rec) {
        echo "<br>$i. " . $rec->name . " - " . Utils::money_short($rec->amount) . '✅' . $rec->tr();
        $i++;
    }

    echo "<br><br>----------R.S.V.P:🙏-----------<br>";
    echo '1. *Siama Saleh* - 0782349228 0706906707<br>';
    echo '2. *Bwambale Muhidin* - 0762556385 0703903402 <br>';
    echo '3. *Muhindo Mubaraka* - 0783204665 0706638494<br>';
    echo '<br>*Jazakumullah Khairan* 🧎';
    die();
});

Route::get('financial-report', function () {
    $id = request('id');
    $rep = FinancialReport::find($id);
    if ($rep == null) {
        return die('Gen not found');
    }

    $pdf = App::make('dompdf.wrapper');
    $company = $rep->company;

    //check fi has logo and if it exisits
    if ($company->logo != null) {
        //$company->logo = public_path() . '/storage/' . $company->logo;
    } else {
        $company->logo = null;
    }

    $pdf->loadHTML(view('reports.financial-report', [
        'data' => $rep,
        'company' => $company
    ]));

    $model = $rep;
    $pdf->render();
    $output = $pdf->output();
    $store_file_path = public_path('storage/files/report-' . $model->id . '.pdf');
    file_put_contents($store_file_path, $output);
    $model->file = 'files/report-' . $model->id . '.pdf';
    $model->file_generated = 'Yes';


    return $pdf->stream();

    //view reports.financial-report
    return view('reports.financial-report', ['data' => $rep]);
});

Route::get('budget-program-print', function () {
    $id = request('id');
    $rep = BudgetProgram::find($id);
    if ($rep == null) {
        return die('Gen not found');
    }

    $pdf = App::make('dompdf.wrapper');
    $company = $rep->company;

    //check fi has logo and if it exisits
    if ($company->logo != null) {
        //$company->logo = public_path() . '/storage/' . $company->logo;
    } else {
        $company->logo = null;
    }

    $rep->get_categories();
    $pdf->loadHTML(view('reports.budget-report', [
        'data' => $rep,
        'company' => $company
    ]));

    $model = $rep;
    $pdf->render();
    $output = $pdf->output();
    $store_file_path = public_path('storage/files/budget-' . $model->id . '.pdf');
    file_put_contents($store_file_path, $output);
    $model->file = 'files/budget-' . $model->id . '.pdf';


    return $pdf->stream();

    //view reports.financial-report
    return view('reports.financial-report', ['data' => $rep]);
});


// Route get generate-models

Route::get('generate-models', function () {
    $id = request('id');
    $gen = Gen::find($id);
    if ($gen == null) {
        return die('Gen not found');
    }
    $gen->gen_model();
    return die('generate-models');
});


/* Route::get('/', function () {
    return die('welcome');
});
Route::get('/home', function () {
    return die('welcome home');
});
 */