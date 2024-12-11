

import 'package:flutter/cupertino.dart';

class NavigationList{
    String label;
    Widget widget;
    bool showNabBar;
    Widget icon;
    Widget iconSelected;
    Color colorSelected;
    NavigationList(
        this.label,
        this.widget,
        this.showNabBar,
        this.icon,
        this.iconSelected,
        this.colorSelected
    );
}