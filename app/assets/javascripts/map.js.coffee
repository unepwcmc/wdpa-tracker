$(document).ready( ->
  PP_API_BASE = "https://api.protectedplanet.net"
  PP_API_KEY  = "0d6d9a0bf7a82b508e0d809eb78b0904"

  $map = $("#map")
  $infoBox = $(".js-information-box")

  $map.height($infoBox.outerHeight())

  $.getJSON("#{PP_API_BASE}/v3/protected_areas/#{$map.data("wdpa-id")}?token=#{PP_API_KEY}", (data) ->

    paLayer = L.geoJson(data.protected_area.geojson)
    window.map = map = new L.Map('map', {
      scrollWheelZoom: false,
      zoomControl: true,
      center: paLayer.getBounds().getCenter(),
      zoom: 3
    })

    accessToken = 'pk.eyJ1IjoidW5lcHdjbWMiLCJhIjoiY2l6aWlhZmIyMDAyeTJ6dW83ODV3N2xiYSJ9.EKsQ1MnDY77l6asXrH5_Dw'
    L.tileLayer("https://api.mapbox.com/v4/unepwcmc.l8gj1ihl/{z}/{x}/{y}.png?access_token=#{accessToken}").addTo(map)
    paLayer.addTo(map)
    map.fitBounds(paLayer.getBounds())

  )

)
