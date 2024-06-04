<?php

namespace App\Admin\Controllers;

use App\Models\ContributionRecord;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Facades\Admin;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class ContributionRecordController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'Contribution Records';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new ContributionRecord());
        $grid->disableBatchActions();
        $u = Admin::user();
        $grid->model()
            ->where('company_id', $u->company_id)
            ->orderBy('id', 'desc');
        $grid->filter(function ($filter) {
            $u = auth()->user();
            $users = \App\Models\User::where('company_id', $u->company_id)->get();
            //by treasurer
            $filter->equal('treasurer_id', __('Treasurer'))->select($users->pluck('name', 'id'));
            $filter->disableIdFilter();
            $filter->between('created_at', __('Created'))->datetime();
        });
        $grid->quickSearch('name')->placeholder('Search by name');
        $grid->column('id', __('ID'))->sortable();
        $grid->column('created_at', __('CREATED'))
            ->display(function ($created_at) {
                return date('d-m h:i:a', strtotime($created_at));
            })->sortable();

        $grid->column('budget_program_id', __('Budget program'))
            ->display(function ($budget_program_id) {
                return \App\Models\BudgetProgram::find($budget_program_id)->name;
            })->sortable()->hide();

        $grid->column('name', __('Name'))->sortable();
        $grid->column('category_id', __('Category'))
            ->sortable()
            ->editable('select', [
                'Family' => 'Family', 'Friend' => 'Friend',
                'MTK' => 'MTK'
            ]);
        $grid->column('amount', __('Amount (UGX)'))
            ->display(function ($amount) {
                return number_format($amount);
            })->sortable()
            ->totalRow(function ($amount) {
                return "<strong>" . number_format($amount) . "</strong>";
            });
        $grid->column('paid_amount', __('Amount Paid'))
            ->display(function ($paid_amount) {
                return number_format($paid_amount);
            })->sortable()
            ->totalRow(function ($paid_amount) {
                return "<strong>" . number_format($paid_amount) . "</strong>";
            });
        $grid->column('not_paid_amount', __('Pledge'))
            ->display(function ($not_paid_amount) {
                return number_format($not_paid_amount);
            })->sortable()
            ->totalRow(function ($not_paid_amount) {
                return "<strong>" . number_format($not_paid_amount) . "</strong>";
            });
        $grid->column('fully_paid', __('Fully Paid'))
            ->label([
                'Yes' => 'success',
                'No' => 'danger'
            ])->filter([
                'Yes' => 'Yes',
                'No' => 'No'
            ])->sortable();

        $grid->column('treasurer_id', __('Treasurer'))
            ->display(function ($treasurer_id) {
                return \App\Models\User::find($treasurer_id)->name;
            })->sortable()->sortable();
        $grid->column('chaned_by_id', __('Updated by'))
            ->display(function ($chaned_by_id) {
                $u = \App\Models\User::find($chaned_by_id);
                if ($u == null) {
                    $this->chaned_by_id = $this->treasurer_id;
                    $this->save();
                    return 'Unknown';
                }
                return $u->name;
            })->sortable()->hide();

        $grid->column('updated_at', __('Updated'))
            ->display(function ($updated_at) {
                return date('d-m h:i:a', strtotime($updated_at));
            })->sortable();

        //print
        $grid->column('print', __('Print'))
            ->display(function ($print) {
                $url = url('thanks?id=' . $this->id);
                return "<a href='$url' target='_blank'>Thanks</a>";
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
        $show = new Show(ContributionRecord::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('created_at', __('Created at'));
        $show->field('updated_at', __('Updated at'));
        $show->field('budget_program_id', __('Budget program id'));
        $show->field('company_id', __('Company id'));
        $show->field('treasurer_id', __('Treasurer id'));
        $show->field('chaned_by_id', __('Chaned by id'));
        $show->field('name', __('Name'));
        $show->field('amount', __('Amount'));
        $show->field('paid_amount', __('Paid amount'));
        $show->field('not_paid_amount', __('Not paid amount'));
        $show->field('fully_paid', __('Fully paid'));

        return $show;
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        $form = new Form(new ContributionRecord());
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
        //company_id
        $form->hidden('company_id')->default($u->company_id); 


        $form->text('name', __('Name of contributor'))->rules('required')->required();

        $form->select('category_id', 'Category')
            ->options([
                'Family' => 'Family',
                'Friend' => 'Friend',
                'MTK' => 'MTK'
            ])
            ->required()
            ->default('Friend');

        $form->radio('custom_amount', __('Amount (Pledge)'))
            ->options([
                '5000' => number_format(5000),
                '10000' => number_format(10000),
                '20000' => number_format(20000),
                '30000' => number_format(30000),
                '40000' => number_format(40000),
                '50000' => number_format(50000),
                '100000' => number_format(100000),
                '150000' => number_format(150000),
                '150000' => number_format(150000),
                '200000' => number_format(200000),
                'custom' => 'Custom Amount'
            ])
            ->rules('required')
            ->when('custom', function ($form) {
                $form->decimal('amount', __('Amount (UGX)'))->rules('required|numeric|min:1');
            })->attribute('type', 'number');



        /* 
                        $table->string('')->nullable();
            $table->string('custom_paid_amount')->nullable();
            */

        $form->radio('fully_paid', __('Paid Fully'))->options(['Yes' => 'Yes', 'No' => 'No'])->required()->rules('required')
            ->when('No', function ($form) {

                $form->radio('custom_paid_amount', __('Amount (Total Amount Paid)'))
                    ->options([
                        '0' => number_format(0),
                        '5000' => number_format(5000),
                        '10000' => number_format(10000),
                        '20000' => number_format(20000),
                        '30000' => number_format(30000),
                        '40000' => number_format(40000),
                        '50000' => number_format(50000),
                        '100000' => number_format(100000),
                        '150000' => number_format(150000),
                        '150000' => number_format(150000),
                        '200000' => number_format(200000),
                        'custom' => 'Custom Amount'
                    ])
                    ->rules('required')
                    ->when('custom', function ($form) {
                        $form->decimal('paid_amount', __('Total Amount Paid'))->rules('required|numeric|min:-1');
                    })->attribute('type', 'number');
            });

        //not_paid_amount

        $form->divider();
        //display created by

        $u = Admin::user();

        if (true) { //as admin  
            $form->select('treasurer_id', __('Treasurer'))->options(\App\Models\User::where('company_id', $u->company_id)->pluck('name', 'id'))
                ->required()
                ->default($u->id);
        } else {
            $form->display('created_by', __('Created by'))->with(function ($created_by) {
                return auth()->user()->name;
            });
        }


        return $form;
    }
}
