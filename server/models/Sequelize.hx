package models;
class Sequelize
{
  public static inline function register( sequelize_plugin : Dynamic ){
    // register each model here
    for(model in [Post]){
      Reflect.setField( sequelize_plugin.models, model.TABLE_NAME, model.define( sequelize_plugin.db, sequelize_plugin.db.Sequelize ) );
    }
    Model.register( sequelize_plugin );
  }
}