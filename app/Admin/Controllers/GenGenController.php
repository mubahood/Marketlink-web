<?php

namespace App\Admin\Controllers;

use App\Models\Gen;
use App\Models\Utils;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class GenGenController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'Gen';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new Gen());        

        $grid->model()->orderBy('id', 'desc');
        $grid->column('class_name', __('Class name'));
        $grid->column('table_name', __('Table name'));
        $grid->column('endpoint', __('Endpoint'));
        $grid->column('generate_action', __('Gen model'))
            ->display(function ($gen_model) {
                $url = url('generate-models?id=' . $this->id);
                return "<a target='_blank' href='$url'>Generate Model</a>";
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
        $show = new Show(Gen::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('created_at', __('Created at'));
        $show->field('updated_at', __('Updated at'));
        $show->field('class_name', __('Class name'));
        $show->field('table_name', __('Table name'));
        $show->field('endpoint', __('Endpoint'));

        return $show;
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        $form = new Form(new Gen());

        $tables = Utils::get_table_names();
        $form->text('class_name', __('Class name'))
            ->rules('required');
        $form->select('table_name', __('Select table name'))
            ->options($tables)
            ->rules('required');
        $form->text('endpoint', __('API Endpoint'))
            ->rules('required');

        return $form;
    }
}
