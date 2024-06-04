<?php

namespace App\Admin\Controllers;

use App\Models\FinancialRecord;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class FinancialRecordController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'FinancialRecord';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new FinancialRecord());

        $grid->column('id', __('Id'));
        $grid->column('created_at', __('Created at'));
        $grid->column('updated_at', __('Updated at'));
        $grid->column('financial_category_id', __('Financial category id'));
        $grid->column('company_id', __('Company id'));
        $grid->column('user_id', __('User id'));
        $grid->column('amount', __('Amount'));
        $grid->column('quantity', __('Quantity'));
        $grid->column('type', __('Type'));
        $grid->column('payment_method', __('Payment method'));
        $grid->column('recipient', __('Recipient'));
        $grid->column('description', __('Description'));
        $grid->column('receipt', __('Receipt'));
        $grid->column('date', __('Date'));
        $grid->column('financial_period_id', __('Financial period id'));
        $grid->column('created_by_id', __('Created by id'));

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
        $show = new Show(FinancialRecord::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('created_at', __('Created at'));
        $show->field('updated_at', __('Updated at'));
        $show->field('financial_category_id', __('Financial category id'));
        $show->field('company_id', __('Company id'));
        $show->field('user_id', __('User id'));
        $show->field('amount', __('Amount'));
        $show->field('quantity', __('Quantity'));
        $show->field('type', __('Type'));
        $show->field('payment_method', __('Payment method'));
        $show->field('recipient', __('Recipient'));
        $show->field('description', __('Description'));
        $show->field('receipt', __('Receipt'));
        $show->field('date', __('Date'));
        $show->field('financial_period_id', __('Financial period id'));
        $show->field('created_by_id', __('Created by id'));

        return $show;
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        $form = new Form(new FinancialRecord());

        $form->number('financial_category_id', __('Financial category id'));
        $form->number('company_id', __('Company id'));
        $form->number('user_id', __('User id'));
        $form->number('amount', __('Amount'));
        $form->number('quantity', __('Quantity'));
        $form->text('type', __('Type'));
        $form->textarea('payment_method', __('Payment method'));
        $form->textarea('recipient', __('Recipient'));
        $form->textarea('description', __('Description'));
        $form->textarea('receipt', __('Receipt'));
        $form->date('date', __('Date'))->default(date('Y-m-d'));
        $form->number('financial_period_id', __('Financial period id'));
        $form->number('created_by_id', __('Created by id'));

        return $form;
    }
}
