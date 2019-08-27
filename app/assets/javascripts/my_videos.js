$( document ).ready(function() {
  let player = videojs('video');
  player.playlist(gon.mediaSets);
  player.playlistUi();
});

