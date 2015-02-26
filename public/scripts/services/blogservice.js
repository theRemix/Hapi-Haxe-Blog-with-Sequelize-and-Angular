'use strict';

angular.module('HapiTest')
  .service('BlogService', function ($http) {
    
    this.list = function ( ) {
      return $http.get('/api/blog');
    };

    this.get = function ( id ) {
      return $http.get('/api/blog/'+id);
    };

    this.create = function ( post ) {
      return $http.post('/api/blog', post);
    };

    this.update = function ( post ) {
      var id = post.id;
      delete post.id;
      delete post.created_at;
      return $http.put('/api/blog/'+id, post);
    };

    this.destroy = function ( post ) {
      return $http.delete('/api/blog/'+post.id);
    };

  });