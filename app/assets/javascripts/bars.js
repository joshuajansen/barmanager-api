$(document).ready(function() {
  checkLocation();
});

function checkLocation(){
  window.watchId = navigator.geolocation.watchPosition(updateLocation, positionError, {
    maximumAge: 1000,
    timeout: 2000
  });
}

function updateLocation(position) {
  var coords = position.coords;
  $.ajax({
    url: "/update_location.js",
    type: 'get',
    data: {
      lat: coords.latitude,
      lng: coords.longitude
    }
  });
};

function positionError(error) {
  if (error.code === 1) {
    alert('You need to have location enabled to be open a bar.');
  }
  else if (error.code === 3) {
    alert('Fetching your location is taking too long...');
  }
  else if (error.code === 0) {
    alert('Unknown location error.');
  }
  else{
    alert('Position error');
  }
};