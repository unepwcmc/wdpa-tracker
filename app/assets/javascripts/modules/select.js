var url = require('url');

export default class Select {
  constructor (group) {
    var uri = url.parse(window.location.href, true);
    this.$trigger = $(`[data-select-trigger='${group}']`);
    this.$targets = $(`[data-select-target='${group}']`);

    this.$trigger.change(_ev => {
      this.open(this.$trigger.val());
    });

    if(typeof uri.query.search_type !== undefined) {
      this.$trigger.val(uri.query.search_type);
    }

    this.$trigger.change();
  }

  open (value) {
    this.$targets.each((_i, target) => {
      var $target = $(target);

      if($target.data("select-value") == value) {
        $target.show();
        $target.find(":input").attr("disabled", false);
      } else {
        $target.hide();
        $target.find(":input").attr("disabled", true);
      }
    });
  }
}
