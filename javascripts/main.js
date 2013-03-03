(function () {
  window.MyApp = {
    Model: {}, View: {}, List: {}
  };

  MyApp.tmpl = function (name, context) {
    return JST['templates/' + name](context);
  };

  $(function () {
    var App = Backbone.View.extend({
      el: $('body'),

      $window: $(window),

      events: {
      },

      initialize: function () {
      },

      clear: function () {
      }
    });

    MyApp.App = new App;
  });
}());

