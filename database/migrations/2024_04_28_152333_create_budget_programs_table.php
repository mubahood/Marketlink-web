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
        return;
        Schema::create('budget_programs', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->bigInteger('company_id')->nullable();
            $table->text('name')->nullable();
            $table->bigInteger('total_collected')->nullable()->default(0);
            $table->bigInteger('total_expected')->nullable()->default(0);
            $table->bigInteger('total_in_pledge')->nullable()->default(0);
            $table->bigInteger('budget_total')->nullable()->default(0);
            $table->bigInteger('budget_spent')->nullable()->default(0);
            $table->bigInteger('budget_balance')->nullable()->default(0);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('budget_programs');
    }
};
