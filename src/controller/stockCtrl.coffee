supply
.controller "stockCtrl", ($scope, $mdDialog) ->
    $scope.infoData = null
    $scope.datas_material =
        raspberry :
            id: 1
            name: 'Raspberry'
            quantite: 3
        ethernet :
            id: 2
            name: 'Ethernet'
            quantite: 2
        estimote :
            id: 3
            name: 'Estimote beacon'
            quantite: 0
        usb :
            id : 4
            name: 'Cable usb'
            quantite : 0

    $scope.datas_user =
        user_one :
            id : 1
            name : 'User One'
            quantite : 1
            id_item : 3
            dateStart : "13-01-2015"
            dataEnd : "20-01-2015"
        user_two :
            id : 2
            name : 'User Two'
            quantite : 1
            id_item : 4
            dateStart : "13-01-2015"
            dataEnd : "20-01-2015"

    $scope.getThisMaterial = ($event, data) ->
        console.log data
        $scope.infoData = data
        parent = angular.element document.body
        $mdDialog.show
            parent : parent
            targetEvent : $event
            templateUrl : 'modal/materialModal.html'
            scope : $scope
            preserveScope: true