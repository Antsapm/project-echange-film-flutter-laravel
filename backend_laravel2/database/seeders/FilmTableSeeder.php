<?php

namespace Database\Seeders;

use App\Models\Film;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class FilmTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Film::create(['titre' => 'Big Hero 6',
                        'id_genre' => '8',
                        'id_langue' => '1',
                        'id_type' => '3',
                        'id_user' => '1',
                        'duration' => '1h 27m',
                        'photo' => 'lib/asset/images/postera/affiche-da-Big6.jpg',
                        'Qualite' => '1024p',
                        'lien' => 'lib/asset/images/postera/affiche-da-Big6.jpg'
                    ]);
        Film::create(['titre' => 'Moi Moche et Méchant1',
                        'id_genre' => '3',
                        'id_langue' => '1',
                        'id_type' => '3',
                        'id_user' => '1',
                        'duration' => '1h 47m',
                        'photo' => 'lib/asset/images/postera/lib/asset/images/postera/affiche-da-DescreableMe1.jpg',
                        'Qualite' => '1024p',
                        'lien' => 'lib/asset/images/postera/lib/asset/images/postera/affiche-da-DescreableMe1.jpg'
                    ]);
        Film::create(['titre' => 'How to Train your Dragon',
                        'id_genre' => '2',
                        'id_langue' => '1',
                        'id_type' => '3',
                        'id_user' => '1',
                        'duration' => '1h 16m',
                        'photo' => 'lib/asset/images/postera/affiche-da-Dragon1.jpg',
                        'Qualite' => '1024p',
                        'lien' => 'lib/asset/images/postera/affiche-da-Dragon1.jpg'
                    ]);
        Film::create(['titre' => 'After EveryThins',
                        'id_genre' => '4',
                        'id_langue' => '1',
                        'id_type' => '1',
                        'id_user' => '1',
                        'duration' => '1h 43m',
                        'photo' => 'lib/asset/images/postera/affiche-film-After4.jpg',
                        'Qualite' => '1024p',
                        'lien' => 'lib/asset/images/postera/affiche-film-After4.jpg'
                    ]);
        Film::create(['titre' => 'Bruce Tout Puissant',
                        'id_genre' => '3',
                        'id_langue' => '1',
                        'id_type' => '1',
                        'id_user' => '1',
                        'duration' => '1h 48m',
                        'photo' => 'lib/asset/images/postera/affiche-film-BruceToutPuissant.jpeg',
                        'Qualite' => '720p',
                        'lien' => 'lib/asset/images/postera/affiche-film-BruceToutPuissant.jpeg'
                    ]);
        Film::create(['titre' => 'One Piece',
                        'id_genre' => '2',
                        'id_langue' => '1',
                        'id_type' => '2',
                        'id_user' => '1',
                        'duration' => '56m',
                        'photo' => 'lib/asset/images/postera/affiche-serie-onepiece.jpg',
                        'Qualite' => '1024p',
                        'lien' => 'lib/asset/images/postera/affiche-serie-onepiece.jpg'
                    ]);
    }
}
