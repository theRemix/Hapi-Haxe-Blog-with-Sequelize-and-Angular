package models;
// typedef Model = {
//   all : Void -> Dynamic
// }
class Model
{
  public static var sequelize:Dynamic;
  
  public static function register( sequelize_plugin : Dynamic ):Void
  {
    sequelize = sequelize_plugin;
  }

  private static inline function getModel( model : Class<Dynamic> ):Dynamic
  {
    return Reflect.field(sequelize.models, Reflect.field(model, 'TABLE_NAME'));
  }

  public static function all( model : Class<Dynamic> )
  {
    return getModel(model).all();
  }

  public static function findOne( model : Class<Dynamic>, id:Int )
  {
    return getModel(model).findOne( id );
  }

  public static function create( model : Class<Dynamic>, obj:Dynamic )
  {
    return getModel(model).create( obj );
  }

  public static function update( model : Class<Dynamic>, obj:Dynamic, options : { where : Dynamic } )
  {
    return getModel(model).update( obj, options );
  }

  public static function destroy( model : Class<Dynamic>, options : { where : Dynamic } )
  {
    return getModel(model).destroy( options );
  }

}