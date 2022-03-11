import 'package:dashboard_food_delivery/utils/colors.dart';
import 'package:flutter/material.dart';

Container circularProgress() {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(top: 10.0),
    child: const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(AppColors.mainColor),
    ),
    );
}

Container linearProgress() {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(bottom: 10.0),
    child: const LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(AppColors.mainColor),
    ),
  );
}