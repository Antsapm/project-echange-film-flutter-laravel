<?php

namespace App\Http\Middleware;

use Tymon\JWTAuth\Facades\JWTAuth;

use Closure;
use Illuminate\Http\Request;

class JwtMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     */
    public function handle($request, Closure $next)
    {
        try {
            $user = JWTAuth::parseToken()->authenticate();
        } catch (Exception $e) {
            if ($e instanceof TokenInvalidException) {
                return response()->json(['error' => 'Token is invalid']);
            } elseif ($e instanceof TokenExpiredException) {
                return response()->json(['error' => 'Token is expired']);
            } else {
                return response()->json(['error' => 'Authorization token not found']);
            }
        }

        return $next($request);
    }
}
