export default class Select {
  constructor ($map, $infoBox) {
    var ppApiBase = "https://api.protectedplanet.net";
    var ppApiKey  = "0d6d9a0bf7a82b508e0d809eb78b0904";

    $map.height($infoBox.outerHeight());

    $.getJSON(
      `${ppApiBase}/v3/protected_areas/${$map.data("wdpa-id")}?token=${ppApiKey}`,
      this.handleApiData
    );
  }

  handleApiData (data) {
    var accessToken = "pk.eyJ1IjoidW5lcHdjbWMiLCJhIjoiY2l6aWlhZmIyMDAyeTJ6dW83ODV3N2xiYSJ9.EKsQ1MnDY77l6asXrH5_Dw";
    var paLayer = L.geoJson(data.protected_area.geojson);

    var map = new L.Map('map', {
      scrollWheelZoom: false,
      zoomControl: true,
      center: paLayer.getBounds().getCenter(),
      zoom: 3
    });

    L.tileLayer(`https://api.mapbox.com/v4/unepwcmc.l8gj1ihl/{z}/{x}/{y}.png?access_token=${accessToken}`).addTo(map);
    paLayer.addTo(map);
    map.fitBounds(paLayer.getBounds());
  }
}
