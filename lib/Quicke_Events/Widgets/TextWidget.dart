import 'package:flutter/material.dart';

Widget TextWidget({
  required String title,
  double? size,
  dynamic fontWeight,
  dynamic color,
  dynamic maxline,
  dynamic alignment,
}) {
  return Text(
    "$title",
    maxLines: maxline,
    textAlign: alignment ?? TextAlign.start,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontSize: size ?? 12,
      fontWeight: fontWeight ?? FontWeight.w700,
      color: color ?? Colors.black,
    ),
  );
}
