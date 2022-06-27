<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Comment;

class CommentController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }

    public function save(Request $request)
    {
        //Validar
        $validate = $this->validate($request, [
            'image_id' => 'integer|required',
            'content' => 'string|required'
        ]);
        //Recuperar datos
        $user = \Auth::user();
        $image_id = $request->input('image_id');
        $content = $request->input('content');

        $comment = new Comment();
        $comment->user_id = $user->id;
        $comment->image_id = $image_id;
        $comment->content = $content;

        //Guardar en BD
        $comment->save();

        //Redirección
        return redirect()->route('image.detail', ['id' => $image_id])
            ->with([
                'message' => 'Comentario publicado'
            ]);
    }

    public function delete($id)
    {
        //Datos del usuario
        $user = \Auth::user();

        //Objeto del comment
        $comment = Comment::find($id);

        //Comprobar si el usuario es dueño del comentario
        if ($user && ($comment->user_id == $user->id || $comment->image->user_id == $user->id)) {
            $comment->delete();

            //Redirección
            return redirect()->route('image.detail', ['id' => $comment->image->id])
                        ->with([
                    'message' => 'Comentario eliminado'
                ]);
        }else{
            //Redirección
            return redirect()->route('image.detail', ['id' => $comment->image->id])
                        ->with([
                    'message' => 'El comentario no pudo ser eliminado'
                ]);
        }
    }
}
