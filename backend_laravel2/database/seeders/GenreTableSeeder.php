<?php

namespace Database\Seeders;

use App\Models\Genre;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class GenreTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //
        Genre::create(['label' => 'Action']);
        Genre::create(['label' => 'Aventure']);
        Genre::create(['label' => 'Commèdie']);
        Genre::create(['label' => 'Drammatique']);
        Genre::create(['label' => 'Policiers']);
        Genre::create(['label' => 'Junesse']);
        Genre::create(['label' => 'Science Ficntion']);
        Genre::create(['label' => 'Justicier']);
        Genre::create(['label' => 'Documenaire']);
        Genre::create(['label' => 'Horraire']);
        Genre::create(['label' => 'Culture']);
    }
}
