class Media {
  final String id;
  final String path;
  final String mediaType;
  final String caption;

  Media({this.id, this.path, this.mediaType, this.caption});

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json["id"],
      path: json["path"],
      mediaType: json["media_type"],
      caption: json["caption"],
    );
  }
}
