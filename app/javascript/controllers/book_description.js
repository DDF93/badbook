document.addEventListener('DOMContentLoaded', function () {
  const readMoreLink = document.querySelector('.book-description .read-more');

  function toggleDescription(event) {
    event.preventDefault();

    var preview = document.getElementById("description-preview");
    var fullDescription = document.getElementById("full-description");

    if (fullDescription.style.display === "none") {
      preview.style.display = "none";
      fullDescription.style.display = "block";
      readMoreLink.textContent = "Less";
    } else {
      preview.style.display = "block";
      fullDescription.style.display = "none";
      readMoreLink.textContent = "More";
    }
  }

  if (readMoreLink) {
    readMoreLink.addEventListener('click', toggleDescription);
  }
});
