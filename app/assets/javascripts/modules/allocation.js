export default class Allocation {
  constructor() {
    var $form = $("[data-allocation-form]");
    var $modal = $form.closest("[data-allocation-modal]");
    var $success = $("[data-allocation-success]");

    $form.submit(function(ev) {
      var url = $(this).attr("action");

      $.post(url, $(this).serialize(), _response => {
        $modal.hide();
        $success.show();
        $success.find();
      });

      ev.preventDefault();
    });
  }
}
