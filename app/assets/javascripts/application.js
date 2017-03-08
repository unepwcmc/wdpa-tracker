//= require jquery
//= require jquery_ujs

// libraries
window.$ = window.jQuery = global.$ = require("jquery");
import "babel-polyfill";
import _ from "underscore";

// utilities
import jqueryOverrides from "utilities/jquery_overrides";

// modules
import map from "modules/map";
import select from "modules/select";
import toggle from "modules/toggle";
import blockPage from "modules/block_page";
import allocation from "modules/allocation";
import autocompletion from "modules/autocompletion";

$(document).ready( () => {
  // initial overrides for new
  // functionalities in jquery
  jqueryOverrides.overrideShow();
  jqueryOverrides.overrideHide();
  jqueryOverrides.overrideToggle();

  var $map = $("#map");
  var $infoBox = $(".js-information-box");

  if($map.length > 0 && $infoBox.length > 0) {
    new map($map, $infoBox);
  }

  new select("search");

  new toggle("set-0");
  new toggle("set-1");
  new toggle("set-2");
  new toggle("success");
  new toggle("thematic-areas");

  new blockPage("modal");

  new autocompletion("country", "/countries", "name");
  new autocompletion("allocator", "/users", "full_name");

  new allocation();
});
