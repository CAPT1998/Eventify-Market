import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickie_event/Constant.dart';


Widget TextFieldFeatures({
  TextEditingController? controller,
 required BuildContext context,
 required String name,
  TextInputType? inputtype,
  double? width,
  bool? isread,
  int? maxline,
  String? value,
  List<TextInputFormatter>? inputFormatters,
  dynamic prefixIcon,
  dynamic suffixIcon,
  Function(String)? onChanged,
  bool? obscureText,
}) {
  return TextFormField(
    obscureText: obscureText ?? false,
    keyboardType: inputtype ?? TextInputType.text,
    initialValue: value,
    readOnly: isread ?? false,
    maxLines: maxline ?? 1,
    onChanged: onChanged ?? (value) {},
    style: TextStyle(
      color: Color.fromARGB(255, 61, 61, 61),
    ),
    inputFormatters: inputFormatters ??
        <TextInputFormatter>[
          FilteringTextInputFormatter.singleLineFormatter,
        ],
    validator: (value) {
      if (value!.isEmpty) {
        return "Required this field";
      } else {
        return null;
      }
    },
    controller: controller,
    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      labelText: name,
      alignLabelWithHint: true,
      labelStyle: Theme.of(context).textTheme.bodyText1!.merge(
            TextStyle(color: Color.fromARGB(255, 61, 61, 61)),
          ),
      filled: true,
      fillColor: Color(0XFFB8BCBF),
      border: InputBorder.none,
      errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
            borderSide: BorderSide(color: appColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
            borderSide: BorderSide(color: Color(0XFFB8BCBF))),
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: appColor)),
    ),
  );
}
