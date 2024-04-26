<?php

namespace Database\Seeders;

use App\Models\Langue;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class LangueTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Langue::create(['label' => 'FRENCH']);
        Langue::create(['label' => 'TRUEFRENCH']);
        Langue::create(['label' => 'VOSTFR']);
        Langue::create(['label' => 'VOSTA']);
        Langue::create(['label' => 'ENGLISH']);
    }
}
