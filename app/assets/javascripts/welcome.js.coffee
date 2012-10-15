$(document).ready ->
  $('.welcome_new_bar form.new_bar').submit ->
    window.watchId = navigator.geolocation.watchPosition(openBar, positionError, {maximumAge: 6000, timeout: 1000})
    return false
  
  openBar = (position) ->
    navigator.geolocation.clearWatch(window.watchId);
    coords = position.coords
    $.ajax
      url: "bars.js"
      type: 'post'
      data:
        lat: coords.latitude
        lng: coords.longitude
        name: $("form.new_bar #bar_name").val()
  
positionError = (error) ->
  alert 'Position error'
  alert 'You need to have location enabled to be open a bar.' if error.code == 1
  alert 'Fetching your location is taking too long...' if error.code == 3
  alert 'Unknown location error.' if error.code == 0