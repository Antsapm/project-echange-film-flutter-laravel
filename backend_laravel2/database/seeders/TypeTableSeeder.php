<?php

namespace Database\Seeders;
use App\Models\Type;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class TypeTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Type::create(['label' => 'Films']);
        Type::create(['label' => 'Séries']);
        Type::create(['label' => 'Animés']);
        Type::create(['label' => 'Manga']);

    }
}
