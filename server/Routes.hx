import hapi.Route;

class Routes
{
  public static var routes:Array<Route> = [
    {
      method: 'GET',
      path: '/api/blog',
      config: controllers.Blog.index
    },
    {
      method: 'GET',
      path: '/api/blog/{id}',
      config: controllers.Blog.show
    },
    {
      method: 'POST',
      path: '/api/blog',
      config: controllers.Blog.create
    },
    {
      method: 'DELETE',
      path: '/api/blog/{id}',
      config: controllers.Blog.destroy
    },
    {
      method: 'PUT',
      path: '/api/blog/{id}',
      config: controllers.Blog.update
    },
    {
      method : 'GET',
      path : '/{path*}',
      config : controllers.Root.static_files
    },
  ];
  
}