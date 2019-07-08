import 'package:flutter/widgets.dart';
import 'package:gs_schedule/models/account.dart';
import 'package:gs_schedule/models/credential.dart';
import 'package:gs_schedule/models/media.dart';
import 'package:gs_schedule/models/user.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:gs_schedule/constants/global_constant.dart';
import 'package:gs_schedule/repositories/user_repo.dart' as repo;

class AppState extends Model {
  final model = AppModel.init();

  Future<void> init() async{
    await me();
  }

  Future<void> login({@required Credential credential}) async{
    model.isLoading = true;
    notifyListeners();

    final _result = await repo.login(credential);
    if(_result){
      model.isLoggedIn = true;
      await me();
    }

    model.isLoading = false;
    notifyListeners();
  }

  Future<void> me() async{
    model.isLoading = true;
    notifyListeners();

    final _result = await repo.me();

    if(_result != null){
      model.user = _result;
      model.isLoggedIn = true;
    }else{
      model.user = null;
      model.isLoggedIn = false;
    }

    model.isLoading = false;
    notifyListeners();
  }

  static AppState of(BuildContext context) => ScopedModel.of<AppState>(context);
}

class AppModel {
  ActiveScreen activeScreen;
  bool isLoading;
  bool isLoggedIn;
  User user;
  List<Media> medias;
  List<Account> accounts;

  AppModel({
    this.activeScreen,
    this.isLoading,
    this.isLoggedIn,
    this.user,
    this.medias,
    this.accounts,
  });

  factory AppModel.init() {
    return AppModel(
      activeScreen: ActiveScreen.HOME,
      isLoading: false,
      isLoggedIn: false,
      user: null,
      accounts: [],
      medias: [],
    );
  }
}
