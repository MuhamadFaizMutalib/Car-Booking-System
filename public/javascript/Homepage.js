var app = angular.module("Dashboard", []);

app.controller(
  "HomePage",
  function ($scope, $httpParamSerializer, $http, $window) {
    var storedData = sessionStorage.getItem("myData");
    $scope.studs = JSON.parse(storedData);
    console.log("Data in sessionStorage:", $scope.studs);
    console.log("Data in sessionStorage:", $scope.studs.studs.email);

    $scope.Dashboards = true;
    $scope.AddServices = false;
    $scope.Profile = false;
    $scope.MyOrders = false;
    $scope.MyOrdersxx = false;

    $scope.CreateServices = function () {
      let servs = $httpParamSerializer({
        id_user: $scope.studs.studs.id_user,
        name: $scope.studs.studs.username,
        email: $scope.studs.studs.email,
        phone: $scope.DPhone,
        car: $scope.DCar,
        plate: $scope.DPlate,
        date: $scope.Date,
      });

      console.log("data " + servs);

      $http.get("http://localhost:3000/createServs?" + servs).then(
        function (response) {
          $scope.AddServices = false;
          $scope.Dashboards = true;
          $scope.loadAllServices();
        },

        function (response) {
          // 2nd function to handle connection error
          alert("error");
        }
      );
    };

    $scope.Booking = function (tab) {
      let servsxx = $httpParamSerializer({
        id_service: tab.id_service,
        id_user: $scope.studs.studs.id_user,
        name: tab.name,
        email: tab.email,
        phone: tab.phone,
        car: tab.car,
        plate: tab.plate,
        date: tab.date,
      });

      console.log("dataBookingBook " + tab.name);

      $http.get("http://localhost:3000/createBooking?" + servsxx).then(
        function (response) {
          alert("Done Booking");
        },
        function (response) {
          // 2nd function to handle connection error
          alert("error");
        }
      );
    };

    $scope.MyOdersz = function () {
      $scope.MyOrdersxx = true;
      $scope.Dashboards = false;
      $scope.AddServices = false;
      $scope.Profile = false;
      $scope.MyOrders = false;
      let servss = $httpParamSerializer({
        id_user: $scope.studs.studs.id_user,
      });

      $http.get("http://localhost:3000/readServs?" + servss).then(
        function (response) {
          $scope.servsp = response.data;
          console.table($scope.servsp);
          let length = $scope.servsp.length;

          for (let i = 0; i < length; i++) {
            $scope.servsp[i].num = i + 1;
          }
        },

        function (response) {
          // 2nd function to handle connection error
          alert("Ajax connection error!");
        }
      );
    };

    $scope.Exit = function () {
      $scope.MyOrdersxx = false;
      $scope.Dashboards = true;
      $scope.AddServices = false;
      $scope.Profile = false;
      $scope.MyOrders = false;
    };

    $scope.loadAllServices = function () {
      $scope.Dashboards = true;
      $scope.AddServices = false;
      $scope.Profile = false;
      $scope.MyOrders = false;
      $scope.MyOrdersxx = false;

      $http.get("http://localhost:3000/readAllServsData").then(
        function (response) {
          $scope.servs = response.data;
          // console.table($scope.servs);
          let length = $scope.servs.length;

          for (let i = 0; i < length; i++) {
            $scope.servs[i].num = i + 1;
          }
        },

        function (response) {
          // 2nd function to handle connection error
          alert("Ajax connection error!");
        }
      );
    };

    $scope.logout = function () {
      // Clear session storage or perform logout actions
      sessionStorage.removeItem("myData"); // Remove the stored user data
      // Optionally, redirect the user to the login page or any other page
      $window.location.href = "/SignIn&SignUp.html"; // Redirect to the login page
    };

    $scope.ProfilePage = function () {
      $window.location.href = "/ProfilePage.html";
    };

    $scope.dashboardmenu = function () {
      $window.location.href = "/HomePage.html";
    };

    $scope.loadAllServices();
  }
);
