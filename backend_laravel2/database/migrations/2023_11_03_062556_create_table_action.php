<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('action', function (Blueprint $table) {
            $table->id();
            $table->string('typique')->nullable(false);
            $table->foreignId('id_film')->references('id')->on('film');
            $table->foreignId('id_user')->references('id')->on('users');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('action', function(Blueprint $table){
            $table->dropForeign(['id_film']);
        });
        Schema::table('action', function (Blueprint $table){
            $table->dropForeign('id_user');
        });
        Schema::dropIfExists('action');
    }
};
