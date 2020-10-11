bool validEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

bool isNumeric(String txt) {
  String numeros = "0123456789";
  for (int i = 0; i < txt.length; ++i) {
    String c = txt[i];
    if (numeros.contains(c) == false) return false;
  }
  return true;
}
