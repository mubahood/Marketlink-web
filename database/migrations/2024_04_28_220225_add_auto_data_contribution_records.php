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
        Schema::table('contribution_records', function (Blueprint $table) {
            $table->string('custom_amount')->nullable();
            $table->string('custom_paid_amount')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('contribution_records', function (Blueprint $table) {
            //
        });
    }
};
