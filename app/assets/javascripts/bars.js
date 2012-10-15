$(document).ready(function() {
  if($('.new_bar').length){
    checkLocation();

    $('.refresh_location').on('click', function(){
     checkLocation();
    });
  }
});

function checkLocation(){
  window.watchId = navigator.geolocation.watchPosition(openBar, positionError, {
    maximumAge: 6000,
    timeout: 1000
  });
}

function openBar(position) {
  navigator.geolocation.clearWatch(window.watchId);
  var coords = position.coords;
  $.ajax({
    url: "new.js",
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