<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Genre extends Model
{
    use HasFactory;

    protected $table = 'genre';
    protected $fillable = [
        'label',
    ];
    public function films(){
        return $this->hasMany(Film::class, 'id_genre', 'id');
    }
}
