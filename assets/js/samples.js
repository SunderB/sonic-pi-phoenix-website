export default function() {
  document.querySelectorAll("button.play").forEach(function (button) {
    button.addEventListener("click", function(e){
      const sampleName = button.dataset.sample;
      const media = document.querySelector(`audio#${sampleName}`);
      media.play();
    });
  });
};
