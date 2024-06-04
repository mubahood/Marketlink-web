<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;

use Encore\Admin\Auth\Database\Administrator;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Administrator
{
    use HasApiTokens, HasFactory, Notifiable;


    protected $table = 'admin_users';

    //company
    public function company()
    {
        return $this->belongsTo(Company::class, 'company_id');
    }

    //boot
    protected static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            $name = "";
            if ($model->first_name != null && strlen($model->first_name) > 0) {
                $name = $model->first_name;
            }
            if ($model->last_name != null && strlen($model->last_name) > 0) {
                $name .= " " . $model->last_name;
            }
            $name = trim($name);

            if ($name != null && strlen($name) > 0) {
                $model->name = $name;
            }
            $model->username = $model->email;

            if ($model->password == null || strlen($model->password) < 3) {
                $model->password = bcrypt('admin');
            }
            return $model;
        });


        static::updating(function ($model) {
            $name = "";
            if ($model->first_name != null && strlen($model->first_name) > 0) {
                $name = $model->first_name;
            }
            if ($model->last_name != null && strlen($model->last_name) > 0) {
                $name .= " " . $model->last_name;
            }
            $name = trim($name);

            if ($name != null && strlen($name) > 0) {
                $model->name = $name;
            }
            $model->username = $model->email;
            return $model;
        });
    }


    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'email',
        'password',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
    ];
}
