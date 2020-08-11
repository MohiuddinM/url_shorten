class Validator {
  static String validateUrl(String name) {
    if (name.length < 3) {
      return 'Please enter a valid name';
    } else if (!name.contains(' ')) {
      return 'Please enter your full name';
    }

    return null;
  }
}
