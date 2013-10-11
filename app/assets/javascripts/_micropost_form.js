function updateCountdown() {
  // 140 characters max
  var left = 140 - jQuery('#micropost_content').val().length;
  if(left == 1) {
    var charactersLeft = ' character left.'
  }
  else if(left < 0){
    var charactersLeft = ' characters too many.'
  }
  else{
    var charactersLeft = ' characters left.'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
  }
  jQuery('#remaining_chars').text(Math.abs(left) + charactersLeft);
}

//$('#micropost_content').on('keyup keydown', updateCountdown())
//$('#.micropost_content').on('keyup keydown', alert("keydown or keyup")


//jQuery(document).ready(function($) {
//  $('.micropost_text_area').on('keyup keydown' ,function(){
//    updateCountdown();
//  });
//});