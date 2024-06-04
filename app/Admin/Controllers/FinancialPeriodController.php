<?php

namespace App\Admin\Controllers;

use App\Models\FinancialPeriod;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Facades\Admin;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class FinancialPeriodController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'Financial Periods';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new FinancialPeriod());
        $u = Admin::user();
        $grid->model()
            ->where('company_id', $u->company_id)
            ->orderBy('status', 'asc');
        $grid->disableBatchActions();

        $grid->column('name', __('Name'))->sortable();
        $grid->column('start_date', __('Start Date'))
            ->display(function ($start_date) {
                return date('Y-m-d', strtotime($start_date));
            })->sortable();
        $grid->column('end_date', __('End Date'))
            ->display(function ($end_date) {
                return date('Y-m-d', strtotime($end_date));
            })->sortable();
        $grid->column('status', __('Status'))
            ->label([
                'Active' => 'success',
                'Inactive' => 'danger',
            ])->sortable();
        $grid->column('description', __('Description'))->hide();
        $grid->column('total_investment', __('Total Investment'))
            ->display(function ($total_investment) {
                return number_format($total_investment);
            })->sortable();
        $grid->column('total_sales', __('Total sales'))
            ->display(function ($total_sales) {
                return number_format($total_sales);
            })->sortable();
        $grid->column('total_profit', __('Total profit'))
            ->display(function ($total_profit) {
                return number_format($total_profit);
            })->sortable();
        $grid->column('total_expenses', __('Total Expenses'))
            ->display(function ($total_expenses) {
                return number_format($total_expenses);
            })->sortable();

        return $grid;
    }

    /**
     * Make a show builder.
     *
     * @param mixed $id
     * @return Show
     */
    protected function detail($id)
    {
        $show = new Show(FinancialPeriod::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('created_at', __('Created at'));
        $show->field('updated_at', __('Updated at'));
        $show->field('company_id', __('Company id'));
        $show->field('name', __('Name'));
        $show->field('start_date', __('Start date'));
        $show->field('end_date', __('End date'));
        $show->field('status', __('Status'));
        $show->field('description', __('Description'));
        $show->field('total_investment', __('Total investment'));
        $show->field('total_sales', __('Total sales'));
        $show->field('total_profit', __('Total profit'));
        $show->field('total_expenses', __('Total expenses'));

        return $show;
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        $form = new Form(new FinancialPeriod());
        $u = Admin::user();
        $form->hidden('company_id', __('Company'))
            ->default($u->company_id);

        $form->text('name', __('Name'))->rules('required');

        $form->date('start_date', __('Start date'))->default(date('Y-m-d'));
        $form->date('end_date', __('End date'))->default(date('Y-m-d'));

        $form->radio('status', __('Status'))
            ->default('Active')
            ->options([
                'Active' => 'Active',
                'Inactive' => 'Inactive',
            ])->rules('required');
        $form->textarea('description', __('Description'));


        return $form;
    }
}
