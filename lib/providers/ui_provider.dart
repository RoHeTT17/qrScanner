import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier{

  int _selectedMenuOpt = 0;

  int get selectedMenuOpt{
    return this._selectedMenuOpt;
  }

  set selectedMenuOpt (int index){
    //print(index);
    this._selectedMenuOpt = index;
    notifyListeners();
  }

}