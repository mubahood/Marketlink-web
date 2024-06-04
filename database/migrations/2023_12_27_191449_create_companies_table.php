<?php

use Encore\Admin\Auth\Database\Administrator;
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
        Schema::create('companies', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->integer('owner_id');
            $table->text('name');
            $table->text('email')->nullable();
            $table->text('logo')->nullable();
            $table->text('website')->nullable();
            $table->text('about')->nullable();
            $table->string('status')->nullable();
            $table->date('license_expire')->nullable();
            $table->text('address')->nullable();
            $table->text('phone_number')->nullable();
            $table->text('phone_number_2')->nullable();
            $table->text('pobox')->nullable();
            $table->text('color')->nullable();
            $table->text('slogan')->nullable();
            $table->text('facebook')->nullable();
            $table->text('twitter')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('companies');
    }
};
