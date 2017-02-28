var _ = require("underscore");

export default class Autocompletion {
  constructor(group, url, property) {
    this.$inputEl = $(`[data-autocompletion-trigger='${group}']`);
    this.$targetEl = $(`[data-autocompletion-target='${group}']`);

    $.getJSON(url, (data) => {
      this.data = data.map((obj) => obj[property]);
    });

    this.$inputEl.on("change keyup paste click", () => this.populateAutocomplete());
    this.$targetEl.hide();
  }

  populateAutocomplete () {
    var textInput = this.$inputEl.val();
    if(textInput.length < 3) {
      this.$targetEl.hide();
      return false;
    }

    var re = new RegExp(`^${textInput}| ${textInput}`, "i");
    var foundMatches = _.filter(this.data, str => re.test(str) && str !== textInput);

    if(foundMatches.length > 0) {
      this.$targetEl.empty();

      _.each(foundMatches, str => {
        var $suggestion = $(`<p class="search__autocompletion-result">${str}</p>`);
        $suggestion.mouseup((_ev) => this.fillInSuggestion(str));

        this.$targetEl.append($suggestion);
      });

      this.$targetEl.show();
    } else {
      console.log("not found");
      this.$targetEl.hide();
    }
  }

  fillInSuggestion(suggestion) {
    this.$inputEl.val(suggestion);
    this.$targetEl.hide();
  }
}
