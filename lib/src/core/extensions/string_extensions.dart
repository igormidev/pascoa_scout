extension StringX on String {
  String get normalized => replaceAll(RegExp(r'\s+'), '').toLowerCase();
  String get withoutWhitespace => replaceAll(RegExp(r'\s+'), '');
}
