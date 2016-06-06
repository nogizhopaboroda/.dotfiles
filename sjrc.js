module.exports = {
  "mixcloud.com": {
    "play": function(){
      document.querySelector('.player-control').click();
      return 'play';
    },
    "pause": function(){
      document.querySelector('.player-control').click();
      return 'pause';
    },
    "next": function(){},
    "prev": function(){},
    "is_playing": function(){
      return document
            .querySelector('.player-control')
            .classList
            .contains('pause-state');
    },
    "current_media_title": function(){}
  },
  "vk.com/audio": {
    "play": function(){
      document.querySelector('#ac_play').click();
      return 'play';
    },
    "pause": function(){
      document.querySelector('#ac_play').click();
      return 'pause';
    },
    "next": function(){
      document.querySelector('#ac_controls #ac_next').click();
    },
    "prev": function(){
      document.querySelector('#ac_controls #ac_prev').click();
    },
    "is_playing": function(){
      return document.querySelector('#ac_play').classList.contains('playing');
    },
    "current_media_title": function(){}
  },
  "vk.com/im": {
    "play": function(){
      document.querySelector('#head_play_btn').click();
      return 'play';
    },
    "pause": function(){
      document.querySelector('#head_play_btn').click();
      return 'pause';
    },
    "next": function(){},
    "prev": function(){},
    "is_playing": function(){
      return document.querySelector('#head_play_btn').classList.contains('playing');
    },
    "current_media_title": function(){}
  }
}
