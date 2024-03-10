document.addEventListener("DOMContentLoaded", function() {
  const navbar = document.getElementById("navbar");
  let scrolled = false;

  window.addEventListener("scroll", function() {
    if (window.scrollY > 0 && !scrolled) {
      navbar.classList.remove("transparent-navbar");
      navbar.classList.add("solid-navbar");
      scrolled = true;
    } else if (window.scrollY === 0 && scrolled) {
      navbar.classList.remove("solid-navbar");
      navbar.classList.add("transparent-navbar");
      scrolled = false;
    }
  });
});
