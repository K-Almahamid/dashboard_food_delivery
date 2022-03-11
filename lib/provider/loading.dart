import 'package:flutter/material.dart';

class LoadingControl with ChangeNotifier{

void addLoading(){
  notifyListeners();
}
}