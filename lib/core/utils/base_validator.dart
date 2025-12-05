class BaseValidator {
  static String? required(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return message ?? "This field is required";
    }
    return null;
  }

  static String? email(String? value, {String message = "Invalid email"}) {
    if (value == null || value.isEmpty) return null;

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return message;
    }
    return null;
  }

  static String? minLength(String? value, int length, {String? message}) {
    if (value != null && value.length < length) {
      return message ?? "Must be at least $length characters";
    }
    return null;
  }

  static String? maxLength(String? value, int length, {String? message}) {
    if (value != null && value.length > length) {
      return message ?? "Must be at most $length characters";
    }
    return null;
  }

  static String? match(String? value, String? other, {String? message}) {
    if (value != other) {
      return message ?? "Values do not match";
    }
    return null;
  }
}
