export default function() {
  var currently_playing = null;
  document.querySelectorAll("button.play").forEach(function (button) {
    button.addEventListener("click", function(e){
      if (currently_playing != null) {
        currently_playing.pause();
        currently_playing.currentTime = 0;
      }
      const sampleName = button.dataset.sample;
      const media = document.querySelector(`audio#${sampleName}`);
      currently_playing = media;
      media.play();
    });
  });
};
