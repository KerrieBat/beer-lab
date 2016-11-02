## Brew Repo  
### A repository for storing, sharing, and discovering great homebrew recipes.
---

## Overview
Brew Repo is a simple CRUD application allowing users to store, share, and discover recipes for home brewing. When new recipes are added, quantities are converted to non-specific units (eg grams/Litre) and saved as a 'master copy'. When a user adds a copy of any recipe to their collection they can then adjust the total batch size and individual ingredient weights will be calculated automatically.

Users can browse all submitted recipes with various filtering options, leave comments on recipes, and 'star' their favourites.

## Technologies Used
* Ruby (Sinatra, Active Record)
* Heroku
* PostgreSQL
* JavaScript (ES6, jQuery, jQuery UI)
* HTML5
* CSS3

## Build Process
* Planning phase: [Wireframes](https://goo.gl/q01dLx), [Database Relationships](https://goo.gl/XO7244).
* Create database and tables.
* Create models.
* Create views.
* Set routes.
* Style views.
* Deploy.

## Bugs
* Calculations involving index are not always correct as active record objects are not always returned in same order. Need to refactor and use id's. 
