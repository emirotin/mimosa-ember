> Note: the code was recently updated to support mimosa 2.0. This README is now ourdated and needs some fixes regarding `mimosa-config`. In a meanwhile check the `mimosa-config.coffee` file.

# Mimosa + Ember

This is a sample repository demonstrating how to start working with Mimosa.js and Ember.

We create a sample mimosa project and then adapt it for Ember.

## Create new project

`$ mimosa new mimosa-ember`

I choose CoffeeScript, SASS, Emblem, Server, Jade.
If you use other technologies you'll need appropriate transitions (normally quite obvious).

## Run Mimosa
`$ mimosa watch -s`

Now go to http://localhost:3000 and check that it works.

Now stop mimosa (`Ctrl+C`).

## Convert to Ember App

### Enable Mimosa Ember support

Edit `mimosa-config.coffee`:
Uncomment the `template:` section and everything below `handlebars`.

Set `ember.enabled` to `true`.

Also change `path: "vendor/ember"` to `path: "ember"` — we'll make it work soon.

### Download Ember
Go to <http://emberjs.com/> and download the **Starter Kit**. Unpack and copy `js/libs/ember-VERSION.js` and `js/libs/handlebars-VERSION.js` to your project's `assets/javascripts/vendor` directory renaming both files to simply `ember.js` and `handlebars.js`.

### Configure require.js

Create `assets/javascripts/common.coffee`:

	requirejs.config
	  #urlArgs: "b=" + ((new Date()).getTime())
	  shim:
	    handlebars:
	      deps: []
	      exports: "Handlebars"
	    ember:
	      deps: ["handlebars", "jquery"]
	      exports: "Ember"
	  paths:
	    #libs
	    jquery: "vendor/jquery"
	    handlebars: "vendor/handlebars"
	    ember: "vendor/ember"

What's going on here?

First, in `paths` section we map our libs to shorter identifiers. Now we can require them with short names like `'handlebars'`.

Second, Handlebars and Ember are not in AMD format. We define their dependencies and tell Require.js which global variables are their exports.

Now we are able to require them in our modules.

Finally, the commented line with `urlArgs` allows cache-busting but breaks debugging. So we disabled it but you may want to re-enable it at some point.

### Change `main.coffee`

Edit `assets/javascripts/main.coffee`:

	require ["common"], ->
	    require ['app/main', 'ember'], (App, Ember) ->
	        window.App = Ember.Application.create(App)

What we are doing:

1. require `common.coffee` which configures Require.js
2. require `app/main.coffee` and Ember (thanks to point 1 we are able to reference it with short name)
3. from `app/main.coffee` we'll get all models, routes, controllers, views required for our app. We pass them to Ember constructor and export created app globally

### Edit the view
Rename `assets/javascripts/app/example-view.coffee` to `app-view.coffee` — this makes more sense taking into account Ember's app structure, but is not required.

Edit its contents:

	define ['ember', 'templates'], (Ember, templates) ->
	
	  ApplicationView = Ember.View.extend
	    name: 'Emblem'
	    css: 'sass'

Explanation:

1. we require ember to load and wait for compiled templates. We are not using these templates directly though have to wait for them to be ready
2. we create Ember View
3. we attach our static data (our template language and CSS pre-processor) to the view object to be available in the template
4. we implicitly return this view object as module exports

We don't have to explicitly define our template — Ember is quite good with guessing it by name.

We'll lose one feature shown in original mimosa skeleton project: multiple templates rendered from a single view. Ember is strict at this and you can use partials so it's not a downside.

### Edit templates

#### 1. `application.emblem`

Create `assets/javascripts/app/template/application.emblem` file:

	= outlet

We have all our wrapping content in server-side Jade templates, so here we just tell Ember to include current page content.


#### 2. `index.emblem`

This is the default template rendered when you come to the site.

Rename `example.emblem` to `index.emblem` and do some edits:

	.template This is coming from a {{view.name}} template
	.helper {{example-helper}}
	= partial example_partial
	= partial another-example
	.styled And it has all been styled (poorly) using {{view.css}}

What we changed:

1. reference variables passed through `{{view.var}}`
2. for partials use special `partial` helper

#### 3. `_example_partial.emblem`

Rename `example_partial.emblem` to `_example_partial.emblem` — this is Ember's convention.

#### 4. `_another-example.emblem`

Rename `another-example.emblem` to `_another-example.emblem`.

Change:

	| And this is coming from another {{view.name}} partial that is concatenated into a single template file with the others.


### Edit helpers

Change `handlebars-helpers.coffee`:

	define ['handlebars'], (Handlebars) ->
	  Handlebars.registerHelper 'example-helper', ->
	    new Handlebars.SafeString "This is coming from a Handlebars helper function written in CoffeeScript"

The only change here — we reference Handlebars using the short path.

### `app/main.coffee`

This is the glue file that export all app's views etc. Create `assets/javascripts/app/main.coffee`:
	
	define ['app/app-view'], (ApplicationView) ->
	    App =
	        ApplicationView: ApplicationView
	        
We export an object (`App`) that references our `ApplicationView` defined in `app/app-view`.

## Run Mimosa again

##Done
