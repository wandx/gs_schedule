import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gs_schedule/app_provider.dart';
import 'package:gs_schedule/models/media.dart';
import 'package:gs_schedule/screens/add_schedule_screen.dart';
import 'package:gs_schedule/widgets/bottom_nav.dart';
import 'package:gs_schedule/widgets/misc.dart';
import 'package:gs_schedule/widgets/scaffold_wrapper.dart';
import 'package:scoped_model/scoped_model.dart';

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  bool _selectionMode;
  List<String> _selectedId;

  @override
  void initState() {
    _selectionMode = false;
    _selectedId = [];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _appProvider =
        ScopedModel.of<AppProvider>(context, rebuildOnChange: true);

    return ScaffoldWrapper(
      isLoading: _appProvider.globalLoading,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("GRAMSHOOT"),
          backgroundColor: Colors.black,
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Visibility(
              visible: _selectionMode,
              child: Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  mini: true,
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Hapus media?"),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel"),
                              ),
                              FlatButton(
                                onPressed: () async {
                                  _selectedId.forEach((String id) async {
                                    await _appProvider.deleteMediaData(id);
                                  });

                                  setState(() {
                                    _selectedId.clear();
                                    _selectionMode = false;
                                  });

                                  Navigator.pop(context);
                                },
                                child: Text("Hapus"),
                              )
                            ],
                          );
                        });
                  },
                  heroTag: "deleteMedia",
                  child: Icon(FontAwesomeIcons.trash),
                ),
              ),
            ),
            Visibility(
              visible: _selectionMode,
              child: FloatingActionButton(
                heroTag: "addSchedule",
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddScheduleScreen(
                            mediaIds: _selectedId,
                          ),
                    ),
                  ).then((_) {
                    _selectedId.clear();
                  });
                },
                child: Text("${_selectedId.length}"),
              ),
            ),
            Visibility(
              visible: !_selectionMode,
              child: FloatingActionButton(
                heroTag: "addGallery",
                onPressed: () async {
                  await Navigator.pushNamed(context, "add_gallery")
                      .then((_) async {
                    await _appProvider.fetchMedia();
                  });
                },
                child: Icon(FontAwesomeIcons.plus),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNav(
          activeMenu: ActiveMenu.ACCOUNT,
          menuItem: <BottomNavItem>[
            BottomNavItem(
              icon: FontAwesomeIcons.home,
              isActive: true,
            ),
            BottomNavItem(
              icon: FontAwesomeIcons.userAstronaut,
              onTap: () {
                _appProvider.setActiveScreen = ActiveScreen.ACCOUNT;
              },
            ),
//            BottomNavItem(
//              icon: FontAwesomeIcons.solidClock,
//              onTap: () {
//                _appProvider.setActiveScreen = ActiveScreen.SCHEDULE;
//              },
//            ),
            BottomNavItem(
              icon: FontAwesomeIcons.user,
              onTap: () {
                _appProvider.setActiveScreen = ActiveScreen.INFO;
              },
            ),
          ],
        ),
        body: Container(
          margin: EdgeInsets.only(top: 0.0),
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            children: _appProvider.media
                .map<Widget>((Media m) => _gridSingle(m))
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _gridSingle(Media m) {
    return CustomGridTile(
      path: m.path,
      caption: m.caption,
      selected: _selectedId.contains(m.id),
      onTap: () {
        _gridTap(m);
      },
      onLongPress: () {
        _gridLongPress(m);
      },
    );
  }

  void _gridTap(Media m) {
    if (_selectionMode) {
      if (_selectedId.contains(m.id)) {
        setState(() => _selectedId.removeWhere((id) => id == m.id));

        if (_selectedId.length == 0) {
          setState(() => _selectionMode = false);
        }
      } else {
        setState(() => _selectedId.add(m.id));
      }
    } else {
      print("vied detail");
    }
  }

  void _gridLongPress(Media m) {
    setState(() => _selectionMode = !_selectionMode);
    if (!_selectionMode) {
      setState(() => _selectedId.clear());
    } else {
      if (_selectedId.length == 0) {
        setState(() => _selectedId.add(m.id));
      }
    }
  }
}
