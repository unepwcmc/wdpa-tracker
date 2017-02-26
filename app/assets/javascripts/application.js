// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require_self

window.$ = window.jQuery = global.$ = require("jquery");
import "babel-polyfill";
import _ from "underscore";
import map from "modules/map";
import select from "modules/select";
import autocompletion from "modules/autocompletion";

$(document).ready( () => {
  var $map = $("#map");
  var $infoBox = $(".js-information-box");

  if($map.length > 0 && $infoBox.length > 0) {
    new map($map, $infoBox);
  }

  new select("search");
  new autocompletion("country", "/countries", "name");
});
