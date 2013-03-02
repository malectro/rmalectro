(function (window) {
  var App = window.App = {
    Model: {}, View: {}, Collection: {}
  };

  App.tmpl = function (name, context) {
    return JST['admin/templates/' + name](context);
  };

  $(function () {
    var AppView = App.View.App = Backbone.View.extend({

    });

    Backbone.history.start({pushState: true, root: '/admin/'});
    App.App = new App.View.App;
  });

}(window));

