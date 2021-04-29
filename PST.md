<a id="_pagetop_"></a>
#  ember-super-rentals

- [**./app**](#./app)
     - [app.js](#./app/app.js)
     - [index.html](#./app/index.html)
     - [router.js](#./app/router.js)
- [**./app/components**](#./app/components)
     - [jumbo.hbs](#./app/components/jumbo.hbs)
     - [map.hbs](#./app/components/map.hbs)
     - [map.js](#./app/components/map.js)
     - [nav-bar.hbs](#./app/components/nav-bar.hbs)
     - [rental.hbs](#./app/components/rental.hbs)
- [**./app/components/rental**](#./app/components/rental)
     - [image.hbs](#./app/components/rental/image.hbs)
     - [image.js](#./app/components/rental/image.js)
- [**./app/controllers**](#./app/controllers)
- [**./app/helpers**](#./app/helpers)
- [**./app/models**](#./app/models)
- [**./app/routes**](#./app/routes)
- [**./app/styles**](#./app/styles)
     - [app.css](#./app/styles/app.css)
- [**./app/templates**](#./app/templates)
     - [about.hbs](#./app/templates/about.hbs)
     - [application.hbs](#./app/templates/application.hbs)
     - [contact.hbs](#./app/templates/contact.hbs)
     - [index.hbs](#./app/templates/index.hbs)
- [**./config**](#./config)
     - [environment.js](#./config/environment.js)
     - [targets.js](#./config/targets.js)
---
<a id="./app"></a>
### **./app**
---
<a id="./app/app.js"></a>
###  ./app/app.js         [↑](#_pagetop_)
```js
import Application from '@ember/application';
import Resolver from 'ember-resolver';
import loadInitializers from 'ember-load-initializers';
import config from 'testapp/config/environment';

export default class App extends Application {
  modulePrefix = config.modulePrefix;
  podModulePrefix = config.podModulePrefix;
  Resolver = Resolver;
}

loadInitializers(App, config.modulePrefix);

```
---
<a id="./app/index.html"></a>
###  ./app/index.html         [↑](#_pagetop_)
```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Ember-Super-Rentals</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    {{content-for "head"}}

    <link integrity="" rel="stylesheet" href="{{rootURL}}assets/vendor.css">
    <link integrity="" rel="stylesheet" href="{{rootURL}}assets/testapp.css">

    {{content-for "head-footer"}}
  </head>
  <body>
    {{content-for "body"}}

    <script src="{{rootURL}}assets/vendor.js"></script>
    <script src="{{rootURL}}assets/testapp.js"></script>

    {{content-for "body-footer"}}
  </body>
</html>

```
---
<a id="./app/router.js"></a>
###  ./app/router.js         [↑](#_pagetop_)
```js
import EmberRouter from '@ember/routing/router';
import config from 'testapp/config/environment';

export default class Router extends EmberRouter {
  location = config.locationType;
  rootURL = config.rootURL;
}

Router.map(function () {
  this.route('about');
  this.route('contact', { path: '/getting-in-touch' });
});


```
---
<a id="./app/components"></a>
### **./app/components**
---
<a id="./app/components/jumbo.hbs"></a>
###  ./app/components/jumbo.hbs         [↑](#_pagetop_)
```hbs
<div class="jumbo">
  <div class="right tomster"></div>
  {{yield}}
</div>

```
---
<a id="./app/components/map.hbs"></a>
###  ./app/components/map.hbs         [↑](#_pagetop_)
```hbs
<div class="map">
  <img
    alt="Map image at coordinates {{@lat}},{{@lng}}"
    ...attributes
    src="https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/{{@lng}},{{@lat}},{{@zoom}}/{{@width}}x{{@height}}@2x?access_token={{this.token}}"
    width={{@width}} height={{@height}}
  >
</div>

```
---
<a id="./app/components/map.js"></a>
###  ./app/components/map.js         [↑](#_pagetop_)
```js
import Component from '@glimmer/component';
//import ENV from 'super-rentals/config/environment';
import ENV from '../config/environment';

export default class MapComponent extends Component {
  get token() {
    return encodeURIComponent(ENV.MAPBOX_ACCESS_TOKEN);
  }
}

```
---
<a id="./app/components/nav-bar.hbs"></a>
###  ./app/components/nav-bar.hbs         [↑](#_pagetop_)
```hbs
<nav class="menu">
  <LinkTo @route="index" class="menu-index">
    <h1>SuperRentals</h1>
  </LinkTo>
  <div class="links">
    <LinkTo @route="about" class="menu-about">
      About
    </LinkTo>
    <LinkTo @route="contact" class="menu-contact">
      Contact
    </LinkTo>
  </div>
</nav>

```
---
<a id="./app/components/rental.hbs"></a>
###  ./app/components/rental.hbs         [↑](#_pagetop_)
```hbs
<article class="rental">
   <Rental::Image
    src="https://upload.wikimedia.org/wikipedia/commons/c/cb/Crane_estate_(5).jpg"
    alt="A picture of Grand Old Mansion"
  />
  <div class="details">
    <h3>Grand Old Mansion</h3>
    <div class="detail owner">
      <span>Owner:</span> Veruca Salt
    </div>
    <div class="detail type">
      <span>Type:</span> Standalone
    </div>
    <div class="detail location">
      <span>Location:</span> San Francisco
    </div>
    <div class="detail bedrooms">
      <span>Number of bedrooms:</span> 15
    </div>
  </div>
    <Map
    @lat="37.7749"
    @lng="-122.4194"
    @zoom="9"
    @width="150"
    @height="150"
    alt="A map of Grand Old Mansion"
  />
</article>


```
---
<a id="./app/components/rental"></a>
### **./app/components/rental**
---
<a id="./app/components/rental/image.hbs"></a>
###  ./app/components/rental/image.hbs         [↑](#_pagetop_)
```hbs
{{#if this.isLarge}}
  <button type="button" class="image large" {{on "click" this.toggleSize}}>
    <img ...attributes>
    <small>View Smaller</small>
  </button>
{{else}}
  <button type="button" class="image" {{on "click" this.toggleSize}}>
    <img ...attributes>
    <small>View Larger</small>
  </button>
{{/if}}


```
---
<a id="./app/components/rental/image.js"></a>
###  ./app/components/rental/image.js         [↑](#_pagetop_)
```js
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';

export default class RentalImageComponent extends Component {
  @tracked isLarge = false;

  @action toggleSize() {
    this.isLarge = !this.isLarge;
  }

}

```
---
<a id="./app/controllers"></a>
### **./app/controllers**
---
<a id="./app/helpers"></a>
### **./app/helpers**
---
<a id="./app/models"></a>
### **./app/models**
---
<a id="./app/routes"></a>
### **./app/routes**
---
<a id="./app/styles"></a>
### **./app/styles**
---
<a id="./app/styles/app.css"></a>
###  ./app/styles/app.css         [↑](#_pagetop_)
```css
@import url(https://fonts.googleapis.com/css?family=Lato:300,300italic,400,700,700italic);

/**
 * Base Elements
 */

* {
  margin: 0;
  padding: 0;
}

body,
h1,
h2,
h3,
h4,
h5,
h6,
p,
div,
span,
a,
button {
  font-family: 'Lato', 'Open Sans', 'Helvetica Neue', 'Segoe UI', Helvetica, Arial, sans-serif;
  line-height: 1.5;
}

body {
  background: #f3f3f3;
}

a {
  color: #016aba;
  text-decoration: none;
}

button {
  font-size: 100%;
}

p {
  line-height: 1.5;
  margin-bottom: 15px;
}

/**
 * Button
 */

.button {
  padding: 10px 30px 10px;
  text-decoration: none;
  color: #fff;
  background: #016aba;
  border-radius: 5px;
  border: none;
  font-size: 20px;
  font-weight: bold;
  opacity: 0.9;
  display: inline-block;
}

.button:hover {
  opacity: 1;
}
/**
 * Body Container
 */

.container {
  max-width: 1024px;
  min-height: 100vh;
  background: #f9f9f9;
  margin: 0 auto;
}
/**
 * Top Navigation
 */

.menu {
  height: 4em;
  background-color: #677ae4;
  background-color: #05526A;
  background-color: #e46855;
}

.menu h1 {
  position: relative;
  padding: 5px 0 0 8px;
  color: #f9f9f9;
  font-size: 1.8em;
  font-style: italic;
}

.menu a,
.menu .links {
  display: inline-block;
}

.menu a {
  text-decoration: none;
  padding: 0 15px;
  color: #fff;
  font-size: 20px;
  font-weight: bold;
}

.menu a:hover,
.menu a.active {
  opacity: 1;
}

.menu .links {
  padding: 0 21px;
}

.menu .links a {
  position: relative;
  bottom: 5px;
}

.rentals label span {
  font-size: 140%;
  margin: 50px auto 20px;
  display: block;
  text-align: center;
  font-style: italic;
}

.rentals input {
  padding: 11px;
  font-size: 18px;
  width: 500px;
  margin: 20px auto 50px;
  background-color: rgba(255, 255, 255, 0.75);
  border: solid 1px lightgray;
  display: block;
}

.menu input:focus {
  background-color: #f9f9f9;
  outline: none;
}

.menu button {
  margin-right: 15px;
  position: relative;
  top: -1px;
  left: -5px;
  border-top-left-radius: 0;
  border-bottom-left-radius: 0;
  background-color: #262626;
  cursor: pointer;
  opacity: 1;
}

.menu button:hover {
  background-color: #111;
  opacity: 1;
}

.menu .results {
  display: none;
  position: absolute;
  width: 215px;
  top: 54px;
  left: 10px;
  background-color: #f6f6f6;
  border-right: 1px solid rgba(0, 0, 0, 0.05);
  border-bottom: 1px solid rgba(0, 0, 0, 0.05);
}

.results {
  margin-top: -10px;
}

.results li {
  list-style: none;
  padding: 10px 15px;
}

.menu .results li:hover {
  background: #f3f3f3;
}
/**
 * Content Area
 */

.body {
  padding: 15px;
}
/**
 * Similar to Jumbotron
 */

.jumbo {
  padding: 50px;
  background: #f6f6f6;
}

.jumbo:hover {
  background-color: #f3f3f3;
}

.jumbo h2 {
  font-size: 3.2em;
  margin-top: -25px;
}

.jumbo p,
.jumbo address {
  margin-bottom: 25px;
}

.jumbo img {
  height: 200px;
  position: relative;
  top: -25px;
  right: -20px;
}

/**
 * Individual Rental Listing
 */

.rental {
  margin-top: 15px;
  background-color: #f6f6f6;
  padding: 20px 25px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
}

.rental:hover {
  background-color: #f3f3f3;
}

.rental img {
  border-radius: 5px;
}

.rental .image {
  flex-grow: 0;
  flex-basis: 150px;
  margin: 20px 25px;
  text-align: center;
}

.rental button.image {
  position: relative;
  cursor: pointer;
  border: none;
  background: transparent;
  z-index: 1;
}

.rental button.image:focus {
  outline: none;
}

.rental button.image:after {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: -1;
  margin: -20px;
  padding: 20px;
  border-radius: 5px;
  background: #016aba;
  opacity: 0;
  transition: opacity 0.25s ease-in-out;
}

.rental button.image:focus:after, .rental button.image:hover:after {
  opacity: 0.1;
}

.rental .image img {
  max-width: 100%;
}

.rental .image.large {
  margin: 30px 25px 50px 25px;
  flex-basis: 100%;
}

.rental .image small {
  display: block;
  margin-top: 5px;
  margin-bottom: -15px;
  text-align: center;
  color: #016aba;

  /* This is needed to fix a safari clipping issue */
  position: relative;
}

.rental .image.large small {
  margin-top: 10px;
  margin-bottom: 0px;
  font-size: 110%;
}

.rental .details {
  flex-basis: 50%;
  flex-grow: 2;
  display: flex;
  height: 150px;
  margin: 20px 25px;
  justify-content: space-between;
  flex-wrap: wrap;
  align-content: space-around;
}

.rental h3 {
  flex-basis: 100%;
}

.rental h3 a {
  display: inline;
}

.rental .detail {
  flex-basis: 50%;
  font-weight: 300;
  font-style: italic;
  white-space: nowrap;
}

.rental .detail span {
  font-weight: 400;
  font-style: normal;
}

.rental .map {
  flex-grow: 0;
  flex-basis: 150px;
  font-size: 0;
  margin: 0px 25px;
}

.rental .map img {
  width: 150px;
  height: 150px;
}

.rental.detailed {
  background: none;
  align-items: flex-start;
}

.rental.detailed .image {
  flex-basis: 320px;
}

.rental.detailed .image.large {
  margin: 30px 25px 50px 25px;
  flex-basis: 100%;
}

.rental.detailed .details {
  height: auto;
}

.rental.detailed h3 {
  font-size: 200%;
  margin-bottom: 10px;
}

.rental.detailed .detail {
  margin: 5px 0px;
  flex-basis: 100%;
  flex-shrink: 2;
}

.rental.detailed .description {
  white-space: normal;
  flex-basis: 100%;
  flex-shrink: 1;
}

.rental.detailed .map {
  flex-basis: 100%;
  margin: 50px 25px 25px 25px;
}

.rental.detailed .map img {
  width: 100%;
  height: auto;
}

@media only screen and (max-width: 919px) {
  .rental.detailed .image, .rental.detailed .image.large {
    margin: 30px 25px 25px 25px;
    flex-basis: 100%;
    cursor: default;
  }

  .rental.detailed .image:hover {
    flex-basis: 100%;
    cursor: default;
  }

  .rental.detailed .image small {
    display: none;
  }

  .rental.detailed button.image:hover:after {
    opacity: 0;
  }

  .rental.detailed button.image:focus:after {
    opacity: 0.1;
  }

  .rental.detailed .map {
    margin-top: 25px;
  }
}

/**
 * Utilities
 */

.light {
  font-weight: 300;
}

.left {
  float: left;
}

.right {
  float: right;
}

.hidden {
  display: none;
}

.relative {
  position: relative;
}

.tomster {
  background: url(../assets/images/teaching-tomster.png);
  background-size: contain;
  background-repeat: no-repeat;
  height: 200px;
  width: 200px;

  position: relative;
  top: -25px;
}

.screen-reader{
  position: absolute;
  overflow: hidden;
  clip: rect(0 0 0 0);
  height: 1px; width: 1px;
  margin: -1px; padding: 0; border: 0;
}

```
---
<a id="./app/templates"></a>
### **./app/templates**
---
<a id="./app/templates/about.hbs"></a>
###  ./app/templates/about.hbs         [↑](#_pagetop_)
```hbs
<Jumbo>
  <h2>About Super Rentals</h2>
  <p>
    The Super Rentals website is a delightful project created to explore Ember.
    By building a property rental site, we can simultaneously imagine traveling
    AND building Ember applications.
  </p>
  <LinkTo @route="contact" class="button">Contact Us</LinkTo>
</Jumbo>

```
---
<a id="./app/templates/application.hbs"></a>
###  ./app/templates/application.hbs         [↑](#_pagetop_)
```hbs
<div class="container">
  <NavBar />
  <div class="body">
    {{outlet}}
  </div>
</div>

```
---
<a id="./app/templates/contact.hbs"></a>
###  ./app/templates/contact.hbs         [↑](#_pagetop_)
```hbs
<Jumbo>
  <h2>Contact Us</h2>
  <p>
    Super Rentals Representatives would love to help you<br>
    choose a destination or answer any questions you may have.
  </p>
  <address>
    Super Rentals HQ
    <p>
      1212 Test Address Avenue<br>
      Testington, OR 97233
    </p>
    <a href="tel:503.555.1212">+1 (503) 555-1212</a><br>
    <a href="mailto:superrentalsrep@emberjs.com">superrentalsrep@emberjs.com</a>
  </address>
  <LinkTo @route="about" class="button">About</LinkTo>
  <LinkTo @route="index" class="button">Top</LinkTo>

</Jumbo>

```
---
<a id="./app/templates/index.hbs"></a>
###  ./app/templates/index.hbs         [↑](#_pagetop_)
```hbs
<Jumbo>
  <h2>Welcome to Super Rentals!</h2>
  <p>We hope you find exactly what you're looking for in a place to stay.</p>
    <LinkTo @route="about" class="button">About Us</LinkTo>

</Jumbo>
<div class="rentals">
  <ul class="results">
    <li><Rental /></li>
    <li><Rental /></li>
    <li><Rental /></li>
  </ul>
</div>


```
---
<a id="./config"></a>
### **./config**
---
<a id="./config/environment.js"></a>
###  ./config/environment.js         [↑](#_pagetop_)
```js
'use strict';

module.exports = function (environment) {
  let ENV = {
    modulePrefix: 'testapp',
    environment,
    rootURL: '/',
    locationType: 'auto',
    EmberENV: {
      FEATURES: {
        // Here you can enable experimental features on an ember canary build
        // e.g. EMBER_NATIVE_DECORATOR_SUPPORT: true
      },
      EXTEND_PROTOTYPES: {
        // Prevent Ember Data from overriding Date.parse.
        Date: false,
      },
    },

    APP: {
      // Here you can pass flags/options to your application instance
      // when it is created
    },
  };

  if (environment === 'development') {
    // ENV.APP.LOG_RESOLVER = true;
    // ENV.APP.LOG_ACTIVE_GENERATION = true;
    // ENV.APP.LOG_TRANSITIONS = true;
    // ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
    // ENV.APP.LOG_VIEW_LOOKUPS = true;
  }

  if (environment === 'test') {
    // Testem prefers this...
    ENV.locationType = 'none';

    // keep test console output quieter
    ENV.APP.LOG_ACTIVE_GENERATION = false;
    ENV.APP.LOG_VIEW_LOOKUPS = false;

    ENV.APP.rootElement = '#ember-testing';
    ENV.APP.autoboot = false;
  }

  if (environment === 'production') {
    // here you can enable a production-specific feature
  }

  ENV.MAPBOX_ACCESS_TOKEN = 'pk.eyJ1IjoiZGV2ZzExMjAiLCJhIjoiY2tvMnR0YzNoMTJ3YjJvazR6cnRnZ3Z5biJ9.zu_HVPjKR0K73SWaQd6Bqg';

  return ENV;
};

```
---
<a id="./config/targets.js"></a>
###  ./config/targets.js         [↑](#_pagetop_)
```js
'use strict';

const browsers = [
  'last 1 Chrome versions',
  'last 1 Firefox versions',
  'last 1 Safari versions',
];

const isCI = Boolean(process.env.CI);
const isProduction = process.env.EMBER_ENV === 'production';

if (isCI || isProduction) {
  browsers.push('ie 11');
}

module.exports = {
  browsers,
};

```
