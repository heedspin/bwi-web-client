'user strict'

angular.module('bwi-web-client')
  .factory "Auth", ($cookieStore) ->
    signOut: ->
      $cookieStore.remove BWI_AUTH_TOKEN
      
    isLoggedIn: ->
      typeof($cookieStore.get(BWI_AUTH_TOKEN)) != 'undefined'
