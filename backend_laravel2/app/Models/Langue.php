<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Langue extends Model
{
    use HasFactory;

    protected $table = 'langue';
    protected $fillable = [
        'label',
    ];
    public function films(){
        return $this->hasMany(Film::class, 'id_langue', 'id');
    }
}
