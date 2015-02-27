package controllers;
import hapi.Route;
import models.Post;
using models.Model;

class Blog
{
  public static var index:RouteHandler = {
    handler : function ( request : Request, reply : Reply )
    {
      Post.all().then(function(posts) {
        reply(posts);
      },function (err) {
        reply(err);
      });

      return null;
    }
  }

  // this way works too
  public static var show(get,null):RouteHandler;
  public static inline function get_show():RouteHandler
  {
    return {
      handler : function ( request : Request, reply : Reply )
      {
        Post.findOne( Std.parseInt(request.params.id) ).then(function(post) {
          reply(post);
        },function (err) {
          reply(err);
        });
      }
    }
  };
  
  public static var create(get,null):RouteHandler;
  public static inline function get_create():RouteHandler
  {
    return {
      handler : function ( request : Request, reply : Reply )
      {
        Post.create(request.payload).then(function(posts) {
          reply(posts);
        },function (err) {
          reply(err);
        });
      },
      auth: 'simple'
    }
  };
  
  public static var update(get,null):RouteHandler;
  public static inline function get_update():RouteHandler
  {
    return {
      handler : function ( request : Request, reply : Reply )
      {
         Post.update(request.payload, {
          where : {
            id : Std.parseInt(request.params.id)
          }
        }).then(function(post) {
          reply("ok");
        },function (err) {
          reply(err);
        });
      },
      auth: 'simple'
    }
  };
  
  public static var destroy(get,null):RouteHandler;
  public static inline function get_destroy():RouteHandler
  {
    return {
      handler : function ( request : Request, reply : Reply )
      {
        Post.destroy({
          where : {
            id : Std.parseInt(request.params.id)
          }
        }).then(function(post) {
          reply("ok");
        },function (err) {
          reply(err);
        });
      },
      auth: 'simple'
    }
  };

}