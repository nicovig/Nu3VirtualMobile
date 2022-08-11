extension string_extensions on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp = new RegExp('[a-zA-Z]');
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPseudo {
    final nameRegExp = new RegExp('[a-zA-Z0-9.^@]');
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r"^(?=.{10,}$)(?=(?:.*?[A-Z]){1})(?=.*?[a-z])(?=(?:.*?[0-9]){1}).*$"); //Password which contains 2 capital, 1 minuscule, 1 number and a length of 10 at least
    return passwordRegExp.hasMatch(this);
  }

  bool get isNotNull {
    return this != null;
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r"^\+?0[0-9]{9}$");
    return phoneRegExp.hasMatch(this);
  }
}
