<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Film extends Model
{
    use HasFactory;

    protected $table = 'film';
    protected $fillable = [
        'titre',
        'id_genre',
        'id_langue',
        'id_type',
        'id_user',
        'duration',
        'photo',
        'qualite',
        'lien',

    ];
    public function type(){
        return $this->belongsTo(Type::class, 'id_type', 'id');
    }

    public function genre(){
        return $this->belongsTo(Genre::class, 'id_genre', 'id');
    }

    public function langue(){
        return $this->belongsTo(Langue::class, 'id_langue', 'id');
    }
    public function user(){
        return $this->belongsTo(User::class, 'id_user', 'id');
    }

    public function actions(){
        return $this->hasMany(Action::class, 'id_film', 'id');
    }
}
