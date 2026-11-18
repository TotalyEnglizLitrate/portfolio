// Favicons. The template has no <head> hook, so add the links from here; the
// plain /favicon.ico at the site root covers browsers without JavaScript.
(function () {
  [
    { rel: "icon", href: "/favicon.ico", sizes: "32x32" },
    { rel: "icon", href: "/favicon.svg", type: "image/svg+xml" },
    { rel: "apple-touch-icon", href: "/apple-touch-icon.png" },
  ].forEach(function (attrs) {
    var link = document.createElement("link");
    Object.keys(attrs).forEach(function (k) { link.setAttribute(k, attrs[k]); });
    document.head.appendChild(link);
  });
})();

// Light/dark toggle. Picks the saved choice, else the OS preference.
(function () {
  var root = document.documentElement;
  var stored = null;
  try { stored = localStorage.getItem("theme"); } catch (e) {}
  var dark = stored
    ? stored === "dark"
    : window.matchMedia("(prefers-color-scheme: dark)").matches;

  // Colours the mobile browser toolbar to match the page.
  function setThemeColor(color) {
    var meta = document.querySelector('meta[name="theme-color"]');
    if (!meta) {
      meta = document.createElement("meta");
      meta.name = "theme-color";
      document.head.appendChild(meta);
    }
    meta.content = color;
  }

  // Feather icons (MIT). The icon and label show the current mode.
  var SVG = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="1em" height="1em" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">';
  var SUN = SVG + '<circle cx="12" cy="12" r="5"/><line x1="12" y1="1" x2="12" y2="3"/><line x1="12" y1="21" x2="12" y2="23"/><line x1="4.22" y1="4.22" x2="5.64" y2="5.64"/><line x1="18.36" y1="18.36" x2="19.78" y2="19.78"/><line x1="1" y1="12" x2="3" y2="12"/><line x1="21" y1="12" x2="23" y2="12"/><line x1="4.22" y1="19.78" x2="5.64" y2="18.36"/><line x1="18.36" y1="5.64" x2="19.78" y2="4.22"/></svg>';
  var MOON = SVG + '<path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"/></svg>';

  function apply(isDark) {
    root.setAttribute("data-theme", isDark ? "dark" : "light");
    setThemeColor(isDark ? "#0b0b0b" : "#ffffff");
    if (button) {
      button.innerHTML = (isDark ? MOON : SUN) + "<span>" + (isDark ? "Dark" : "Light") + "</span>";
      button.setAttribute("aria-label", "Switch to " + (isDark ? "light" : "dark") + " mode");
    }
  }

  var button = document.createElement("button");
  button.id = "theme-toggle";
  button.type = "button";
  button.addEventListener("click", function () {
    dark = !dark;
    try { localStorage.setItem("theme", dark ? "dark" : "light"); } catch (e) {}
    apply(dark);
  });

  var header = document.querySelector("header");
  if (header) header.appendChild(button);
  else document.body.appendChild(button);

  // The credits live in the footer, which isn't parsed yet when this script
  // runs, so move them into the header once the page has loaded.
  document.addEventListener("DOMContentLoaded", function () {
    var credits = document.getElementById("made-with");
    if (header && credits) header.insertBefore(credits, button);
  });

  apply(dark);
})();

// Hide ".sep" separators that sit at the start or end of a wrapped line.
(function () {
  function trim() {
    var seps = document.querySelectorAll(".sep");
    seps.forEach(function (s) { s.style.visibility = ""; });
    seps.forEach(function (s) {
      var prev = s.previousElementSibling, next = s.nextElementSibling;
      var top = s.offsetTop;
      if ((prev && prev.offsetTop !== top) || (next && next.offsetTop !== top)) {
        s.style.visibility = "hidden";
      }
    });
  }
  document.addEventListener("DOMContentLoaded", trim);
  window.addEventListener("load", trim);
  window.addEventListener("resize", trim);
})();
