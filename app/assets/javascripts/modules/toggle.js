export default class Toggle {
  constructor (group) {
    var $triggers = $(`[data-toggle-trigger='${group}']`);
    var $targets = $(`[data-toggle-target='${group}']`);

    $triggers.click((ev) => {
      ev.preventDefault();
      $targets.toggle();
    });
  }
}
