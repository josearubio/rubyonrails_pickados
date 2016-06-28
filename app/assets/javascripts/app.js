angular.module('userPicks', ['ui.router']).config([
'$stateProvider',
'$urlRouterProvider',
function($stateProvider, $urlRouterProvider) {

  $stateProvider
    .state('home', {
      url: '/home',
      templateUrl: '/home.html',
      controller: 'MainCtrl'
    });

    $stateProvider
    .state('picks', {
  url: '/picks/{id}',
  templateUrl: '/picks.html',
  controller: 'PicksCtrl'
});

  $urlRouterProvider.otherwise('home');
}])
.factory('picks', [function(){
  // service body
  var o = {
    picks: [{evento: 'Madrid-Barcelona', cuota: 2, seguido: 0},
    {evento: 'Lagun Aro- Estudiantes', cuota: 3, seguido: 0},
    {evento: 'Elche-Girona', cuota: 4, seguido: 0},
    {evento: 'Djokovic-Murray', cuota: 5, seguido: 0},
    {evento: 'GP Monaco', cuota: 6, seguido: 0}]
  };
  return o;
}])
.controller('MainCtrl',[
  '$scope','picks',
  function($scope, picks){
    $scope.picks= picks.picks;
    $scope.test = 'Hola mundo!';
    /**$scope.picks= [
      {evento: 'Madrid-Barcelona', cuota: 2, seguido: 0},
      {evento: 'Lagun Aro- Estudiantes', cuota: 3, seguido: 0},
      {evento: 'Elche-Girona', cuota: 4, seguido: 0},
      {evento: 'Djokovic-Murray', cuota: 5, seguido: 0},
      {evento: 'GP Monaco', cuota: 6, seguido: 0}
    ];**/
    $scope.addPick = function(){
      if(!$scope.evento || $scope.evento === '') { return; }
      $scope.picks.push({evento: $scope.evento, cuota: 4.5,seguido: 0,link: $scope.link,
        comments: [
    {author: 'Joe', body: 'Cool post!', upvotes: 0},
    {author: 'Bob', body: 'Great idea but everything is wrong!', upvotes: 0}
  ]});
      $scope.evento='';
      $scope.link='';
};
$scope.incrementFav = function(pick) {
  pick.seguido += 1;
};
  }
]).controller('PicksCtrl', [
'$scope',
'$stateParams',
'picks',
function($scope, $stateParams, picks){
  $scope.pick = picks.picks[$stateParams.id];
}]);
