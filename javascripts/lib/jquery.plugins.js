(function ($) {
  $.fn.serializeObject = function () {
    var ob = {};
    _.each(this.serializeArray(), function (field) {
      ob[field.name] = field.value;
    });
    return ob;
  };
}(jQuery))

