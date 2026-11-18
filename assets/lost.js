// 404 page: the "Take cookie" button. ("Take me home" is a plain link.)
document.addEventListener("DOMContentLoaded", function () {
  var cookie = document.getElementById("cookie");
  var take = document.getElementById("take-cookie");

  // Taking the cookie makes it disappear (fading out, so the layout doesn't
  // jump) and disables the button.
  if (take && cookie) {
    take.addEventListener("click", function () {
      cookie.classList.add("gone");
      take.disabled = true;
    });
  }
});
