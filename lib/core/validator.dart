String? validateUrl(String? url) {
  if (url == null || url.isEmpty) {
    return 'required';
  }

  if (url.length < 3) {
    return 'url invalid';
  } else if (!url.contains('.')) {
    return 'url invalid';
  }

  return null;
}
