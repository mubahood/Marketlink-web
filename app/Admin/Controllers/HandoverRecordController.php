<?php

namespace App\Admin\Controllers;

use App\Models\HandoverRecord;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class HandoverRecordController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'Handover Records';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new HandoverRecord());

        $grid->column('id', __('Id'));
        $grid->column('created_at', __('Created at'));
        $grid->column('updated_at', __('Updated at'));
        $grid->column('budget_program_id', __('Budget program id'));
        $grid->column('company_id', __('Company id'));
        $grid->column('from_id', __('From id'));
        $grid->column('to_id', __('To id'));
        $grid->column('details', __('Details'));
        $grid->column('transfer_date', __('Transfer date'));
        $grid->column('to_approved', __('To approved'));

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
        $show = new Show(HandoverRecord::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('created_at', __('Created at'));
        $show->field('updated_at', __('Updated at'));
        $show->field('budget_program_id', __('Budget program id'));
        $show->field('company_id', __('Company id'));
        $show->field('from_id', __('From id'));
        $show->field('to_id', __('To id'));
        $show->field('details', __('Details'));
        $show->field('transfer_date', __('Transfer date'));
        $show->field('to_approved', __('To approved'));

        return $show;
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        $form = new Form(new HandoverRecord());

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

        $form->hidden('company_id', __('Company'))->default($u->company_id);
        $u = auth()->user();
        if ($form->isCreating()) {
            $form->hidden('from_id', __('From'))->default($u->id);
            //disable from
            $form->display('fro_2', __('From'))->default($u->name);
        } else {
            $form->display('fro_1', __('From'));
            //get record
            $record = HandoverRecord::find(request()->route('handover_record'));
            //check if record exists
            if ($record == null) {
                throw new \Exception('Record not found');
            }
            //check if logged in user is the owner of the record
            if ($record->to_id != $u->id) {
                //approve
                $form->radio('to_approved', __('To approved'))
                    ->options(['Yes' => 'Yes', 'No' => 'No']);
            }
        }
        $form->select('to_id', __('To'))->options(\App\Models\User::where('company_id', $u->company_id)->pluck('name', 'id'))
            ->required();


        $form->text('details', __('Details'));
        $form->datetime('transfer_date', __('Transfer date'))->default(date('Y-m-d H:i:s'));
        $form->decimal('amount', __('Amount Transfered'))
            ->required(); 


        return $form;
    }
}
