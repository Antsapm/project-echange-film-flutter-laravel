<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Action extends Model
{
    use HasFactory;
    use HasFactory;
    protected $fillable = [
        'id_film',
        'id_user'
    ];

    public function user(){
        return $this->belongsTo(User::class, 'id_user', 'id');
    }
    public function film(){
        return $this->belongsTo(Film::class, 'id_film', 'id');
    }
}
