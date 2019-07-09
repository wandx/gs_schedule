import 'package:flutter/widgets.dart';
import 'package:gs_schedule/models/media.dart';
import 'package:sqflite/sqflite.dart';

final String table = "media";
final String idColumn = "id";
final String pathColumn = "path";
final String captionColumn = "caption";
final String mediaType = "media_type";

class MediaProvider {
  Database _db;

  Future<void> open({@required String path}) async {
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          '''
            create table $table (
              $idColumn integer primary key autoincrement,
              $pathColumn text not null,
              $captionColumn text not null,
              $mediaType text not null,
            )
          ''',
        );
      },
    );
  }

  Future<Media> insert(Media media) async {
    media.id = await _db.insert(table, media.toMap());
    return media;
  }
}
