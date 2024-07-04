enum ValidateType {
  normal,
  name,
}

class UtilValidator {
  static const String errorName = "Invalid Name Format";

  static String? validate(
    String data, {
    ValidateType? type = ValidateType.normal,
  }) {
    if (data.isEmpty) return null;

    switch (type) {
      case ValidateType.name:
        final nameRegex = RegExp(
          r"^[a-zA-Z]+([ '-][a-zA-Z]+)*$",
        );
        if (!nameRegex.hasMatch(data)) {
          return errorName;
        }
        break;

      default:
    }
    return null;
  }

  static final UtilValidator _instance = UtilValidator._internal();

  factory UtilValidator() {
    return _instance;
  }

  UtilValidator._internal();
}
