extension string_extensions on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp = RegExp(r"[a-zA-Z]");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPseudo {
    final nameRegExp = RegExp('[a-zA-Z0-9.^@]');
    return nameRegExp.hasMatch(this);
  }

  bool get isValidNumber {
    final nameRegExp = RegExp(r"[0-9]");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>'); //Password must contain an uppercase, lowercase, numeric digit and special character
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
