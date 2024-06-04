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
        Schema::table('budget_programs', function (Blueprint $table) {
            Schema::table('budget_programs', function (Blueprint $table) {
                $table->string('status')->nullable()->default('Active');
            });
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('budget_programs', function (Blueprint $table) {
            //
        });
    }
};
