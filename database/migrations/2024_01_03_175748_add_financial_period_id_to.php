<?php

use App\Models\FinancialPeriod;
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
        Schema::table('stock_records', function (Blueprint $table) {
            $table->foreignIdFor(FinancialPeriod::class); 
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('stock_records', function (Blueprint $table) {
            //
        });
    }
};
