import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_app/presentation/styles/colors_manager.dart';

customToast({
      required String title,
      required Color color
    })
{
  Fluttertoast.showToast(
      msg: title,
      textColor: ColorManager.white,
      backgroundColor: color,
      gravity: ToastGravity.BOTTOM
  );

}
