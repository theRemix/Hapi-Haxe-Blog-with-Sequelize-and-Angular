import js.Node;
import hapi.Server;

class Plugins
{
  public static inline var HAPI_SEQUELIZE = 'hapi-sequelize';

  public static inline function register( server : Server ):Void
  {
    var goodOptions = {
      opsInterval: 5000,
      reporters: [{
        reporter: Node.require('good-console'),
        args:[{ 
          #if debug
          ops: '*',
          request: '*',
          log: '*',
          response: '*',
          #end
          error: '*'
        }]
      }]
    };

    var hapiSequelizeOpts = {
      database: 'hapitest',
      username: 'postgres',
      password: null,
      host: 'coreos',
      port: 9432,
      dialect: 'postgres',
      models: null,
      logging: false,
      native: false,
      dialectOptions: {}
    };

    server.register([
      {
        register: Node.require('good'),
        options: goodOptions
      },
      {
        register: Node.require( HAPI_SEQUELIZE ),
        options: hapiSequelizeOpts
      }
    ], function (err) {
      
      var sequelize_plugin = server.plugins[ untyped('hapi-sequelize') ];
      models.Sequelize.register( sequelize_plugin );
      
      if (err) {
        Node.console.error('Failed to load a plugin:', err);
        throw err;
      }
    });
  }
}