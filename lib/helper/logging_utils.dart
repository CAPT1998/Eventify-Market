class LoggingUtils{

  static printValue(String message, var value) {
    print(
        '<==================== $message ====================>');
    print(value);
  }

  static logging({url, jwt, header, body}) {
    print("<==================== API CALL START ====================>");
    if (url != null) {
      print(" ===> URL : " + url.toString());
    }
    if (jwt != null) {
      print(" ==> Auth : " + jwt.toString());
    }
    if (body != null) {
      print(" ==> Body : " + body.toString());
    }
    print("<==================== API CALL END ====================>");
  }

}