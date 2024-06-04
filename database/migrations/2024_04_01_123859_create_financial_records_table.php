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
        Schema::create('financial_records', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->bigInteger('financial_category_id')->nullable();
            $table->bigInteger('company_id')->nullable();
            $table->bigInteger('user_id')->nullable();
            $table->bigInteger('amount')->nullable();
            $table->bigInteger('quantity')->nullable();
            $table->string('type')->nullable();
            $table->text('payment_method')->nullable();
            $table->text('recipient')->nullable();
            $table->text('description')->nullable();
            $table->text('receipt')->nullable();
            $table->date('date')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('financial_records');
    }
};
