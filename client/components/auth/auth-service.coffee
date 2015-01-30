'user strict'

angular.module('bwi-web-client')
  .factory "Auth", ($cookieStore) ->
    signOut: ->
      $cookieStore.remove "X-BWI-AUTH-TOKEN"
      
    isLoggedIn: ->
      typeof($cookieStore.get("X-BWI-AUTH-TOKEN")) != 'undefined'
