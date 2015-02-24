package controllers;
import hapi.Route;

class Root
{
  public static var static_files(get,null):RouteHandler;
  public static inline function get_static_files():RouteHandler
  {
    return {
      handler : function ( request : Request, reply : Reply )
      {
        reply("hello haxe");
        return null;
      }
    }
  };
}