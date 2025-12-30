class Validator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  static String? validateRePassword(String password, String? rePassword) {
    if (rePassword == null || rePassword.isEmpty) {
      return 'Password is required';
    }
    if (rePassword.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    if (password != rePassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters long';
    }
    return null;
  }

  static String? validateSurname(String? value) {
    if (value == null || value.isEmpty) {
      return 'Surname is required';
    }
    if (value.length < 2) {
      return 'Surname must be at least 2 characters long';
    }
    return null;
  }
}
