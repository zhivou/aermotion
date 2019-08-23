import "lodash"
import "cloudinary-video-player/dist/cld-video-player.min.css";
import "cloudinary-core"
import "cloudinary-video-player/dist/cld-video-player"

$( document ).ready(function() {
  var cld = cloudinary.Cloudinary.new({ cloud_name: "demo"});
  cld.videoPlayer('example-player');
});
