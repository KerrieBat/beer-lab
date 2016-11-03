// Global variables:
var fCounter = 1;
var hCounter = 1;

// jQuery objects:
var $menuBtn = $('.menu').first();
var $menuWrapperDiv = $('.menu-wrapper').first();
var $closeMenuBtn = $('.close').first();
var $pageWrapperDiv = $('.page-wrapper').first();
var $fermentableAddBtn = $('.fermentable-add').first();
var $hopAddBtn = $('.hop-add').first();

// Event Listeners:
$menuBtn.click( function() {
  $('.page-wrapper').scrollTop(0);
  $menuWrapperDiv.css("left", 0);
  $pageWrapperDiv.css("overflow-y", "hidden");
});

$closeMenuBtn.click( function() {
  $menuWrapperDiv.css("left", "100%");
  $pageWrapperDiv.css("overflow-y", "auto");
});

$fermentableAddBtn.click(addFermentableInput);
$hopAddBtn.click(addHopInput);

// Autcomplete widgets:

var autoStyle = $('.auto-style').first().text().split(',');
autoStyle.pop()
$('.style-name').first().autocomplete({
  source: autoStyle
});

var autoYeast = $('.auto-yeast').first().text().split(',');
autoYeast.pop()
$('.yeast-name').first().autocomplete({
  source: autoYeast
});

var autoFermentable = $('.auto-fermentable').first().text().split(',');
autoFermentable.pop()
$('.fermentable-name').first().autocomplete({
  source: autoFermentable
});

var autoHops = $('.auto-hops').first().text().split(',');
autoHops.pop()
$('.hop-name').first().autocomplete({
  source: autoHops
});

// Add input field functions:

function addFermentableInput() {
  var $div = $('<div class="ingredient-entry"></div>');
  var $name = $('<p>Name</p><input type="text" name="fermentable' + fCounter + '">');
  var $ppg = $('<p>PPG</p><input type="text" name="ppg' + fCounter + '">');
  var $degL = $('<p>°L</p><input type="text" name="lovi' + fCounter + '">');
  var $qty = $('<p>Qty(g)</p><input type="text" name="f_weight' + fCounter + '">');

  $name.autocomplete({
    source: autoFermentable
  });
  $div.append($name);
  $div.append($ppg);
  $div.append($degL);
  $div.append($qty);

  $('.fermentables').first().append($div);
  fCounter += 1;
}

function addHopInput() {
  var $div = $('<div class="ingredient-entry"></div>');
  var $name = $('<p>Name</p><input type="text" name="hop' + hCounter + '">');
  var $aa = $('<p>AA%</p><input type="text" name="aa' + hCounter + '">');
  var $time = $('<p>Time</p><input type="text" name="time' + hCounter + '">');
  var $qty = $('<p>Qty(g)</p><input type="text" name="h_weight' + hCounter + '">');

  $name.autocomplete({
    source: autoHops
  });
  $div.append($name);
  $div.append($aa);
  $div.append($time);
  $div.append($qty);

  $('.hops').first().append($div);
  hCounter += 1;
}
