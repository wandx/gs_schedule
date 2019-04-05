import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gs_schedule/app_provider.dart';
import 'package:gs_schedule/utils/media_process.dart' show pickImage, saveMedia;
import 'package:gs_schedule/widgets/forms.dart';
import 'package:gs_schedule/widgets/misc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

class AddGallery extends StatefulWidget {
  @override
  _AddGalleryState createState() => _AddGalleryState();
}

class _AddGalleryState extends State<AddGallery> {
  ImageProvider _imageProvider;
  String _path;
  String _caption;
  File _imgFile;

  @override
  void initState() {
    _path = "";
    _caption = "";
    _imageProvider = AssetImage("assets/img/default.png");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _appProvider =
        ScopedModel.of<AppProvider>(context, rebuildOnChange: true);

    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Gallery"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    InkWell(
                      child: Container(
                        child: Image(
                          image: _imageProvider,
                          fit: BoxFit.fitWidth,
                        ),
                        margin: EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                          bottom: 10.0,
                        ),
                      ),
                      onTap: () async {
                        await pickImage(
                          ImageSource.gallery,
                          withCropper: true,
                        ).then((File f) async {
                          setState(() {
                            _imgFile = f;
                            _imageProvider = FileImage(f);
                          });
                        });
                      },
                    ),
                    CustomTextField(
                      placeHolder: "Caption",
                      isLongText: true,
                      onChange: (x) {
                        setState(() {
                          _caption = x;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                if (_imgFile == null) {
                  ShowToast(text: "Gambar diperlukan");
                  return;
                }

                if (_caption.isEmpty) {
                  ShowToast(text: "Caption diperlukan");
                  return;
                }

                String p = await saveMedia(_imgFile);

                setState(() {
                  _path = p;
                });
                final body = {
                  "path": _path,
                  "caption": _caption,
                  "type": "photo"
                };

                await _appProvider.storeImage(body).then((_) async {
                  Navigator.pop(context);
                });
              },
              child: Container(
                color: Colors.grey,
                width: double.infinity,
                height: 50.0,
                child: Center(
                  child: Text(
                    "SIMPAN",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
