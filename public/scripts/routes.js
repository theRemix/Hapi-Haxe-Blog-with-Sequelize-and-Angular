'use strict';


angular.module('HapiTest', ['ui.router'])
  .config(function($stateProvider, $urlRouterProvider) {
    
    $urlRouterProvider.otherwise('/');
    
    $stateProvider
        
      .state('login', {
        url: '/login',
        controller: function ( $http, $location ) {
          $http.get('/login');
          $location.path('/');
        }
      })
      /* this doesn't work
      .state('logout', {
        url: '/logout',
        controller: function ( $http, $location ) {
          var logout_url = $location.protocol()+'://log:out@'+$location.host()+":"+$location.port()+"?bust="+Math.floor(Math.random()*999999);
          console.log('logout_url',logout_url);
          $http.get(logout_url);
          $location.path('/');
        }
      }) */
      .state('blog', {
        url: '/',
        templateUrl: 'views/blog/index.html',
        controller: 'BlogController'
      })
      .state('new_blog', {
        url: '/new',
        templateUrl: 'views/blog/form.html',
        controller: 'BlogController'
      })
      .state('edit_blog', {
        url: '/edit/:id',
        templateUrl: 'views/blog/form.html',
        controller: 'BlogEditController'
      });
        
});
 
