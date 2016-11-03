# Core Functionality

### Planning
* Wireframes
* Database relationship chart
* Write readme
* Project repo (local and github)
* Boilerplate for main files

### Database setup
* setup dev database
* users table
* user_recipes, master_recipes tables
* hops, fermentables, yeasts tables
* styles table
* join tables
* example data

### Models
* db_config
* user model
* user_recipe, master_recipe models
* hop, fermentable, yeast models
* style model
* join table models

### Views
* layout
* index (when not logged in)
* sign up page
* login page
* user home page
* user recipe page
* browse all page
* master recipe page
* new recipe page
* edit user recipe page

### Routing
GET requests:
* homepage ("/")
* user home page ("/" while logged in)
* sign up page ("/signup")
* login page ("/login")
* user recipe page ("/username/user_recipe_id")
* browse all page ("/recipes")
* master recipe page ("/recipes/master_recipe_id")
* new recipe page ("/recipes/new")
* edit user recipe ("/username/edit/user_recipe_id")

POST requests:
* login ("/login")
* sign up ("/signup")
* add new recipe ("/recipes/new")
* copy master recipe to user recipes ("/add/master_recipe_id")

PATCH requests:
* update user recipe ("/username/user_recipe_id")

DELETE requests:
* logout ("/login")
* delete user recipe ("/username/user_recipe_id")

# Further Refinements
* create helper functions for user id and login check
* alter menu options depending on user login status
* brewing math for master recipes
* brewing math for user recipes
* math for SRM
* TODO: user can add extra fermentable and hop inputs to new recipe form
* TODO: ensure user is logged in when performing CRUD operations
* TODO: input field validation on login and signup forms
* TODO: input field validation on new recipe form
* TODO: input validation on edit form
* TODO: autocomplete form fields

# Styling
* structure overall layout template
* make menu slide in when selected
* TODO: style index page
* TODO: style recipe cards
* TODO: style user homepage and browse all page
* TODO: style full user recipe
* TODO: style full master recipe
* TODO: style login and signup pages
* TODO: style new recipe page
* TODO: style edit recipe page
* TODO: media queries for larger screens
