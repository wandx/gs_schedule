class Media {
  int id;
  String path;
  String mediaType;
  String caption;

  Media({
    this.id,
    this.path,
    this.mediaType,
    this.caption,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json["id"],
      path: json["path"],
      mediaType: json["media_type"],
      caption: json["caption"],
    );
  }

  toMap() {
    var map = <String, dynamic>{
      "path": path,
      "caption": caption,
      "media_type": mediaType,
    };

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }
}
