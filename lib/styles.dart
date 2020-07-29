

import 'package:flutter/material.dart';

Widget smallHeader(BuildContext context, String text) {
  return Text(
    text,
    style: Theme.of(context).textTheme.headline6
  );
}

Widget bigText(BuildContext context, String text) {
  return Text(
    text,
    style: Theme.of(context).textTheme.headline3
  );
}

Widget sortaBigText(BuildContext context, String text) {
  return Text(
    text,
    style: Theme.of(context).textTheme.headline4
  );


}