import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

Future<File> pickImage(
  ImageSource source, {
  bool withCropper: false,
  int maxWidth,
  int maxHeight,
}) async {
  return await ImagePicker.pickImage(source: source)
      .then((File pickedImage) async {
    if (withCropper) {
      return pickedImage = await ImageCropper.cropImage(
        sourcePath: pickedImage.path,
        ratioX: 1.0,
        ratioY: 1.0,
        maxWidth: maxWidth,
        maxHeight: maxWidth,
      );
    }

    return pickedImage;
  });
}

Future<File> pickVideo(ImageSource source) async {
  File video = await ImagePicker.pickVideo(source: source);

  if (p.extension(video.path) == ".mp4") {
    return video;
    if (video.lengthSync() < 10000) {
      return video;
    }
    throw Exception("File size too big");
  } else {
    throw Exception("File type not supported yet.");
  }
}

Future<String> saveMedia(File file) async {
  final String dest =
      await getApplicationDocumentsDirectory().then((Directory d) {
    return d.path;
  });

  String filePath = "$dest/${p.basename(file.path)}";
  File newPath = file.copySync(filePath);
  file.deleteSync();
  print("media size: ${newPath.lengthSync()}");
  return newPath.path;
}
