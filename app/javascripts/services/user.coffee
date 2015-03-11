angular.module('bwi-web-client').factory 'User', (
  RailsResource,
  bwiConfig
) ->

  class User extends RailsResource
    @configure
      name: 'user'
      url: "#{bwiConfig.API_URL}/users"

    @current: ->
      @.get 'current'

    isLiteServiceLevel: =>
      @serviceLevel == 'lite'
