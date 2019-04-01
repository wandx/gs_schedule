import 'package:flutter/material.dart';
import 'package:gs_schedule/models/account.dart';
import 'package:gs_schedule/models/credential.dart';
import 'package:gs_schedule/models/media.dart';
import 'package:gs_schedule/models/user.dart';
import 'package:gs_schedule/repositories/media_repo.dart'
    show storeMedia, getMedia, storeSchedule;
import 'package:gs_schedule/repositories/user_repo.dart'
    show me, login, logout, getAccount, storeAccount, removeAccount;
import 'package:gs_schedule/utils/prefs.dart' show tokenExists;
import 'package:scoped_model/scoped_model.dart';

enum ActiveScreen { HOME, ACCOUNT, SCHEDULE, INFO }

class AppProvider extends Model {
  ActiveScreen _activeScreen = ActiveScreen.HOME;
  bool _globalLoading = false;
  bool _loggedIn = false;
  User _user;
  List<Media> _media = [];
  List<Account> _accounts = [];

  ActiveScreen get activeScreen => _activeScreen;
  bool get globalLoading => _globalLoading;
  bool get loggedIn => _loggedIn;
  User get user => _user;
  List<Media> get media => _media;
  List<Account> get accounts => _accounts;

  set setActiveScreen(ActiveScreen x) {
    _activeScreen = x;
    notifyListeners();
  }

  set setGlobalLoading(bool x) {
    _globalLoading = x;
    notifyListeners();
  }

  set setIsLoggedIn(bool x) {
    _loggedIn = x;
    notifyListeners();
  }

  Future<Null> doLogin(Credential cred) async {
    await login(cred).then((_) async {
      await fetchLoginStatus();
      _globalLoading = false;
      notifyListeners();
    });
  }

  Future<Null> doLogout() async {
    _globalLoading = true;
    _activeScreen = ActiveScreen.HOME;
    await logout().then((bool res) async {
      if (res) {
        _loggedIn = false;
      }
    }).then((_) {
      _globalLoading = false;
      notifyListeners();
    });
  }

  Future<bool> fetchLoginStatus() async {
    // check token in shared preferences, if not exists return false
    final bool tExists = await tokenExists();

    if (!tExists) {
//      throw Exception("Token doesn't exists");
      _loggedIn = false;
    }

    // check existing token in shared preferences, hit endpoint to validate user, if not validated return false, if valid set true and set user
    return await me().then((User u) {
      if (u is User) {
        _user = u;
        _loggedIn = true;
        return true;
      }
      return false;
    }).catchError((error) {
      return false;
    });
  }

  Future<Null> storeImage(Map<String, dynamic> body) async {
    await storeMedia(body).then((_) {}).catchError((error) {
      throw Exception(error);
    });
  }

  Future<Null> fetchMedia() async {
    _media.clear();
    await getMedia().then((data) {
      _media.addAll(data);
      print(_media.length);
    }).catchError((error) {
      print(error);
      _media.clear();
      notifyListeners();
    });
  }

  Future<Null> fetchAccount() async {
    _accounts.clear();
    await getAccount().then((a) {
      _accounts.addAll(a);
      notifyListeners();
    }).catchError((error) {
      print(error);
      _accounts.clear();
      notifyListeners();
    });
  }

  Future<Null> storeInstagramAccount(Map<String, dynamic> body) async {
    await storeAccount(body).catchError((error) => throw Exception(error));
  }

  Future<Null> removeInstagramAccount(String id) async {
    await removeAccount(id).catchError((error) => print(error));
  }

  Future<Map<String, dynamic>> storePostSchedule(
      Map<String, dynamic> body) async {
    return await storeSchedule(body).then((result) async {
      return result;
    }).catchError((error) {
      throw Exception(error);
    });
  }

  static AppProvider of(BuildContext context) =>
      ScopedModel.of<AppProvider>(context);
}
