import 'package:flutter/material.dart';
import 'package:gs_schedule/models/credential.dart';
import 'package:gs_schedule/states/app_state.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _cred = Credential(username: "", password: "");

  @override
  Widget build(BuildContext context) {
    final state = ScopedModel.of<AppState>(context, rebuildOnChange: true);
    final _deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: _deviceHeight * 0.13),
                  child: Image(
                    image: AssetImage("assets/img/icon.png"),
                    width: 150.0,
                    height: 150.0,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 95.0),
                  padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Username Gramshoot",
                      hintStyle: TextStyle(color: Colors.black38),
                    ),
                    validator: (x) {
                      if (x.isEmpty) {
                        return "Username diperlukan.";
                      }
                    },
                    onSaved: (x) {
                      setState(() => _cred.username = x);
                    },
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password Gramshoot",
                      hintStyle: TextStyle(color: Colors.black38),
                    ),
                    validator: (x) {
                      if (x.isEmpty) {
                        return "Password diperlukan.";
                      }
                    },
                    onSaved: (x) {
                      setState(() => _cred.password = x);
                    },
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                    obscureText: true,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if(_formKey.currentState.validate()){
                      _formKey.currentState.save();
                      await state.login(credential: _cred);

                      if (!state.model.isLoggedIn) {
                        try{
                          _scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              content:
                              Text("Periksa kembali username/password anda"),
                            ),
                          );
                        }catch(ex){
                          print(ex.toString());
                        }

                      }
                    }

                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    width: double.infinity,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                      gradient: LinearGradient(colors: [
                        Colors.blue,
                        Colors.orange,
                      ]),
                    ),
                    child: Center(
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
                  child: Center(
                    child: Text(
                      "*Perhatian: Silahkan hubungi pengembang untuk mendapatkan akun Gramshoot.",
                      style: TextStyle(
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
