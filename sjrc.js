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
  "vk.com": {
    "play": function(){
      document.querySelector('.top_audio_player_btn.top_audio_player_play').click();
      return 'play';
    },
    "pause": function(){
      document.querySelector('.top_audio_player_btn.top_audio_player_play').click();
      return 'pause';
    },
    "next": function(){
      document.querySelector('.top_audio_player_btn.top_audio_player_next').click();
    },
    "prev": function(){
      document.querySelector('.top_audio_player_btn.top_audio_player_prev').click();
    },
    "is_playing": function(){
      return document.querySelector('.top_audio_player').classList.contains('top_audio_player_playing');
    },
    "current_media_title": function(){}
  },
  "soundcloud.com": {
    "play": function(){
      document.querySelector('.playControl').click();
      return 'play';
    },
    "pause": function(){
      document.querySelector('.playControl').click();
      return 'pause';
    },
    "next": function(){
      document.querySelector('.skipControl__next').click();
    },
    "prev": function(){
      document.querySelector('.skipControl__previous').click();
    },
    "is_playing": function(){
      return document.querySelector('.playControl').classList.contains('playing');
    }
  }
}
