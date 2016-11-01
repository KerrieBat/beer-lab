## Planning
* Wireframes
* Database relationship chart
* Write readme
* Project repo (local and github)
* Boilerplate for main files

## Database setup
* setup dev database
* users table
* user_recipes, master_recipes tables
* hops, fermentables, yeasts tables
* styles table
* join tables
* example data

## Models
* db_config
* user model
* user_recipe, master_recipe models
* hop, fermentable, yeast models
* style model

## Views
* layout
* index (when not logged in)
* sign up page
* login page
* user home page
* TODO: user recipe page
* TODO: browse all page
* TODO: master recipe page
* TODO: new recipe page

## Routing
GET requests:
* homepage ("/")
* user home page ("/" while logged in)
* sign up page ("/signup")
* login page ("/login")
* TODO: user recipe page ("/username/user_recipe_id")
* TODO: browse all page ("/recipes")
* TODO: master recipe page ("/recipes/master_recipe_id")
* TODO: new recipe page ("/recipes/new")

POST requests:
* login ("/login")
* sign up ("/signup")
* TODO: add new recipe ("/recipes/new")
* TODO: copy master recipe to user recipes ("/username/new")

PATCH requests:
* TODO: update user recipe ("/username/user_recipe_id")

DELETE requests:
* logout ("/login")
* TODO: delete user recipe ("/username/user_recipe_id")

## Styling
* 
