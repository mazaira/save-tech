// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//

require("@rails/ujs").start();
require("@rails/activestorage").start();
require("channels");

const images = require.context("../images", true);
const imagePath = (name) => images(name, true);

import "bootstrap/dist/js/bootstrap";

// note, on screen resize fixed buttons won't readjust. It properly distributes on reload, but obviously they don't compact
var longestTag = Math.max.apply(
  null,
  $(".fixed-tag")
    .map(function () {
      return $(this).outerWidth();
    })
    .get()
);
var tagHeight = $(".fixed-tag").outerHeight();
$(".fixed-tag").each(function () {
  $(this).css({
    left: Math.random() * ($(".tag-container").width() - longestTag),
    // "background-color": randomColor(),
    // "mix-blend-mode": 'exclusion',
  });
});
