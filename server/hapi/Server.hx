package hapi;

extern class Server
{
  public var app : Dynamic;
  public var info : {
    id : String,
    created : Date,
    started : Date,
    port : Int,
    host : String,
    address : String,
    protocol : String,
    uri : String
  };
  public var plugins : Array<Dynamic>;
  
  public function start ( ready : Void -> Void ) : Void;
  public function log( tag : String, message : String) : Void;
  public function connection( options : {
    ?host : String,          // default 'localhost'
    ?address : String,       // default 'localhost'
    ?port : Int,             // default 0
    ?uri : String,           // no default
    ?listener : Dynamic,     // no default
    ?autoListen : Bool,      // default true
    ?cache : Dynamic,        // no default
    ?labels : Array<String>, // default []
    ?tls : Dynamic,          // no default
  } ) : Void;
  public function route( routes : Array<Route> ) : Void;
  public function register( plugins : Array<Plugin>, cb : Dynamic -> Void ) : Void;
}