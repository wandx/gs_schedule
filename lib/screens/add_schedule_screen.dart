import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:gs_schedule/app_provider.dart';
import 'package:gs_schedule/models/account.dart';
import 'package:gs_schedule/utils/instagram.dart';
import 'package:gs_schedule/widgets/scaffold_wrapper.dart';
import 'package:scoped_model/scoped_model.dart';

class AddScheduleScreen extends StatefulWidget {
  final List<String> mediaIds;

  AddScheduleScreen({@required this.mediaIds});

  @override
  _AddScheduleScreenState createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  DateTime _date;
  TimeOfDay _time;
  List<String> _selectedAccount;

  @override
  void initState() {
    _date = DateTime.now();
    _time = TimeOfDay.fromDateTime(_date);
    _selectedAccount = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _appProvider = ScopedModel.of<AppProvider>(context);
    return ScaffoldWrapper(
      isLoading: _appProvider.globalLoading,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Tambah Jadwal Post"),
        ),
        body: Container(
          color: Colors.black,
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 200.0,
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                formatDate(_date, [dd, " ", MM, " ", yyyy]),
                                style: TextStyle(
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Divider(),
                              Text(
                                formatDate(_date, [HH, ":", n]),
                                style: TextStyle(
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Divider(),
                              RaisedButton(
                                onPressed: () async {
                                  await _showDatePicker(context);
                                },
                                child: Text("Ganti Tanggal"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 200.0,
                        child: Card(
                          child: SingleChildScrollView(
                            child: Column(
                              children: _appProvider.accounts
                                  .map(
                                    (Account a) => ListTile(
                                          title: Text(a.username),
                                          trailing: Checkbox(
                                            value:
                                                _selectedAccount.contains(a.id),
                                            onChanged: (x) {
                                              if (x) {
                                                setState(() =>
                                                    _selectedAccount.add(a.id));
                                              } else {
                                                setState(() => _selectedAccount
                                                    .removeWhere(
                                                        (id) => id == a.id));
                                              }
                                            },
                                          ),
                                        ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  final format = [
                    yyyy,
                    "-",
                    mm,
                    "-",
                    dd,
                    " ",
                    HH,
                    ":",
                    nn,
                    ":00"
                  ];
                  final body = {
                    "date": formatDate(_date, format),
                    "accounts": _selectedAccount,
                    "media": widget.mediaIds
                  };

                  await _appProvider.storePostSchedule(body).then((data) async {
                    List<dynamic> mediaIds = (data["schedule_data"]["items"])
                        .map((d) =>
                            d["media"]["path"] +
                            "###-###" +
                            d["media"]["caption"])
                        .toList();
                    List<dynamic> accountIds = (data["schedule_data"]
                            ["accounts"])
                        .map((d) => d["username"] + "," + d["password"])
                        .toList();
                    List<String> decrypted = [];

                    String toDecrypt = accountIds.join("|");
                    List<String> listToDecrypt = toDecrypt.split("|");

                    for (int i = 0; i < listToDecrypt.length; i++) {
                      List<String> readyToDecrypt = listToDecrypt[i].split(",");
                      final x = new Account();
                      readyToDecrypt[1] = await x.decrypt(readyToDecrypt[1]);
                      decrypted.add(readyToDecrypt.join(","));
                    }

                    final requestCode = data["request_code"];
                    final decryptedAccount = decrypted.join("---");
                    final mediaList = mediaIds.join("---");

                    makeSchedule(
                        requestCode, decryptedAccount, mediaList, _date);
                  });

                  Navigator.pop(context);
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

  _showDatePicker(BuildContext context) async {
    final initialDate = DateTime.now();
    await showDatePicker(
            context: context,
            initialDate: _date,
            firstDate: initialDate.add(Duration(days: -1)),
            lastDate: initialDate.add(Duration(days: 30)))
        .then((picked) async {
      if (picked == null) {
        Navigator.pop(context);
        return;
      }
      setState(() => _date = picked);
    }).then((_) async {
      await showTimePicker(context: context, initialTime: _time)
          .then((timePicked) {
        setState(() => _time = timePicked);
      });

      setState(() =>
          _date = DateTime.parse(_formatDate(_date, _time, withZero: true)));
    }).catchError((error) {});
  }

  String _formatDate(DateTime d, TimeOfDay t, {bool withZero = false}) {
    final _dStr = formatDate(d, [yyyy, "-", mm, "-", dd]);
    final _tStr = t.format(context).toString();
    final _fullDate = _dStr + " " + _tStr + (withZero ? ":00" : "");
    return _fullDate;
  }
}
