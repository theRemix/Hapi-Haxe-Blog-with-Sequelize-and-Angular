(function () { "use strict";
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var App = function() {
	var _g = this;
	this.server = hapi.Hapi.createServer();
	this.server.connection({ port : 3000});
	Plugins.register(this.server);
	this.server.route(Routes.routes);
	this.server.start(function() {
		_g.server.log("info","Server running at: " + _g.server.info.uri);
	});
};
App.main = function() {
	var app = new App();
};
var js = {};
js.Node = function() { };
var Auth = function() { };
Auth.validate = function(username,password,callback) {
	var user = Reflect.field(Auth.users,username);
	if(user == null) return callback(null,false,null);
	Auth.Bcrypt.compare(password,user.password,function(err,isValid) {
		callback(err,isValid,{ id : user.id, name : user.name});
	});
};
var HxOverrides = function() { };
HxOverrides.cca = function(s,index) {
	var x = s.charCodeAt(index);
	if(x != x) return undefined;
	return x;
};
var Plugins = function() { };
Plugins.register = function(server) {
	var goodOptions = { opsInterval : 5000, reporters : [{ reporter : js.Node.require("good-console"), args : [{ ops : "*", request : "*", log : "*", response : "*", error : "*"}]}]};
	var hapiSequelizeOpts = { database : "hapitest", username : "postgres", password : null, host : "coreos", port : 9432, dialect : "postgres", models : null, logging : false, 'native' : false, dialectOptions : { }};
	server.register([js.Node.require("hapi-auth-basic")],function(err) {
		server.auth.strategy("simple","basic",{ validateFunc : Auth.validate});
		if(err) {
			js.Node.console.error("Failed to load a plugin:",err);
			throw err;
		}
	});
	server.register([{ register : js.Node.require("good"), options : goodOptions},{ register : js.Node.require("hapi-sequelize"), options : hapiSequelizeOpts}],function(err1) {
		var sequelize_plugin = server.plugins["hapi-sequelize"];
		models.Sequelize.register(sequelize_plugin);
		if(err1) {
			js.Node.console.error("Failed to load a plugin:",err1);
			throw err1;
		}
	});
};
var Reflect = function() { };
Reflect.field = function(o,field) {
	try {
		return o[field];
	} catch( e ) {
		return null;
	}
};
Reflect.setField = function(o,field,value) {
	o[field] = value;
};
var models = {};
models.Model = function() { };
models.Model.register = function(sequelize_plugin) {
	models.Model.sequelize = sequelize_plugin;
};
models.Model.all = function(model) {
	return Reflect.field(models.Model.sequelize.models,Reflect.field(model,"TABLE_NAME")).all();
};
models.Model.findOne = function(model,id) {
	return Reflect.field(models.Model.sequelize.models,Reflect.field(model,"TABLE_NAME")).findOne(id);
};
models.Model.create = function(model,obj) {
	return Reflect.field(models.Model.sequelize.models,Reflect.field(model,"TABLE_NAME")).create(obj);
};
models.Model.update = function(model,obj,options) {
	return Reflect.field(models.Model.sequelize.models,Reflect.field(model,"TABLE_NAME")).update(obj,options);
};
models.Model.destroy = function(model,options) {
	return Reflect.field(models.Model.sequelize.models,Reflect.field(model,"TABLE_NAME")).destroy(options);
};
models.Post = function() { };
models.Post.define = function(sequelize,DataTypes) {
	return sequelize.define(models.Post.TABLE_NAME,{ id : { primaryKey : true, type : DataTypes.INTEGER.UNSIGNED, autoIncrement : true}, title : { type : DataTypes.STRING(255), allowNull : false}, body : { type : DataTypes.TEXT}, created_at : { type : DataTypes.DATE, allowNull : false, defaultValue : DataTypes.NOW()}},{ omitNull : true, timestamps : false, underscored : true});
};
models.Post.__super__ = models.Model;
models.Post.prototype = $extend(models.Model.prototype,{
});
var controllers = {};
controllers.Blog = function() { };
controllers.Blog.get_show = function() {
	return { handler : function(request,reply) {
		models.Model.findOne(models.Post,Std.parseInt(request.params.id)).then(function(post) {
			reply(post);
		},function(err) {
			reply(err);
		});
	}};
};
controllers.Blog.get_create = function() {
	return { handler : function(request,reply) {
		models.Model.create(models.Post,request.payload).then(function(posts) {
			reply(posts);
		},function(err) {
			reply(err);
		});
	}, auth : "simple"};
};
controllers.Blog.get_update = function() {
	return { handler : function(request,reply) {
		models.Model.update(models.Post,request.payload,{ where : { id : Std.parseInt(request.params.id)}}).then(function(post) {
			reply("ok");
		},function(err) {
			reply(err);
		});
	}, auth : "simple"};
};
controllers.Blog.get_destroy = function() {
	return { handler : function(request,reply) {
		models.Model.destroy(models.Post,{ where : { id : Std.parseInt(request.params.id)}}).then(function(post) {
			reply("ok");
		},function(err) {
			reply(err);
		});
	}, auth : "simple"};
};
var Std = function() { };
Std.parseInt = function(x) {
	var v = parseInt(x,10);
	if(v == 0 && (HxOverrides.cca(x,1) == 120 || HxOverrides.cca(x,1) == 88)) v = parseInt(x);
	if(isNaN(v)) return null;
	return v;
};
controllers.Root = function() { };
var Routes = function() { };
var hapi = {};
hapi.Hapi = function() { };
hapi.Hapi.createServer = function() {
	var hapi = require('hapi');
	return new hapi.Server();
};
models.Sequelize = function() { };
models.Sequelize.register = function(sequelize_plugin) {
	var _g = 0;
	var _g1 = [models.Post];
	while(_g < _g1.length) {
		var model = _g1[_g];
		++_g;
		Reflect.setField(sequelize_plugin.models,model.TABLE_NAME,model.define(sequelize_plugin.db,sequelize_plugin.db.Sequelize));
	}
	models.Model.register(sequelize_plugin);
};
var EventEmitter__0 = require("events").EventEmitter;
var Readable__1 = require("stream").Readable;
var Writable__2 = require("stream").Writable;
js.Node.console = console;
js.Node.require = require;
Auth.Bcrypt = js.Node.require("bcrypt");
Auth.users = { john : { username : "john", password : "$2a$10$iqJSHD.BGr0E2IxQwYgJmeP3NvhPrXAeLSaGCj6IR/XU5QtjVu5Tm", name : "John Doe", id : "2133d32a"}};
models.Post.TABLE_NAME = "post";
controllers.Blog.index = { handler : function(request,reply) {
	models.Model.all(models.Post).then(function(posts) {
		reply(posts);
	},function(err) {
		reply(err);
	});
	return null;
}};
controllers.Root.static_files = { handler : { directory : { path : "public"}}};
controllers.Root.login = { handler : function(request,reply) {
	reply(request.auth.credentials);
}, auth : "simple"};
Routes.routes = [{ method : "GET", path : "/api/blog", config : controllers.Blog.index},{ method : "GET", path : "/api/blog/{id}", config : controllers.Blog.get_show()},{ method : "POST", path : "/api/blog", config : controllers.Blog.get_create()},{ method : "DELETE", path : "/api/blog/{id}", config : controllers.Blog.get_destroy()},{ method : "PUT", path : "/api/blog/{id}", config : controllers.Blog.get_update()},{ method : "GET", path : "/login", config : controllers.Root.login},{ method : "GET", path : "/{path*}", config : controllers.Root.static_files}];
App.main();
})();

//# sourceMappingURL=app.js.map