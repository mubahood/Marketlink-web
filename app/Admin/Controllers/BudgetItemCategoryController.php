<?php

namespace App\Admin\Controllers;

use App\Models\BudgetItemCategory;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Facades\Admin;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class BudgetItemCategoryController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'Budge Item Categories';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new BudgetItemCategory());

        $grid->disableBatchActions();
        $grid->quickSearch('name');
        $u = Admin::user();
        $grid->model()
            ->where('company_id', $u->company_id)
            ->orderBy('target_amount', 'desc');
        $grid->column('id', __('Id'))->sortable();
        /*         $grid->column('created_at', __('Created at'));
        $grid->column('updated_at', __('Updated at')); */
        $grid->column('name', __('Name'))->sortable();
        $grid->column('target_amount', __('Target Amount (UGX)'))
            ->display(function ($amount) {
                return number_format($amount);
            })
            ->totalRow(function ($amount) {
                return "<strong>" . number_format($amount) . "</strong>";
            })->sortable();
        $grid->column('invested_amount', __('Invested Amount (UGX)'))
            ->display(function ($amount) {
                return number_format($amount);
            })
            ->totalRow(function ($amount) {
                return "<strong>" . number_format($amount) . "</strong>";
            })->sortable();
        $grid->column('balance', __('Balance'))
            ->display(function ($amount) {
                return number_format($amount);
            })
            ->totalRow(function ($amount) {
                return "<strong>" . number_format($amount) . "</strong>";
            })->sortable();
        $grid->column('percentage_done', __('Percentage Done'))
            ->display(function ($amount) {
                return number_format($amount);
            })
            ->totalRow(function ($amount) {
                return "<strong>" . number_format($amount) . "</strong>";
            })->sortable();
        $grid->column('is_complete', __('Is complete'));

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
        $show = new Show(BudgetItemCategory::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('created_at', __('Created at'));
        $show->field('updated_at', __('Updated at'));
        $show->field('budget_program_id', __('Budget program id'));
        $show->field('company_id', __('Company id'));
        $show->field('name', __('Name'));
        $show->field('target_amount', __('Target amount'));
        $show->field('invested_amount', __('Invested amount'));
        $show->field('balance', __('Balance'));
        $show->field('percentage_done', __('Percentage done'));
        $show->field('is_complete', __('Is complete'));

        return $show;
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        $form = new Form(new BudgetItemCategory());

        $u = auth()->user();
        if ($u == null) {
            throw new \Exception('User not found');
        }
        $bps = \App\Models\BudgetProgram::where('company_id', $u->company_id)->orderBy('id', 'desc')->get();
        $bp = [];
        $first_id = null;
        foreach ($bps as $b) {
            $bp[$b->id] = $b->name;
            if ($first_id == null) {
                $first_id = $b->id;
            }
        }
        $form->select('budget_program_id', __('Budget program id'))->options($bp)
            ->default($first_id)
            ->required();
        $form->hidden('company_id', __('Company id'))->default($u->company_id);
        $form->text('name', __('Name'))->rules('required');
        $form->number('target_amount', __('Target amount'));
        $form->number('invested_amount', __('Invested amount'));
        $form->number('balance', __('Balance'));
        $form->number('percentage_done', __('Percentage done'));

        $form->radio('is_complete', __('Is complete'))
            ->options([
                'Yes' => 'Yes',
                'No' => 'No',
            ])
            ->default('No')
            ->rules('required');

        return $form;
    }
}
