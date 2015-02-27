import js.Node;

class Auth
{
  private static var Bcrypt = Node.require('bcrypt');
  
  private static var users = {
    john: {
      username: 'john',
      password: "$2a$10$iqJSHD.BGr0E2IxQwYgJmeP3NvhPrXAeLSaGCj6IR/XU5QtjVu5Tm",   // 'secret'
      name: 'John Doe',
      id: '2133d32a'
    }
  };

  public static function validate ( username : String, password : String, callback : Dynamic -> Bool -> Dynamic -> Void ): Void
  {  
    var user = Reflect.field(users, username);
    if (user == null) {
      return callback(null, false, null);
    }

    Bcrypt.compare(password, user.password, function (err, isValid) {
      callback(err, isValid, { id: user.id, name: user.name });
    });

  };

} 