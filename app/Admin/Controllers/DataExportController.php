<?php

namespace App\Admin\Controllers;

use App\Models\DataExport;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Facades\Admin;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class DataExportController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'Data Export';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new DataExport());
        $u = Admin::user();
        $grid->model()
            ->where('company_id', $u->company_id)
            ->orderBy('id', 'desc');

        $grid->disableBatchActions();
        $grid->column('created_at', __('Created'))->hide();
        $grid->column('treasurer_id', __('Treasurer'))
            ->display(function ($treasurer_id) {
                $u = \App\Models\User::find($treasurer_id);
                if ($u) {
                    return $u->name;
                }
                return 'N/A';
            })->hide();
        $grid->column('category_id', __('Category'))
            ->sortable();
        /*         $grid->column('parameter_1', __('Parameter 1'));
        $grid->column('parameter_2', __('Parameter 2'));
        $grid->column('parameter_3', __('Parameter 3'));
        $grid->column('parameter_4', __('Parameter 4')); */
        //print
        $grid->column('print', __('Print'))
            ->display(function ($print) {
                $url = url('data-exports-print?id=' . $this->id);
                return "<a href='$url' target='_blank'>Print</a>";
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
        $show = new Show(DataExport::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('created_at', __('Created'));
        $show->field('updated_at', __('Updated'));
        $show->field('treasurer_id', __('Treasurer'));
        $show->field('category_id', __('Category id'));
        $show->field('parameter_1', __('Parameter 1'));
        $show->field('parameter_2', __('Parameter 2'));
        $show->field('parameter_3', __('Parameter 3'));
        $show->field('parameter_4', __('Parameter 4'));

        return $show;
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        $form = new Form(new DataExport());
        $u = Admin::user();
        $form->hidden('company_id', __('Company id'))->default($u->company_id);
        $form->hidden('created_by_id', __('Created by id'))->default($u->id);

        $form->select('treasurer_id', __('Treasurer'))->options(\App\Models\User::where('company_id', $u->company_id)->pluck('name', 'id'));
        $form->select('category_id', __('Category'))
            ->options([
                'Friend' => 'Friends',
                'Family' => 'Family',
                'MTK' => 'MTK',
            ])->required();
        /*         $form->text('parameter_1', __('Parameter 1'));
        $form->text('parameter_2', __('Parameter 2'));
        $form->text('parameter_3', __('Parameter 3'));
        $form->text('parameter_4', __('Parameter 4')); */

        return $form;
    }
}
