<?php

namespace App\Http\Controllers;

use App\Models\Film;
use Illuminate\Http\Request;

use FFMpeg\FFMpeg;

class FilmController extends Controller
{
    public function recuperation(Request $request)
    {
        $type = \App\Models\Type::all();
        $genre = \App\Models\Genre::all();
        $langue = \App\Models\Langue::all();

        if (!$type || !$genre || !$langue) {
            return response()->json(['message' => 'Information non trouvée'], 404);
        }
        $bigInfo = ["type" => $type, "genre" => $genre, "langue" => $langue];

        return response()->json(["bigInfo" => $bigInfo], 200);
    }
    public function searchFilm_bySomethings(Request $request)
    {
        if ($request->input('titre') !== ""){
            $critere1 = $request->input('titre');
        }
        if ($request->input('type') !== ""){
            $critere2 = $request->input('type');
        }if ($request->input('genre') !== ""){
            $critere3 = $request->input('genre');
        }if ($request->input('langue') !== ""){
            $critere4 = $request->input('langue');
        }if ($request->input('user') !== ""){
            $critere5 = $request->input('user');
        }

        if (!$critere1 && !$critere2 && !$critere3 && !$critere4 && !$critere5){
            $film = \App\Models\Film::all();
        }
        if ($critere1 && !$critere2 && !$critere3 && !$critere4 && !$critere5){
            $film = \App\Models\Film::where('titre', 'LIKE', '%' . $critere1 . '%')->get();
        }

        if (!$critere1 && $critere2 && !$critere3 && !$critere4 && !$critere5){
            $film = \App\Models\Film::where('id_type', $critere2)->get();
        }

        if (!$critere1 && !$critere2 && $critere3 && !$critere4 && !$critere5){
            $film = \App\Models\Film::where('id_genre', $critere3)->get();
        }

        if (!$critere1 && !$critere2 && !$critere3 && $critere4 && !$critere5){
            $film = \App\Models\Film::where('id_langue', $critere4)->get();
        }

        if (!$critere1 && !$critere2 && !$critere3 && !$critere4 && $critere5){
            $film = \App\Models\Film::where('id_user', $critere5)->get();
        }

        if ($critere1 && $critere2 && !$critere3 && !$critere4 && !$critere5){
            $film = \App\Models\Film::where('titre', 'LIKE', '%' . $critere1 . '%')->where('id_type', $critere2)->get();
        }

        if ($critere1 && !$critere2 && $critere3 && !$critere4 && !$critere5){
            $film = \App\Models\Film::where('titre', 'LIKE', '%' . $critere1 . '%')->where('id_genre', $critere3)->get();
        }

        if ($critere1 && !$critere2 && !$critere3 && $critere4 && !$critere5){
            $film = \App\Models\Film::where('titre', 'LIKE', '%' . $critere1 . '%')->where('id_langue', $critere4)->get();
        }
        if ($critere1 && !$critere2 && !$critere3 && !$critere4 && $critere5){
            $film = \App\Models\Film::where('titre', 'LIKE', '%' . $critere1 . '%')->where('id_user', $critere5)->get();
        }

        if (!$critere1 && $critere2 && $critere3 && !$critere4 && !$critere5){
            $film = \App\Models\Film::where('id_type', $critere2)->where('id_genre', $critere3)->get();
        }
        if (!$critere1 && $critere2 && !$critere3 && $critere4 && !$critere5){
            $film = \App\Models\Film::where('id_type', $critere2)->where('id_langue', $critere4)->get();
        }
        if (!$critere1 && $critere2 && !$critere3 && !$critere4 && $critere5){
            $film = \App\Models\Film::where('id_type', $critere2)->where('id_user', $critere5)->get();
        }
        if (!$critere1 && !$critere2 && $critere3 && $critere4 && !$critere5){
            $film = \App\Models\Film::where('id_genre', $critere3)->where('id_langue', $critere4)->get();
        }

        if (!$critere1 && !$critere2 && $critere3 && !$critere4 && $critere5){
            $film = \App\Models\Film::where('id_genre', $critere2)->where('id_user', $critere5)->get();
        }
        if (!$critere1 && !$critere2 && !$critere3 && $critere4 && $critere5){
            $film = \App\Models\Film::where('id_langue', $critere2)->where('id_user', $critere5)->get();
        }
        if ($critere1 && $critere2 && $critere3 && !$critere4 && !$critere5){
            $film = \App\Models\Film::where('id_titre', $critere1)->where('id_type', $critere2)->where('id_genre', $critere3)->get();
        }
        if ($critere1 && $critere2 && !$critere3 && $critere4 && !$critere5){
            $film = \App\Models\Film::where('id_titre', $critere1)->where('id_type', $critere2)->where('id_langue', $critere4)->get();
        }
        if ($critere1 && $critere2 && !$critere3 && !$critere4 && $critere5){
            $film = \App\Models\Film::where('id_titre', $critere1)->where('id_type', $critere2)->where('id_user', $critere5)->get();
        }
        if ($critere1 && $critere2 && $critere3 && $critere4 && !$critere5){
            $film = \App\Models\Film::where('id_titre', $critere1)
                                        ->where('id_type', $critere2)
                                        ->where('id_genre', $critere3)
                                        ->where('id_langue', $critere4)
                                        ->get();
        }
        if ($critere1 && $critere2 && $critere3 && !$critere4 && $critere5){
            $film = \App\Models\Film::where('id_titre', $critere1)
                                        ->where('id_type', $critere2)
                                        ->where('id_genre', $critere3)
                                        ->where('id_user', $critere5)
                                        ->get();
        }

        if ($critere1 && $critere2 && $critere3 && $critere4 && $critere5){
            $film = \App\Models\Film::where('id_titre', $critere1)
                                        ->where('id_type', $critere2)
                                        ->where('id_genre', $critere3)
                                        ->where('id_langue', $critere4)
                                        ->where('id_user', $critere5)
                                        ->get();
        }


        if (!$film) {
            return response()->json(['message' => 'Aucun Contenu trouvé'], 404);
        }
        return response()->json(["films" => $film], 200);
    }


    public function upload(Request $request)
    {

        // $videoFullPath = storage_path('app/public/' . $videoPath);
        // $imageFullPath = storage_path('app/public/' . $imagePath);

        // // Utilisez FFMpeg pour extraire des informations de la vidéo
        // $ffmpeg = FFMpeg::create();
        // $video = $ffmpeg->open($videoFullPath);
        // $durationInSeconds = $video->getStreams()->first()->get('duration');
        // $formattedDuration = $this->formatDuration($durationInSeconds);

        // $quality = 'HD';  // Déterminez la qualité de la vidéo en fonction de vos besoins

        // Stockez ces informations dans la base de données ou utilisez-les comme vous le souhaitez
        // $film = new Film;
        // $film->titre = $request->input('titre');
        // $film->id_genre = $request->input('genre');
        // $film->id_langue = $request->input('langue');
        // $film->id_type = $request->input('type');
        // $film->id_user = $request->input('user');
        // $film->duration = "1heure 27minutes";//$formattedDuration;
        // $film->photo = $request->input('photo');//"lib/asset/images/aho.jpg";//$imageFullPath; // Remplacez par le chemin vers l'image de couverture
        // $film->qualite = "HD";//$quality;
        // $film->lien = "lib/asset/images/aho.jpg";//$videoFullPath;

        // $film->save();
        return response()->json([
            'success' => true,
            'message' => 'Le film a été ajouté avec succès.'
        ],200);
    }

    public function formatDuration($seconds)
    {
        $hours = floor($seconds / 3600);
        $minutes = floor(($seconds % 3600) / 60);

        if ($hours > 0) {
            return "$hours h $minutes min";
        } else {
            return "$minutes min";
        }
    }

}
