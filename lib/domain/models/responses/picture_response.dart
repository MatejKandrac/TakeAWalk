
class PictureResponse {
  final int id;
  final String link;

  const PictureResponse({
    required this.id,
    required this.link
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'link': this.link,
    };
  }

  factory PictureResponse.fromMap(Map<String, dynamic> map) {
    return PictureResponse(
      id: map['id'] as int,
      link: map['link'] as String,
    );
  }
}