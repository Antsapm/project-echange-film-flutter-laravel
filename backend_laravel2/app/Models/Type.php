<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Type extends Model
{
    use HasFactory;
    protected $table = 'type';
    protected $fillable = [
        'label',
    ];
    public function films(){
        return $this->hasMany(Film::class, 'id_type', 'id');
    }
}
