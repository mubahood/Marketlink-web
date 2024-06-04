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
        Schema::table('companies', function (Blueprint $table) {
            $table->string('currency')->default('USD')->nullable();
            $table->string('settings_worker_can_create_stock_item')->default('Yes')->nullable();
            $table->string('settings_worker_can_create_stock_record')->default('Yes')->nullable();
            $table->string('settings_worker_can_create_stock_category')->default('Yes')->nullable();
            $table->string('settings_worker_can_view_balance')->default('Yes')->nullable();
            $table->string('settings_worker_can_view_stats')->default('Yes')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('companies', function (Blueprint $table) {
            //
        });
    }
};
