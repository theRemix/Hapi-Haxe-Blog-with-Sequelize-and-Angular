package hapi;

typedef RouteHandler = {
  handler : Request -> Reply -> Void,
  ?auth: String
}

typedef Route = {
  method : String,
  path : String,
  config : RouteHandler
}

typedef Request = {
  /*
    application-specific state.
    Provides a safe place to store application data 
    without potential conflicts with the framework. 
    Should not be used by plugins 
    which should use plugins[name]
   */
  app : Dynamic,

  /*
    authentication information
   */
  auth : {
    /*
      `true` if the request has been successfully authenticated
      otherwise `false`
     */
    isAuthenticated : Bool,

    /*
      the credential object received during the authentication process.
      The presence of an object does not mean successful authentication.
     */
    credentials : Dynamic,

    /*
       an artifact object received from the authentication strategy
       and used in authentication-related actions.
     */
    artifacts : Dynamic,

    /*
      the route authentication mode.
     */
    mode : String,

    /*
      the authentication error is failed and mode set to 'try'.
     */
    error : String,

    /*
      an object used by the 'cookie' authentication scheme.
     */
    session : Dynamic
  },

  /*
    the node domain object used to protect against exceptions
    thrown in extensions, handlers and route prerequisites.
    Can be used to manually bind callback functions 
    otherwise bound to other domains.
   */
  domain : String,

  /*
    the raw request headers (references `request.raw.headers` )
   */
  headers : Dynamic,

  /*
    a unique request identifier using the format 
    '{now}:{connection.info.id}:{5 digits counter}'
   */
  id : String,

  /*
    request information
   */
  info : {
    /*
      request reception timestamp
     */
    received : Date,

    /*
      request response timestamp (0 is not responded yet)
     */
    responded : Date,

    /*
      remote client IP address
     */
    remoteAddress : String,

    /*
      remote client port
     */
    remotePort : Int,

    /*
      content of the HTTP 'Referrer' (or 'Referer') header
     */
    referrer : String,

    /*
      content of the HTTP 'Host' header (e.g. 'example.com:8080')
     */
    host : String,

    /*
      the hostname part of the 'Host' header (e.g. 'example.com')
     */
    hostname : String
  },

  /*
    the request method in lower case (e.g. 'get', 'post')
   */
  method : String,

  /*
    the parsed content-type header. Only available when payload parsing enabled and no payload error occurred
   */  
  mime : String,

  /*
    an object containing the values of params, query, and payload before any validation modifications made. 
    Only set when input validation is performed
   */  
  orig : Dynamic,

  /*
    an object where each key is a path parameter name with matching value as described in Path parameters
   */  
  params : Dynamic,

  /*
    an array containing all the path params values in the order they appeared in the path
   */  
  paramsArray : Array<String>,

  /*
    the request URI's path component
   */  
  path : String,

  /*
    the request payload based on the route `payload.output` and `payload.parse` settings
   */  
  payload : Dynamic,

  /*
    plugin-specific state. Provides a place to store and pass request-level plugin data. 
    The plugins is an object where each key is a plugin name and the value is the state
   */  
  plugins : Dynamic,

  /*
    an object where each key is the name assigned by a route prerequisites function. 
    The values are the raw values provided to the continuation function as argument. 
    For the wrapped response object, use `responses`
   */  
  pre : Dynamic,

  /*
    the response object when set. 
    The object can be modified but must not be assigned another object. 
    To replace the response with another from within an extension point, 
    use `reply(response)` to override with a different response. 
    Contains `null` when no response has been set
    e.g. when a request terminates prematurely when the client disconnects
   */  
  response : Dynamic,

  /*
    same as pre but represented as the response object created by the pre method
   */  
  preResponses : Dynamic,

  /*
    an object containing the query parameters
   */  
  query : Dynamic,

  /*
    an object containing the Node HTTP server objects. Direct interaction with these raw objects is not recommended
   */  
  raw : Dynamic,

  /*
    the node.js request object
   */  
  req : Dynamic,

  /*
    the node.js response object
   */  
  res : Dynamic,

  /*
    the route public interface
   */  
  route : {
    /*
      the route HTTP method
     */
    method : String,
    /*
      the route path
     */
    path : String,
    /*
      the route vhost option if configured
     */
    vhost : String,
    /*
      the active realm associated with the route
     */
    realm : String,
    /*
      the route options object with all defaults applied
     */
    settings : Dynamic
  },

  /*
    the server object
   */  
  server : Server,
  
  /*
    Special key reserved for plugins implementing session support.
    Plugins utilizing this key must check for null value 
    to ensure there is no conflict with another similar server
   */  
  session : String,

  /*
    an object containing parsed HTTP state information (cookies)
    where each key is the cookie name 
    and value is the matching cookie content after processing 
    using any registered cookie definition
   */  
  state : Dynamic,
  
  /*
    the parsed request URI
   */  
  url : String,
  
  /*
    Changes the request URI before 
    the router begins processing the request where
    `url` : the new request path value
    Available only in 'onRequest' extension methods.
   */
  setUrl : String -> Void,
  
  /*
    Changes the request method before 
    the router begins processing the request where
    `method` : is the request HTTP method (e.g. 'GET').
    Available only in 'onRequest' extension methods.
   */
  setMethod : String -> Void,
  
  /*
    Logs request-specific events. 
    When called, the server emits a 'request' event 
    which can be used by other listeners or plugins. 
    The arguments are:

      tags : a string or an array of strings (e.g. ['error', 'database', 'read']) 
             used to identify the event. Tags are used instead of log levels 
             and provide a much more expressive mechanism for describing and filtering events.
      data : an optional message string or object with the application data being logged.
      timestamp : an optional timestamp expressed in milliseconds. Defaults to Date.now() (now).
   */
  log : Array<String> -> Null<Dynamic> -> Null<Int> -> Void,

  /*
    Returns an array containing the events matching 
    any of the tags specified (logical OR) where:

      tags : is a single tag string or array of tag strings. 
             If no tags specified, returns all events.
      internal : filters the events to only those with a matching `event.internal` value. 
                 If true, only internal logs are included. 
                 If false, only user event are included. 
                 Defaults to all events (undefined).
   */
  getLog : Array<String> -> Bool -> Array<String>,

  /*
    Adds a request tail which has to complete before 
    the request lifecycle is complete where:

      name : an optional tail name used for logging purposes.
    
    Returns a tail function which must be called when 
    the tail activity is completed.

    Tails are actions performed throughout the request lifecycle, 
    but which may end after a response is sent back to the client. 
    For example, a request may trigger a database update which should 
    not delay sending back a response. 
    However, it is still desirable to associate the activity with 
    the request when logging it (or an error associated with it).

    When all tails completed, the server emits a 'tail' event.
   */
  tail : String -> Dynamic

}

typedef Reply = Dynamic; // -> Void;