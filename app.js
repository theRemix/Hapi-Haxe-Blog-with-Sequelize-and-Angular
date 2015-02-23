(function () { "use strict";
var App = function() {
	var _g = this;
	this.server = hapi.Hapi.createServer();
	this.server.connection({ port : 3000});
	this.server.start(function() {
		_g.server.log("info","Server running at: " + _g.server.info.uri);
	});
};
App.main = function() {
	var app = new App();
};
var hapi = {};
hapi.Hapi = function() { };
hapi.Hapi.createServer = function() {
	var hapi = require('hapi');
	return new hapi.Server();
};
var EventEmitter__0 = require("events").EventEmitter;
var Readable__1 = require("stream").Readable;
var Writable__2 = require("stream").Writable;
App.main();
})();
