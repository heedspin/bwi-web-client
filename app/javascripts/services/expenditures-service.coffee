'user strict'

angular.module('bwi-web-client')
.factory "Expenditures", ($q, $http, $cookieStore, $window, bwiConfig) ->

  aggregateExpendituresData = (collection)->
    aggregateCollection = []

    for item in collection
      elected_official = item.elected_official

      existing = _.where aggregateCollection,
        id: elected_official.id

      if not existing.length
        aggregateCollection.push
          id: elected_official.id
          amount: item.amount
          elected_official: elected_official

      if existing.length is 1
        existing[0].amount += item.amount

    aggregateCollection

  urlFor = (params, format) ->
    requestUrl = "#{bwiConfig.API_URL}/#{params.type[0]}/#{params.id}/expenditures"

    requestParams =
      start_year: params.yearFilters.startYear
      end_year: params.yearFilters.endYear
      start_quarter: params.yearFilters.startQuarter
      end_quarter: params.yearFilters.endQuarter

    if format
      requestUrl += ".#{format}"
      requestParams.BWI_AUTH_TOKEN = $cookieStore.get('X-BWI-AUTH-TOKEN')

    requestUrl += ('?' + jQuery.param requestParams)

  get: (params) ->
    deferred = $q.defer()

    $http.get urlFor(params)
    .then (response) ->
      data = response.data[params.type[1]]
      cumulativeData = aggregateExpendituresData data

      deferred.resolve
        cumulative: cumulativeData
        individual: data

    deferred.promise

  exportToExcel: (params) ->
    exportUrl = urlFor(params, 'xlsx')
    $window.location.assign exportUrl
