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
        Schema::create('film', function (Blueprint $table) {
            $table->id();
            $table->string('titre')->nullable(false);
            $table->foreignId('id_genre')->references('id')->on('genre')->onDelete('cascade');
            $table->foreignId('id_type')->references('id')->on('type')->onDelete('cascade');
            $table->foreignId('id_user')->references('id')->on('users');
            $table->string('photo')->nullable(false);;
            $table->string('duration');
            $table->foreignId('id_langue')->references('id')->on('langue');
            $table->string('qualite');
            $table->string('lien')->nullable(false);
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
        Schema::table('film', function(Blueprint $table){
            $table->dropForeign(['id_genre']);
        });
        Schema::table('film', function (Blueprint $table){
            $table->dropForeign('id_type');
        });
        Schema::table('film', function (Blueprint $table){
            $table->dropForeign('id_user');
        });
        Schema::table('film', function (Blueprint $table){
            $table->dropForeign('id_langue');
        });
        Schema::dropIfExists('film');
    }
};
