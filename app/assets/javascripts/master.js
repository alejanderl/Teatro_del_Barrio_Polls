$(document).ready(function(){
  $( document ).on("click","a[href='#']", function( event ) {
    event.preventDefault();
  });

  setTimeout(function(){$("#flash_notice").toggle(1000);},5000);
});