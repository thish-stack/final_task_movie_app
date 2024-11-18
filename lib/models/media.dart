//model
class Media {
  final String id;
  final String title;
  final String description;
  final List<String> genre;
  final String image;
  final String bigImage;
  final String thumbnail;
  final String imdbLink;
  final String imdbId;
  final int rank;
  final double rating;
  final int year;

  Media({
    required this.id,
    required this.title,
    required this.description,
    required this.genre,
    required this.image,
    required this.bigImage,
    required this.thumbnail,
    required this.imdbLink,
    required this.imdbId,
    required this.rank,
    required this.rating,
    required this.year,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      genre: List<String>.from(json['genre'] ?? []),
      image: json['image'] ?? '',
      bigImage: json['big_image'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      imdbLink: json['imdb_link'] ?? '',
      imdbId: json['imdbid'] ?? '',
      rank: json['rank'] ?? 0,
      rating: double.tryParse(json['rating'] ?? '0') ?? 0.0,
      year: json['year'] ?? 0,
    );
  }
}
