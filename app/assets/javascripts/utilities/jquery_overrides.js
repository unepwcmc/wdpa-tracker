export default {
  overrideShow() {
    var originalShow = jQuery.fn.show;

    jQuery.fn.show = function() {
      var result = originalShow.apply(this, arguments);

      jQuery(this).trigger("shown");

      return result;
    };
  },

  overrideHide() {
    var originalHide = jQuery.fn.hide;

    jQuery.fn.hide = function() {
      var result = originalHide.apply(this, arguments);

      jQuery(this).trigger("hidden");

      return result;
    };
  },

  overrideToggle() {
    var originalToggle = jQuery.fn.toggle;

    jQuery.fn.toggle = function() {
      var result = originalToggle.apply(this, arguments);

      if(jQuery(this).is(":visible")) {
        jQuery(this).trigger("shown");
      } else {
        jQuery(this).trigger("hidden");
      }

      return result;
    };
  }
};
