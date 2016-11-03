console.log('linked');

// jQuery objects:
menuBtn = $('.menu').first();
menuWrapperDiv = $('.menu-wrapper').first();
closeMenuBtn = $('.close').first();
pageWrapperDiv = $('.page-wrapper').first();

// Event Listeners:
menuBtn.click( function() {
  $('.page-wrapper').scrollTop(0);
  menuWrapperDiv.css("left", 0);
  pageWrapperDiv.css("overflow-y", "hidden");
});

closeMenuBtn.click( function() {
  menuWrapperDiv.css("left", "100%");
  pageWrapperDiv.css("overflow-y", "auto");
});
