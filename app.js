(function () { "use strict";
var App = function() {
	var _g = this;
	this.server = hapi.Hapi.createServer();
	this.server.connection({ port : 3000});
	this.server.route(Routes.routes);
	this.server.start(function() {
		_g.server.log("info","Server running at: " + _g.server.info.uri);
	});
};
App.main = function() {
	var app = new App();
};
var controllers = {};
controllers.Root = function() { };
controllers.Root.get_static_files = function() {
	return { handler : function(request,reply) {
		reply("hello haxe");
		return null;
	}};
};
var Routes = function() { };
var hapi = {};
hapi.Hapi = function() { };
hapi.Hapi.createServer = function() {
	var hapi = require('hapi');
	return new hapi.Server();
};
var EventEmitter__0 = require("events").EventEmitter;
var Readable__1 = require("stream").Readable;
var Writable__2 = require("stream").Writable;
Routes.routes = [{ method : "GET", path : "/{path*}", config : controllers.Root.get_static_files()}];
App.main();
})();
