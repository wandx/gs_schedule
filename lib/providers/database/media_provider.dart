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

  Future<List<Media>> getAllMedia() async {
    List<Map> maps = await _db.query(
      table,
      columns: [
        idColumn,
        pathColumn,
        captionColumn,
        mediaType,
      ],
    );

    if(maps.length > 0){
      return maps.map<Media>((m) => Media.fromJson(m)).toList();
    }

    return [];
  }

  Future<Media> insertMedia({@required Media media}) async {
    media.id = await _db.insert(table, media.toMap());
    return media;
  }

  Future<Media> getMedia({@required int id}) async {
    List<Map> maps = await _db.query(
      table,
      columns: [idColumn, pathColumn, captionColumn, mediaType,],
      where: "$idColumn = ?",
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return Media.fromJson(maps.first);
    }

    return null;
  }

  Future<int> deleteMedia({@required int id}) async {
    return await _db.delete(
      table,
      where: "$idColumn = ?",
      whereArgs: [id],
    );
  }

  Future<Media> updateMedia({@required Media media}) async {
    int id = await _db.update(
      table,
      media.toMap(),
      where: "$idColumn = ?",
      whereArgs: [media.id],
    );

    return await getMedia(id: id);
  }
}
