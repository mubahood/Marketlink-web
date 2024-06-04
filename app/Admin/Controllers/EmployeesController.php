<?php

namespace App\Admin\Controllers;

use App\Models\User;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Facades\Admin;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class EmployeesController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'Employees';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new User());
        $u = Admin::user();
        $grid->model()->where('company_id', $u->company_id);

        $grid->quickSearch('first_name', 'last_name', 'phone_number', 'phone_number_2')
            ->placeholder('Search by name or phone number');
        $grid->disableBatchActions();

        $grid->column('avatar', __('Photo'))->lightbox([
            'width' => 50
        ]);
        $grid->column('name', __('Name'))->sortable();
        $grid->column('phone_number', __('Phone number'));
        $grid->column('phone_number_2', __('Phone number 2'))->hide();
        $grid->column('address', __('Address'));
        $grid->column('sex', __('Gender'))
            ->filter([
                'Male' => 'Male',
                'Female' => 'Female'
            ])->sortable();
        $grid->column('dob', __('Dob'))->sortable();
        $grid->column('status', __('Status'))
            ->dot([
                'Active' => 'succcess',
                'Inactive' => 'info',
            ], 'info')->sortable();

        $grid->column('created_at', __('Registered'))
            ->display(function ($created_at) {
                return date('Y-m-d', strtotime($created_at));
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
        $show = new Show(User::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('username', __('Username'));
        $show->field('password', __('Password'));
        $show->field('name', __('Name'));
        $show->field('avatar', __('Avatar'));
        $show->field('remember_token', __('Remember token'));
        $show->field('created_at', __('Created at'));
        $show->field('updated_at', __('Updated at'));
        $show->field('company_id', __('Company id'));
        $show->field('first_name', __('First name'));
        $show->field('last_name', __('Last name'));
        $show->field('phone_number', __('Phone number'));
        $show->field('phone_number_2', __('Phone number 2'));
        $show->field('address', __('Address'));
        $show->field('sex', __('Sex'));
        $show->field('dob', __('Dob'));
        $show->field('status', __('Status'));

        return $show;
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        $form = new Form(new User());

        $u = Admin::user();
        $form->hidden('company_id', __('Company id'))->default($u->company_id);

        $form->divider('Personal Information');

        $form->text('first_name', __('First name'))->required();
        $form->text('last_name', __('Last name'))->required();
        $form->radio('sex', __('Gender'))
            ->options([
                'Male' => 'Male',
                'Female' => 'Female',
                'Other' => 'Other',
            ]);

        $form->text('phone_number', __('Phone number'))->required();
        $form->text('phone_number_2', __('Phone number 2'));
        $form->text('address', __('Address'));
        $form->date('dob', __('Date of birth'));


        $form->divider('Account Information');

        $form->image('avatar', __('Avatar'));




        $form->text('email', __('Username'));

        $form->radio('status', __('Status'))
            ->options([
                'Active' => 'Active',
                'Inactive' => 'Inactive',
            ])->default('Active');

        return $form;
    }
}
