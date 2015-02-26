import js.Node;
import hapi.*;

class App
{

  private var server:Server;

  public function new()
  {
    server = Hapi.createServer();
    server.connection({ port: Config.PORT });

    Plugins.register( server );

    server.route( Routes.routes );

    server.start(function(){
      server.log('info', 'Server running at: ${server.info.uri}');
    });
  }

  static public function main()
  {
    var app = new App();
  }
}