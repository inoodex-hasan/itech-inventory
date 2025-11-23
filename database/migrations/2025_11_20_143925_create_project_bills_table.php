<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
   Schema::create('project_bills', function (Blueprint $table) {
    $table->id();
    $table->foreignId('project_id')->constrained()->onDelete('cascade');
    $table->string('bill_number')->unique();
    $table->string('reference_number')->nullable(); 
    $table->date('bill_date');
    $table->date('due_date');
    $table->decimal('subtotal', 10, 2);
    $table->decimal('tax_amount', 10, 2);
    $table->decimal('total_amount', 10, 2);
    $table->text('notes')->nullable();
    $table->text('terms_conditions')->nullable(); 
    $table->enum('status', ['draft', 'sent', 'paid', 'overdue'])->default('draft');
    $table->timestamps();
});
        
    }

    public function down()
    {
        Schema::dropIfExists('bill_items');
    }
};