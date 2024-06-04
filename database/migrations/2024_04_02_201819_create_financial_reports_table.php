<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('financial_reports', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->bigInteger('company_id')->nullable();
            $table->bigInteger('user_id')->nullable();
            $table->string('type')->nullable();
            $table->string('period_type')->nullable();
            $table->date('start_date')->nullable();
            $table->date('end_date')->nullable();
            $table->string('currency')->nullable();
            $table->string('file_generated')->nullable()->default('no');
            $table->text('file')->nullable();
            $table->decimal('total_income', 15, 2)->nullable();
            $table->decimal('total_expense', 15, 2)->nullable();
            $table->decimal('profit', 15, 2)->nullable();
            $table->string('include_finance_accounts')->nullable();
            $table->string('include_finance_records')->nullable();
            $table->decimal('inventory_total_buying_price', 15, 2)->nullable();
            $table->decimal('inventory_total_selling_price', 15, 2)->nullable();
            $table->decimal('inventory_total_expected_profit', 15, 2)->nullable();
            $table->decimal('inventory_total_earned_profit', 15, 2)->nullable();
            $table->string('inventory_include_categories')->nullable();
            $table->string('inventory_include_sub_categories')->nullable();
            $table->string('inventory_include_products')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('financial_reports');
    }
};
