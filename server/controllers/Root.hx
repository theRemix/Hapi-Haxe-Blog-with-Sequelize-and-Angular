package controllers;
import hapi.Route;

class Root
{
  public static var static_files : RouteHandler = {
    handler : untyped {
      directory: { path: 'public' }
    }
  };
}