<?php

use App\Models\BudgetProgram;
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
        Schema::create('handover_records', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->foreignIdFor(BudgetProgram::class);
            $table->bigInteger('company_id')->nullable();
            $table->bigInteger('from_id')->nullable();
            $table->bigInteger('to_id')->nullable();
            $table->text('details')->nullable();
            $table->dateTime('transfer_date')->nullable();
            $table->string('to_approved')->default('No');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('handover_records');
    }
};
