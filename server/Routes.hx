import hapi.Route;

class Routes
{
  public static var routes:Array<Route> = [
    {
      method : 'GET',
      path : '/{path*}',
      config : controllers.Root.static_files
    }
  ];
  
}