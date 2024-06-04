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
        Schema::create('contribution_records', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->foreignIdFor(BudgetProgram::class); 
            $table->bigInteger('company_id')->nullable(); 
            $table->bigInteger('treasurer_id')->nullable(); 
            $table->bigInteger('chaned_by_id')->nullable(); 
            $table->text('name')->nullable();
            $table->bigInteger('amount')->nullable()->default(0);
            $table->bigInteger('paid_amount')->nullable()->default(0);
            $table->bigInteger('not_paid_amount')->nullable()->default(0);
            $table->string('fully_paid')->default('No')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('contribution_records');
    }
};
