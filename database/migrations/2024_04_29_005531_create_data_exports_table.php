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
        Schema::create('data_exports', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->bigInteger('company_id')->nullable();
            $table->bigInteger('created_by_id')->nullable();
            $table->bigInteger('treasurer_id')->nullable();
            $table->string('category_id')->nullable();
            $table->string('parameter_1')->nullable();
            $table->string('parameter_2')->nullable();
            $table->string('parameter_3')->nullable();
            $table->string('parameter_4')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('data_exports');
    }
};
