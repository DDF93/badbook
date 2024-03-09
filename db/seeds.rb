# 20.times do
#   Book.create(
#     title: Faker::Book.title,
#     author: Faker::Book.author,
#     genre: Faker::Book.genre,
#     date: Faker::Date.between(from: 100.years.ago, to: Date.today),
#     description: Faker::Lorem.paragraph,
#     image_url: "https://media.gettyimages.com/id/157482029/photo/stack-of-books.jpg?s=612x612&w=gi&k=20&c=_Yaofm8sZLZkKs1eMkv-zhk8K4k5u0g0fJuQrReWfdQ="
#   )
# end

all_id = []
all_genres = []
api_key = "e0e7828ad3b849f7a4ba1e9471903762"


  url = "https://api.bigbookapi.com/search-books?api-key=#{api_key}&genres=food&number=49"
  user_serialized = URI.open(url).read
  user = JSON.parse(user_serialized)
  user["books"].each do |book|
  book_id = book[0]["id"]
  book_genre = book[0]["genres"]
  all_genres << book_genre
  all_id << book_id
  end

  number = 0


  49.times do
    genre_for_book = all_genres[number].join(", ")
    url = "https://api.bigbookapi.com/#{all_id[number]}?api-key=#{api_key}"
    user_serialized = URI.open(url).read
    user = JSON.parse(user_serialized)

    Book.create(
      title: user["title"],
      author: user["authors"][0]["name"],
      genre: genre_for_book,
      description: user["description"],
      date: user["publish_date"].to_i,
      image_url: user["image"])
    number += 1
  end
