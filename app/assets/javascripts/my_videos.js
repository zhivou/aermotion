$(document).ready(function() {
  var cld = cloudinary.Cloudinary.new({ cloud_name: "demo"});
  cld.videoPlayer('#example-player');
});