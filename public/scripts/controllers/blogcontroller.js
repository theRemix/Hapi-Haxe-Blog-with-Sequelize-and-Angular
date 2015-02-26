angular
  .module('HapiTest')
  .controller('BlogController', function($scope, $location, BlogService) {
    
    BlogService.list().then(function (posts) {
      $scope.posts = posts.data;
    });

    $scope.commit_label = "Create Post";
    $scope.commit = function ( post ) {
      
      BlogService.create( post )
        .success( function () {
          $location.path('/');
        })
        .error( function (res_data) {
          throw res_data;
        });

    }

    $scope.destroy = function ( post ) {
      
      BlogService.destroy( post )
        .success( function () {
          $scope.posts.splice( $scope.posts.indexOf(post), 1 );
        })
        .error( function (res_data) {
          throw res_data;
        });

    }
  })
  .controller('BlogEditController', function($scope, $stateParams, $location, BlogService) {
    

    BlogService.get( $stateParams.id ).then(function (post) {
      $scope.post = post.data;
    });

    $scope.commit_label = "Update Post";
    $scope.commit = function ( post ) {
      
      BlogService.update( post )
        .success( function () {
          $location.path('/');
        })
        .error( function (res_data) {
          throw res_data;
        });

    }

  });