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
       Schema::table('bills', function (Blueprint $table) {
    $table->foreignId('bank_detail_id')->nullable()->constrained()->onDelete('set null');
    $table->foreignId('company_detail_id')->nullable()->constrained()->onDelete('set null');
    $table->text('terms_conditions')->nullable();
    $table->string('subject')->nullable();
    $table->string('attention_to')->nullable();
});
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('bills', function (Blueprint $table) {
            //
        });
    }
};
