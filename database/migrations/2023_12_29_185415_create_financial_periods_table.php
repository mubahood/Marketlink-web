<?php

use App\Models\Company;
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
        Schema::create('financial_periods', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->foreignIdFor(Company::class);
            $table->string('name');
            $table->date('start_date');
            $table->date('end_date');
            $table->string('status')->default('Active');
            $table->text('description')->nullable();
            $table->bigInteger('total_investment')->default(0);
            $table->bigInteger('total_sales')->default(0);
            $table->bigInteger('total_profit')->default(0);
            $table->bigInteger('total_expenses')->default(0);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('financial_periods');
    }
};
