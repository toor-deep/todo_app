class ErrorMessage {
  static const String pleaseEnterEmail = "Please enter email";
  static const String enterValidEmail = "Please enter valid email address";
  static const String pleaseEnterPhoneNumber = "Please enter phone number";
  static const String enterValidPhone = "Please enter valid number";
}

extension TextFieldValidator on String {
  String? isValidEmail() {
    if (isEmpty) {
      return ErrorMessage.pleaseEnterEmail;
    } else if (length > 0 && !GetUtils.isEmail(this)) {
      return ErrorMessage.enterValidEmail;
    }
    return null;
  }

  String? isValidPhoneNumber() {
    if (isEmpty) {
      return ErrorMessage.pleaseEnterPhoneNumber;
    } else if (length > 0 && !GetUtils.isPhoneNumber(this)) {
      return ErrorMessage.enterValidPhone;
    }
    return null;

  }

  String? isValidPhoneNumberV2() {
    if (isEmpty) {
      return ErrorMessage.pleaseEnterPhoneNumber;
    } else if (length > 0 && !GetUtils.isPhoneNumber(this)) {
      return ErrorMessage.enterValidPhone;
    }
    return null;

  }

  String? isEmptyField({required String messageTitle}) {
    if (trim().isEmpty) {
      return messageTitle;
    }
    return null;

  }

  String? isEmptyFieldWithNoNumber({String? messageTitle}) {
    if (isEmpty) {
      return "$messageTitle can't be empty";
    } else if (int.tryParse(replaceAll(' ', '')) != null) {
      return "Invalid $messageTitle ";
    }
    return null;

  }

  String? validatePassword() {
    if (isEmpty) {
      return "Please enter password";
    } else if (length<6) {
      return 'Password must be at least 6 characters';
    } else {
      return null;
    }
  }

  String? validateOtp() {
    if (isEmpty) {
      return "Please enter OTP";
    } else if (length > 0 && !GetUtils.isNumericOnly(this)) {
      return 'Please enter valid OTP';
    } else {
      return null;
    }
  }

  String? validateConfirmPassword({required String password}) {
    if (isEmpty) {
      return "Please enter password";
    } else if (password != this) {
      return 'Enter same password';
    } else {
      return null;
    }
  }
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter an Email Address';
    }

    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(emailPattern);

    if (!regex.hasMatch(value)) {
      return 'Enter a Valid Email Address';
    }

    return null;
  }
}

class GetUtils {
  static bool hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }

  /// Checks if string is email.
  static bool isEmail(String s) => hasMatch(s,
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  static bool isNumericOnly(String s) => hasMatch(s, r'^\d+$');

  static bool isPhoneNumber(String s) {
    if (s.length > 16 || s.length < 5) return false;
    return hasMatch(s, r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
  }

  static bool isPasswordValid(String value) {
    final hasUpperCase = RegExp(r'[A-Z]').hasMatch(value);
    final hasLowerCase = RegExp(r'[a-z]').hasMatch(value);
    final hasNumeric = RegExp(r'[0-9]').hasMatch(value);
    final hasSpecialChar =RegExp(r'[!@#\$%\^&\*\(\)_\+\-\=\{\}\[\]:;<>,.?~\\/]')
        .hasMatch(value);

    return [hasUpperCase, hasLowerCase, hasNumeric, hasSpecialChar]
        .where((element) => element)
        .length >=
        4;
  }
}
