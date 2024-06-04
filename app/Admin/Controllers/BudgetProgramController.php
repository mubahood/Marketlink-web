<?php

namespace App\Admin\Controllers;

use App\Models\BudgetProgram;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Facades\Admin;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class BudgetProgramController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'Budget Programs';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new BudgetProgram());
        $grid->disableBatchActions();
        $u = Admin::user();
        $grid->model()
            ->where('company_id', $u->company_id)
            ->orderBy('id', 'desc');
        $grid->column('created_at', __('Created'))
            ->display(function ($created_at) {
                return date('d-m-Y H:i:s', strtotime($created_at));
            })->sortable()
            ->hide();
        $grid->column('name', __('Name'))->sortable();
        $grid->column('total_collected', __('Total Collected'))
            ->display(function ($total_collected) {
                return number_format($total_collected);
            })->sortable();
        $grid->column('total_expected', __('Total Expected'))->display(function ($total_expected) {
            return number_format($total_expected);
        })->sortable();
        $grid->column('total_in_pledge', __('Total in pledge'))
            ->display(function ($total_in_pledge) {
                return number_format($total_in_pledge);
            })->sortable();
        $grid->column('budget_total', __('Budget total'))
            ->display(function ($budget_total) {
                return number_format($budget_total);
            })->sortable();
        $grid->column('budget_spent', __('Budget spent'))
            ->display(function ($budget_spent) {
                return number_format($budget_spent);
            })->sortable();
        $grid->column('budget_balance', __('Budget balance'))
            ->display(function ($budget_balance) {
                return number_format($budget_balance);
            })->sortable();

        //print column
        $grid->column('print', __('Print'))->display(function () {
            $link = url('budget-program-print?id=' . $this->id);
            return "<a href='$link' target='_blank'>Print</a>";
        });

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
        $show = new Show(BudgetProgram::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('created_at', __('Created at'));
        $show->field('updated_at', __('Updated at'));
        $show->field('company_id', __('Company id'));
        $show->field('name', __('Name'));
        $show->field('total_collected', __('Total collected'));
        $show->field('total_expected', __('Total expected'));
        $show->field('total_in_pledge', __('Total in pledge'));
        $show->field('budget_total', __('Budget total'));
        $show->field('budget_spent', __('Budget spent'));
        $show->field('budget_balance', __('Budget balance'));

        return $show;
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        $form = new Form(new BudgetProgram());
        $form->text('name', __('Name'))->rules('required');
        $form->radio('status', __('Status'))->rules('required')
            ->options([
                'Active' => 'Active',
                'Inactive' => 'Inactive'
            ])
            ->default('Active');
        /*
        $form->number('total_collected', __('Total collected'));
        $form->number('total_expected', __('Total expected'));
        $form->number('total_in_pledge', __('Total in pledge'));
        $form->number('budget_total', __('Budget total'));
        $form->number('budget_spent', __('Budget spent'));
        $form->number('budget_balance', __('Budget balance')); */

        return $form;
    }
}
