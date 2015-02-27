package controllers;
import hapi.Route;

class Root
{
  public static var static_files : RouteHandler = {
    handler : untyped {
      directory: { path: 'public' }
    }
  };

  public static var login : RouteHandler = {
    // just triggers basic auth
    handler: function (request, reply) {
      reply( request.auth.credentials );
    },
    auth: 'simple'
  };
}