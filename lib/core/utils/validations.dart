String? validateIsEmpty(String? value, String msg) {
  return (value == null || value.isEmpty) ? msg : null;
}
