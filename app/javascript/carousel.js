function scrollRight(carouselId) {
  const carousel = document.getElementById(carouselId);
  carousel.scrollBy({ left: 300, behavior: 'smooth' });
}
