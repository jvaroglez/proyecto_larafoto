<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class UserPasswordController extends Controller
{
    public function pass(){
        return view('user.pass');
    }

    public function update(Request $request){
        //Conseguir usuario identificado
        $user = \Auth::user();         
        //Validación del form
        $validate = $this->validate($request,[
            'password' => 'required|string|min:6|confirmed',   
        ]);
        //Tomar datos del form
        $password = $request->input('password');        
        //Asignar nuevos valores al usuario        
        $user->password = Hash::make($password);        
        //Ejecutar consulta y cambios en la BD
        $user->update();

        return redirect()->route('pass')
                         ->with(['message'=>'Contraseña actualizada correctamente']);

    }
}
