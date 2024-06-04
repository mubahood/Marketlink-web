<?php

namespace App\Admin\Controllers;

use App\Models\BudgetItem;
use App\Models\BudgetItemCategory;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class BudgetItemController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'Budget Items';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new BudgetItem());

        $cats = [];
        foreach (BudgetItemCategory::all() as $key => $cat) {
            $cats[$cat->id] = $cat->name;
        }

        $grid->quickSearch('name');
        //$grid->disableBatchActions();
        $grid->column('id', __('Id'))->sortable();
        $grid->column('created_at', __('Created'))->hide();
        $grid->column('budget_item_category_id', __('Category'))
            ->display(function ($amount) {
                if ($this->category == null) {
                    return "N/A";
                }
                return $this->category->name;
            })->sortable()
            ->filter($cats);
        $grid->column('name', __('Name'))->sortable()->editable();
        $grid->column('unit_price', __('Quantity'))->sortable()->editable();
        $grid->column('quantity', __('Unit Price'))->sortable()->editable();

        $grid->column('target_amount', __('Target amount'))->display(function ($amount) {
            return number_format($amount);
        })
            ->totalRow(function ($amount) {
                return "<strong>" . number_format($amount) . "</strong>";
            })->sortable();
        $grid->column('invested_amount', __('Invested Amount'))
            ->display(function ($amount) {
                return number_format($amount);
            })
            ->totalRow(function ($amount) {
                return "<strong>" . number_format($amount) . "</strong>";
            })->sortable()->editable();
        $grid->column('balance', __('Balance'))->display(function ($amount) {
            return number_format($amount);
        })
            ->totalRow(function ($amount) {
                return "<strong>" . number_format($amount) . "</strong>";
            })->sortable();
        $grid->column('percentage_done', __('Percentage'))->totalRow(function ($amount) {
            return "<strong>" . number_format($amount) . "</strong>";
        })->sortable();
        $grid->column('is_complete', __('Is Complete'))
            ->label([
                'Yes' => 'success',
                'No' => 'danger',
            ])->sortable()
            ->filter([
                'Yes' => 'Yes',
                'No' => 'No',
            ]);
        $grid->column('approved', __('Approved'))
            ->sortable()
            ->switch([
                'On' => 'Yes',
                'Off' => 'No',
            ]);
        $grid->column('details', __('Remarks'))
            ->sortable()
            ->editable();


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
        $show = new Show(BudgetItem::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('created_at', __('Created at'));
        $show->field('updated_at', __('Updated at'));
        $show->field('budget_program_id', __('Budget program id'));
        $show->field('budget_item_category_id', __('Budget item category id'));
        $show->field('company_id', __('Company id'));
        $show->field('created_by_id', __('Created by id'));
        $show->field('changed_by_id', __('Changed by id'));
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
        $form = new Form(new BudgetItem());


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
        $form->select('budget_program_id', __('Budget program'))->options($bp)
            ->default($first_id)
            ->required();
        $form->hidden('company_id', __('Company'))->default($u->company_id);
        $form->text('name', __('Name'))->rules('required');
        $cats = [];
        foreach (BudgetItemCategory::all() as $key => $cat) {
            $cats[$cat->id] = $cat->name;
        }
        $form->select('budget_item_category_id', __('Budget Item Category'))
            ->options($cats)
            ->rules('required');
        $form->hidden('created_by_id', __('Created by id'))->default($u->id);
        $form->hidden('changed_by_id', __('Changed by id'))->default($u->id);
        $form->decimal('unit_price', __('Quantity'));
        $form->decimal('quantity', __('Unit price'));
        $form->divider();
        $form->decimal('invested_amount', __('Invested amount'));
        $form->textarea('details', __('Remarks'));

        $form->hidden('approved', __('Invested amount'));
        $form->hidden('is_complete', __('Is complete'));

        return $form;
    }
}
