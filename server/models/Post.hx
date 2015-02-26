package models;
import js.Node;

class Post extends Model
{
  public static var TABLE_NAME = 'post';
  
  public static function define(sequelize:Dynamic, DataTypes:Dynamic) : Model
  {
    return sequelize.define(TABLE_NAME, {
      id: {
        primaryKey: true,
        type: DataTypes.INTEGER.UNSIGNED,
        autoIncrement: true
      },
      title: {
        type: DataTypes.STRING(255),
        allowNull: false
      },
      body: {
        type: DataTypes.TEXT
      },
      created_at: {
        type: DataTypes.DATE,
        allowNull: false,
        defaultValue: DataTypes.NOW()
      }
    },{
      omitNull : true,
      timestamps : false,
      underscored : true
    });
  }
  

}