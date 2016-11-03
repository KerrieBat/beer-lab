console.log('linked');

// jQuery objects:
menuBtn = $('.menu').first();
menuWrapperDiv = $('.menu-wrapper').first();
closeMenuBtn = $('.close').first();

// Event Listeners:
menuBtn.click( function() {
  menuWrapperDiv.css("left", 0);
});

closeMenuBtn.click( function() {
  menuWrapperDiv.css("left", "100%");
});
