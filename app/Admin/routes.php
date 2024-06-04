<?php

use Illuminate\Routing\Router;

Admin::routes();

Route::group([
    'prefix'        => config('admin.route.prefix'),
    'namespace'     => config('admin.route.namespace'),
    'middleware'    => config('admin.route.middleware'),
    'as'            => config('admin.route.prefix') . '.',
], function (Router $router) {

    $router->get('/', 'HomeController@index')->name('home');
    $router->resource('companies', CompanyController::class);
    $router->resource('stock-categories', StockCategoryController::class);
    $router->resource('stock-sub-categories', StockSubCategoryController::class);
    $router->resource('financial-periods', FinancialPeriodController::class);
    $router->resource('employees', EmployeesController::class);
    $router->resource('stock-items', StockItemController::class);
    $router->resource('stock-records', StockRecordController::class);
    $router->resource('companies-edit', CompanyEditController::class);
    $router->resource('gens', CodeGenController::class);
    $router->resource('gen', GenGenController::class);
    $router->resource('financial-categories', FinancialCategoryController::class);
    $router->resource('financial-reports', FinancialReportController::class);
    $router->resource('financial-records', FinancialRecordController::class);
    $router->resource('budget-programs', BudgetProgramController::class);
    $router->resource('contribution-records', ContributionRecordController::class);
    $router->resource('handover-records', HandoverRecordController::class);
    $router->resource('budget-item-categories', BudgetItemCategoryController::class);
    $router->resource('budget-items', BudgetItemController::class);
    $router->resource('data-exports', DataExportController::class);


});
