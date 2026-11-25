// SPDX-License-Identifier: MIT
// In-place page switching. Internal pages are fetched ahead of time (all of
// them when the browser is idle, others on hover/touch) and a click swaps the
// page content without a reload, so navigation feels instant even in browsers
// with no (or disabled) prefetching/prerendering. The header, theme toggle and
// stylesheets stay put, so styling is unaffected. Anything unusual (a page with
// different stylesheets or its own scripts, a failed fetch) falls back to a
// normal navigation.
(function () {
  if (!window.fetch || !window.DOMParser || !history.pushState) return;
  var conn = navigator.connection;
  var saveData = !!(conn && conn.saveData);

  var pages = {};   // url -> Promise<Document|null>
  var KEEP = 'meta[name="description"],meta[property^="og:"],meta[name^="twitter:"],' +
             'link[rel="canonical"],script[type="application/ld+json"]';
  var OWN = /\/assets\/(theme|nav)\.js(\?|$)/;

  function key(u) { u = new URL(u, location.href); u.hash = ""; return u.href; }

  // Internal HTML page URL for a link, or null if the browser should handle it.
  function internal(a) {
    if (!a || !a.href || (a.target && a.target !== "_self") || a.hasAttribute("download")) return null;
    var u = new URL(a.href, location.href);
    if (u.origin !== location.origin || !/^https?:$/.test(u.protocol)) return null;
    if (/\.[a-z0-9]+$/i.test(u.pathname) && !/\.html$/i.test(u.pathname)) return null;
    return u;
  }

  function load(url) {
    url = key(url);
    if (!pages[url]) {
      pages[url] = fetch(url, { credentials: "same-origin" }).then(function (r) {
        var type = r.headers.get("content-type") || "";
        if (!r.ok || type.indexOf("text/html") < 0 || r.redirected) return null;
        return r.text();
      }).then(function (t) {
        return t && new DOMParser().parseFromString(t, "text/html");
      }).catch(function () { return null; });
    }
    return pages[url];
  }

  function headSig(doc) {
    return Array.prototype.map.call(
      doc.head.querySelectorAll('link[rel="stylesheet"],style'),
      function (n) { return n.outerHTML; }
    ).join("");
  }
  var sig = headSig(document);

  function swappable(doc) {
    if (!doc || headSig(doc) !== sig) return false;
    var scripts = doc.body.querySelectorAll("script");
    for (var i = 0; i < scripts.length; i++) {
      if (!OWN.test(scripts[i].getAttribute("src") || "")) return false;
    }
    return !!doc.body.querySelector("header");
  }

  function swap(doc) {
    document.title = doc.title;
    document.head.querySelectorAll(KEEP).forEach(function (n) { n.remove(); });
    doc.head.querySelectorAll(KEEP).forEach(function (n) {
      document.head.appendChild(document.importNode(n, true));
    });
    document.documentElement.lang = doc.documentElement.lang || "en";
    document.body.className = doc.body.className;

    var header = document.querySelector("header");
    Array.prototype.slice.call(document.body.children).forEach(function (n) {
      if (n !== header) n.remove();
    });
    Array.prototype.slice.call(doc.body.children).forEach(function (n) {
      if (n.tagName === "HEADER") return;
      var node = document.importNode(n, true);
      node.querySelectorAll("script").forEach(function (s) { s.remove(); });
      // theme.js already moved the credits into the header; drop the duplicate.
      var dup = node.querySelector("#made-with");
      if (dup && document.querySelector("header #made-with")) dup.remove();
      document.body.appendChild(node);
    });
    // Let theme.js re-trim the wrapped ".sep" separators.
    window.dispatchEvent(new Event("resize"));
  }

  var token = 0;
  function go(url, push) {
    var my = ++token;
    var u = new URL(url, location.href);
    load(u.href).then(function (doc) {
      if (my !== token) return;
      if (!swappable(doc)) { location.href = u.href; return; }
      // Remember where we were, for the back button.
      history.replaceState({ y: scrollY }, "");
      var run = function () {
        if (push) history.pushState({ y: 0 }, "", u.href);
        swap(doc);
        if (document.activeElement && document.activeElement.blur) document.activeElement.blur();
        var target = u.hash && document.getElementById(decodeURIComponent(u.hash.slice(1)));
        if (target) target.scrollIntoView();
        else window.scrollTo({ top: push ? 0 : (history.state && history.state.y) || 0, behavior: "instant" });
        idle(prefetchAll);
      };
      if (document.startViewTransition &&
          !matchMedia("(prefers-reduced-motion: reduce)").matches) {
        document.startViewTransition(run);
      } else run();
    });
  }

  document.addEventListener("click", function (e) {
    if (e.defaultPrevented || e.button !== 0 || e.metaKey || e.ctrlKey || e.shiftKey || e.altKey) return;
    var a = e.target.closest && e.target.closest("a[href]");
    var u = internal(a);
    if (!u) return;
    // Same page: let the browser handle in-page anchors (smooth scroll in CSS).
    if (key(u) === key(location.href) && u.hash) return;
    e.preventDefault();
    if (key(u) === key(location.href)) { window.scrollTo({ top: 0 }); return; }
    go(u.href, true);
  });

  window.addEventListener("popstate", function () { go(location.href, false); });
  if ("scrollRestoration" in history) history.scrollRestoration = "manual";

  // Fetch on intent, and everything else when idle.
  function intent(e) {
    var u = internal(e.target.closest && e.target.closest("a[href]"));
    if (u) load(u.href);
  }
  document.addEventListener("mouseover", intent, { passive: true });
  document.addEventListener("touchstart", intent, { passive: true });
  document.addEventListener("focusin", intent);

  function prefetchAll() {
    if (saveData) return;
    document.querySelectorAll("a[href]").forEach(function (a) {
      var u = internal(a);
      if (u) load(u.href);
    });
  }
  function idle(fn) {
    if (window.requestIdleCallback) requestIdleCallback(fn, { timeout: 2000 });
    else setTimeout(fn, 200);
  }
  if (document.readyState === "complete") idle(prefetchAll);
  else window.addEventListener("load", function () { idle(prefetchAll); });
})();
