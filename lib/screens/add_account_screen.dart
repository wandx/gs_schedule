import 'package:flutter/material.dart';
import 'package:gs_schedule/app_provider.dart';
import 'package:gs_schedule/models/account.dart';
import 'package:gs_schedule/widgets/forms.dart';
import 'package:gs_schedule/widgets/misc.dart';
import 'package:gs_schedule/widgets/scaffold_wrapper.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:gs_schedule/utils/instagram.dart' as instagram;

class AddAccountScreen extends StatefulWidget {
  @override
  _AddAccountScreenState createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  String _username;
  String _password;
  String _passwordEnc;
  String _description;

  @override
  void initState() {
    _username = "";
    _password = "";
    _passwordEnc = "";
    _description = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _appProvider = ScopedModel.of<AppProvider>(context);
    return ScaffoldWrapper(
      isLoading: _appProvider.globalLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tambah Akun Instagram"),
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
                      CustomTextField(
                        placeHolder: "Username",
                        onChange: (x) {
                          setState(() => _username = x);
                        },
                      ),
                      CustomTextField(
                        placeHolder: "Password",
                        secure: true,
                        onChange: (x) {
                          setState(() => _password = x);
                        },
                      ),
                      CustomTextField(
                        placeHolder: "Deskripsi",
                        onChange: (x) {
                          setState(() => _description = x);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  final a = new Account();
                  String e = await a.encrypt(_password);
                  setState(() => _passwordEnc = e);

                  if (_username.isEmpty) {
                    ShowToast(text: "Username diperlukan.");
                    return;
                  }

                  if (_password.isEmpty) {
                    ShowToast(text: "Password diperlukan");
                    return;
                  }

                  bool validInstagram = await instagram.checkLogin(
                      username: _username, password: _password);
                  if (!validInstagram) {
                    ShowToast(text: "Gagal validasi akun instagram.");
                    return;
                  }

                  await _appProvider.storeInstagramAccount({
                    "username": _username,
                    "password": _passwordEnc,
                    "description": _description,
                  }).then((_) async {
                    await _appProvider.fetchAccount();
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
      ),
    );
  }
}
