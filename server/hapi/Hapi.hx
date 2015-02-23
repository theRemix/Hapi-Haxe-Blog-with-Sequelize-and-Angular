package hapi;
class Hapi
{
  public static function createServer() : Dynamic {
    var hapi = untyped __js__("require('hapi')");
    return untyped __js__("new hapi.Server()");
  }
}