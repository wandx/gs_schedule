import 'package:flutter/widgets.dart';
import 'package:gs_schedule/models/account.dart';
import 'package:gs_schedule/models/credential.dart';
import 'package:gs_schedule/models/media.dart';
import 'package:gs_schedule/models/user.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:gs_schedule/constants/global_constant.dart';
import 'package:gs_schedule/repositories/user_repository.dart' as repo;
import 'package:gs_schedule/providers/database/media_provider.dart' as mp;

class AppState extends Model {
  final model = AppModel.init();
  final mediaModel = MediaModel.init();

  Future<void> init() async{
    await me();
  }

  Future<void> login({@required Credential credential}) async{
    model.isLoading = true;
    notifyListeners();

    final _result = await repo.login(credential: credential);
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

  Future<bool> insertMedia({@required Media media}) async{
    final act = mp.MediaProvider();
    final res = act.insertMedia(media: media);
    return res is int;
  }

  static AppState of(BuildContext context) => ScopedModel.of<AppState>(context);
}

class MediaModel{
  List<Media> media;

  MediaModel({this.media});

  factory MediaModel.init(){
    return MediaModel(media: []);
  }
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
