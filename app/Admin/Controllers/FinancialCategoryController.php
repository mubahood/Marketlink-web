<?php

namespace App\Admin\Controllers;

use App\Models\Company;
use App\Models\FinancialCategory;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Facades\Admin;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class FinancialCategoryController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'FinancialCategory';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new FinancialCategory());
        $u = Admin::user();
        if($u !=null){
            $grid->model()->where('company_id', $u->company_id);
        }
        $cats = FinancialCategory::where('company_id', $u->company_id)->get();
        if($cats->count() <= 0){
            $company = $u->company;
            Company::prepare_account_categories($company->id); 
        } 

        $grid->column('id', __('Id'));
        $grid->column('created_at', __('Created at'));
        $grid->column('updated_at', __('Updated at'));
        $grid->column('company_id', __('Company id'));
        $grid->column('total_income', __('Total income'));
        $grid->column('total_expense', __('Total expense'));
        $grid->column('name', __('Name'));
        $grid->column('description', __('Description'));

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
        $show = new Show(FinancialCategory::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('created_at', __('Created at'));
        $show->field('updated_at', __('Updated at'));
        $show->field('company_id', __('Company id'));
        $show->field('total_income', __('Total income'));
        $show->field('total_expense', __('Total expense'));
        $show->field('name', __('Name'));
        $show->field('description', __('Description'));

        return $show;
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        $form = new Form(new FinancialCategory());

        $form->number('company_id', __('Company id'));
        $form->number('total_income', __('Total income'));
        $form->number('total_expense', __('Total expense'));
        $form->text('name', __('Name'));
        $form->textarea('description', __('Description'));

        return $form;
    }
}
