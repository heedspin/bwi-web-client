'use strict'

angular.module('bwi-web-client')
  .controller 'PacCtrl', ($scope, Pac, $stateParams, $state, $location, $analytics) ->
    type =  $state.current.name.split '.'

    $scope.loadPac = ->
      $scope.showSpinner = true

      Pac.get
        type: type
        id: $stateParams.id
        yearFilters: $scope.yearFilters
      .then (response) ->
        $scope.showSpinner = false

        cumulativeColumnConfig = [
          {
            title: 'Name'
            key: 'pac.name'
          }
          {
            title: 'Industry'
            key: 'pac.industry'
          }
          {
            title: 'Sector'
            key: 'pac.sector'
          }
          {
            title: 'Total'
            key: 'amount'
            filter: 'currency'
          }
        ]

        individualColumnConfig = [
          {
            title: 'Name'
            key: 'pac.name'
          }
          {
            title: 'Industry'
            key: 'pac.industry'
          }
          {
            title: 'Sector'
            key: 'pac.sector'
          }
          {
            title: 'Date'
            key: 'date'
            filter: 'date'
          }
          {
            title: 'Amount'
            key: 'amount'
            filter: 'currency'
          }
        ]

        filters = [
          {
            name: 'startYear'
            args: [ '$scope.selectedStartYear' ]
          }
          {
            name: 'endYear'
            args: [ '$scope.selectedEndYear' ]
          }
          {
            name: 'keyFilter'
            args: [
              'pac.industry',
              '$scope.$parent.industry.selected.name'
            ]
          }
          {
            name: 'keyFilter'
            args: [
              'pac.name',
              '$scope.filterText'
            ]
          }
        ]

        $scope.cumulativeOptions =
          data: response.cumulative
          title: 'Cumulative'
          columns: cumulativeColumnConfig
          filteredResults: []
          filters: filters

        $scope.individualOptions =
          data: response.individual
          title: 'Individual'
          columns: individualColumnConfig
          filteredResults: []
          filters: filters

    $scope.$watch 'yearFilters', $scope.loadPac, true

    $scope.$watchCollection 'individualOptions.filteredResults', (newData, oldData) ->
      $scope.graphData = newData

    $scope.clear = ->
      $scope.industry.selected = ''

    $scope.industry = ->
      $analytics.eventTrack 'Select',
        category: 'Industry Dropdown'
        label: "#{$scope.industry.selected.name} #{$location.path()}"

    $scope.exportToExcel = ->
      Pac.exportToExcel
        type: type
        id: $stateParams.id
        startYear: $scope.yearFilters.startYear
        endYear: $scope.yearFilters.endYear

    $scope.exportToImage = ($event) ->
      chart = angular
        .element($event.target)
        .closest('.row')
        .siblings('.chart')[0]

      html2canvas chart,
        onrendered: (canvas) ->
          canvas.toBlob (blob) ->
            saveAs blob, 'chart.png'
          , 'image/png'
