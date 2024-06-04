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
        Schema::create('stock_categories', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->foreignIdFor(Company::class);
            $table->text('name');
            $table->text('description')->nullable();
            $table->string('status')->nullable()->default('active');
            $table->text('image')->nullable();
            $table->bigInteger('buying_price')->nullable()->default(0);
            $table->bigInteger('selling_price')->nullable()->default(0);
            $table->bigInteger('expected_profit')->nullable()->default(0);
            $table->bigInteger('earned_profit')->nullable()->default(0);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('stock_categories');
    }
};
