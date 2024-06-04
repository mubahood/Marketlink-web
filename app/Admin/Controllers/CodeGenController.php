<?php

namespace App\Admin\Controllers;

use App\Models\CodeGen;
use App\Models\Utils;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class CodeGenController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'Code Generator';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new CodeGen());

        $grid->model()->orderBy('id', 'desc');
        $grid->column('other_1', __('Class name'));
        $grid->column('table_name', __('Table name'));
        $grid->column('end_point', __('End point'));
        /*         $grid->column('other_2', __('Other 2')); */

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
        $show = new Show(CodeGen::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('created_at', __('Created at'));
        $show->field('updated_at', __('Updated at'));
        $show->field('table_name', __('Table name'));
        $show->field('end_point', __('End point'));
        $show->field('other_1', __('Other 1'));
        $show->field('other_2', __('Other 2'));

        return $show;
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        $form = new Form(new CodeGen());

        $table_name = Utils::get_table_names();
        $form->text('other_1', __('Class name'))->rules('required');
        $form->select('table_name', __('Table name'))
            ->options($table_name)
            ->rules('required');
        $form->text('end_point', __('End point'))->rules('required');
        /*         $form->text('other_2', __('Other 2')); */

        return $form;
    }
}
