require ["common"], ->
    require ['app/main', 'ember'], (App, Ember) ->
        window.App = Ember.Application.create(App)
