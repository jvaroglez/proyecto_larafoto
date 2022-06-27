<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Like;

class LikeController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }

    public function like($image_id)
    {
        //Datos del usuario
        $user = \Auth::user();

        //Ver si ya existe el like
        $isset_like = Like::where('user_id', $user->id)
            ->where('image_id', $image_id)
            ->count();

        if ($isset_like == 0) {
            $like = new Like();
            $like->user_id = $user->id;
            $like->image_id = (int)$image_id;

            //Guardar
            $like->save();

            return response()->json([
                'like' => $like
            ]);
        }else{
            return response()->json([
                'message' => 'Ya diste like'
            ]);
        }
    }

    public function dislike($image_id){
        //Datos del usuario
        $user = \Auth::user();

        //Ver si ya existe el like
        $like = Like::where('user_id', $user->id)
            ->where('image_id', $image_id)
            ->first();

        if ($like) {
            //Eliminar like
            $like->delete();

            return response()->json([
                'like' => $like,
                'message' => 'Quitaste tu like'
            ]);
        }else{
            return response()->json([
                'message' => 'No diste like'
            ]);
        }
    }
}
