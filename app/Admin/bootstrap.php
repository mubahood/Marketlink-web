<?php

/**
 * Laravel-admin - admin builder based on Laravel.
 * @author z-song <https://github.com/z-song>
 *
 * Bootstraper for Admin.
 *
 * Here you can remove builtin form field:
 * Encore\Admin\Form::forget(['map', 'editor']);
 *
 * Or extend custom form field:
 * Encore\Admin\Form::extend('php', PHPEditor::class);
 *
 * Or require js and css assets:
 * Admin::css('/packages/prettydocs/css/styles.css');
 * Admin::js('/packages/prettydocs/js/main.js');
 *
 */

use App\Models\BudgetItem;
use App\Models\Utils;
use Encore\Admin\Facades\Admin;

Utils::importRecs();

/* $d = BudgetItem::find(1);
$d->details .= '1';
$d->save(); 
dd($d);
 */
Encore\Admin\Form::forget(['map', 'editor']);
$u = Admin::user();
if ($u != null) {
    Utils::generate_dummy($u);
}
