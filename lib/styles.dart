import 'dart:ui';

import 'package:flutter/material.dart';

class Styles {

  static const _textSizeLarge = 25.0;
  static const _textSizeDefault = 16.0;
  static const _textSizeSmall = 12.0;
  static final Color _textColorStrong = _hexToColor('000000');
  static final Color _textColorDefault = _hexToColor('666666');
  static final Color _textColorFaint = _hexToColor('FFFFFF');
  static final Color accentColor = _hexToColor('FF0000');
  static final String _fontNameDefault = 'Rubik';

  static final navBarTitle = TextStyle(
    fontFamily: _fontNameDefault
  );

  static final headerLarge = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeLarge,
    color: _textColorFaint
  );

  static final largeDisplayNumber = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeLarge,
    color: _textColorFaint
  );

  static final textDefault = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeDefault,
    color: _textColorFaint
  );

  static final italicText = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeDefault,
    color: _textColorDefault,
    fontStyle: FontStyle.italic);

  static Color _hexToColor(String hexCode) {
    return Color(int.parse(hexCode.substring(0,6), radix: 16) + 0xFF000000);
  }

}