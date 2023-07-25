extension StringValidators on String {
  bool get containsUppercase => contains(RegExp(r'[A-Z]'));
  bool get containsLowercase => contains(RegExp(r'[a-z]'));
  bool get containsNumber => contains(RegExp(r'[0-9]'));
  bool get containsSpecialCharacter => contains(RegExp(r'[!@#$%^&*(),.?":{}|<>-_+=;]'));
}
