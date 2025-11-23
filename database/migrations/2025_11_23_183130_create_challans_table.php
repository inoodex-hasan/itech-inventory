<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('challans', function (Blueprint $table) {
            $table->id();
            $table->string('challan_number')->unique();
            $table->string('reference_number');
            $table->date('challan_date');
            $table->enum('type', ['sale', 'project']);
            $table->unsignedBigInteger('sale_id')->nullable();
            $table->unsignedBigInteger('project_id')->nullable();
            $table->unsignedBigInteger('customer_id')->nullable();
            $table->unsignedBigInteger('client_id')->nullable();
            
            // Recipient details
            $table->string('recipient_organization');
            $table->string('recipient_designation')->default('The Managing Director');
            $table->text('recipient_address');
            $table->string('attention_to')->nullable();
            $table->string('subject');
            
            // Company details
            $table->text('notes')->nullable();
            $table->string('company_name')->default('Intelligent Technology');
            $table->string('signatory_name')->default('Engr. Shamsul Alam');
            $table->string('signatory_designation')->default('Director (Technical)');
            
            $table->timestamps();
            
            $table->foreign('sale_id')->references('id')->on('sales')->onDelete('cascade');
            $table->foreign('project_id')->references('id')->on('projects')->onDelete('cascade');
        });
        
        Schema::create('challan_items', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('challan_id');
            $table->text('description');
            $table->integer('quantity')->default(1);
            $table->string('unit')->default('Piece');
            $table->timestamps();
            
            $table->foreign('challan_id')->references('id')->on('challans')->onDelete('cascade');
        });
    }

    public function down()
    {
        Schema::dropIfExists('challan_items');
        Schema::dropIfExists('challans');
    }
};