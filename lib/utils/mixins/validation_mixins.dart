class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
  );
  static final RegExp _nameRegExp = RegExp(
    r'^[a-zA-Z0-9](_(?!(\.|_))|(\s*)|\.(?!(_|\.))|[a-zA-Z0-9]){6,18}[a-zA-Z0-9]$',
  );

  static final RegExp _mobileRegExp = RegExp(
    r'^1(?=[0125])[0-9]{9}',
  );

  static String isValidEmail(String email) {
    if (email.isEmpty)
      return 'Email is required.';
    else if (!_emailRegExp.hasMatch(email))
      return "Invalid Email.";
    else
      return null;
  }

  static String isValidPassword(String password) {
    if (password.isEmpty)
      return 'Password is required.';
    else if (!_passwordRegExp.hasMatch(password))
      return "Invalid Email.";
    else
      return null;
  }

  static String isValidPhoneNumber(String number) {
    if (number.isEmpty)
      return null;
    else if (!_mobileRegExp.hasMatch(number))
      return 'Invalid phone number.';
    else
      return null;
  }

  static String isValidUserName(String userName) {
    if (userName.isEmpty)
      return 'User name is required.';
    else if (!_nameRegExp.hasMatch(userName))
      return 'Invalid user name.';
    else
      return null;
  }
}
