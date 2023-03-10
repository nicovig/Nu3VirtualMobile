class ResetPasswordResponse {
  bool isPasswordReset;
  bool isUserExist;
  bool isEmailSent;

  ResetPasswordResponse(
      {required this.isPasswordReset,
      required this.isUserExist,
      required this.isEmailSent});

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> parsedJson) {
    return ResetPasswordResponse(
        isPasswordReset: parsedJson['isPasswordReset'] ?? false,
        isUserExist: parsedJson['isUserExist'] ?? false,
        isEmailSent: parsedJson['isEmailSent'] ?? false);
  }
}
