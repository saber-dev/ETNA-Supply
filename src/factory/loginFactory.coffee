supply
.factory 'AuthentificationService', ($cookies, $q, $rootScope, md5, $location) ->

    # if not AuthentificationService.checkCookies()
    #     $location.path('/login')

    checkCookies: () ->

        userCookie =  $cookies.get '29a7e96467b69a9f5a93332e29e9b0de'
        userRole   =  $cookies.get 'd56b699830e77ba53855679cb1d252da'

        if userCookie and userRole
            return true
        else
            return false

    insertCookies: (user, role) ->
        deferred = $q.defer()
        today    = new Date()
        expired  = new Date(today)
        expired.setDate(today.getDate() + 1)
        deferred.resolve($cookies.put md5.createHash('login'), md5.createHash(user), { expires: expired }
                         $cookies.put md5.createHash('role'), md5.createHash(role), { expires: expired })
        deferred.reject(false)
        return deferred.promise

.factory 'UserService', ($http) ->
    logIn: (username, password) ->
        data = {
                 login:      username
                 password:   password
               }
        $http
            method:  'POST'
            url:     options.api.base_url + '/Users/Login'
            data:    data
            headers: {'Content-type': 'application/json'}
