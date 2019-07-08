import 'package:flutter/material.dart';

showBottomAlert(BuildContext context,{@required String text}) async{
  return showBottomSheet(context: context, builder: (context){
    return Text(text);
  });
}