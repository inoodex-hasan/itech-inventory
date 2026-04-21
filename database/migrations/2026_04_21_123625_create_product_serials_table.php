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
        Schema::create('product_serials', function (Blueprint $table) {
            $table->id();
            $table->foreignId('product_id')->constrained()->onDelete('cascade');
            $table->foreignId('purchase_id')->nullable()->constrained()->onDelete('set null');
            $table->unsignedBigInteger('sales_item_id')->nullable(); 
            // Note: sales_items table name is 'sales_items' according to previous view_file (2025_10_14_015809_create_sale_items_table.php)
            // But sometimes it might be 'sale_items' or 'sales_items'. The migration I saw was 'sales_items'.
            $table->string('serial_number')->unique();
            $table->enum('status', ['available', 'sold', 'damaged', 'returned'])->default('available');
            $table->timestamps();

            $table->foreign('sales_item_id')->references('id')->on('sales_items')->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('product_serials');
    }
};
