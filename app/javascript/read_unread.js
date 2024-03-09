$(document).on('click', '.read-status-btn', function() {
  var bookId = $(this).data('book-id');
  var isRead = $(this).hasClass('read');

  $.ajax({
    url: '/path/to/toggle_read_status',
    method: 'POST',
    data: { book_id: bookId, read: !isRead },
    success: function(response) {

    },
    error: function(xhr, status, error) {
      console.error('Error toggling read status:', error);
    }
  });
});
