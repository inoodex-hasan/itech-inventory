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
        Schema::create('daily_expenses', function (Blueprint $table) {
            $table->id();
            $table->date('date')->nullable(false);
            $table->foreignId('expense_category_id')->constrained()->onDelete('cascade');
            $table->decimal('amount', 15, 2)->nullable(false);
            $table->enum('spend_method', ['cash', 'card', 'bank_transfer'])->nullable(false);
            $table->text('remarks')->nullable();
            $table->timestamps();

            // Optional: Add index for better performance
            $table->index('date');
            $table->index('expense_category_id');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('daily_expenses');
    }
};
