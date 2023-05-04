extension StringExtension on String {
  String capitalizeWord() {
    String curStr = this;
    curStr = curStr.replaceAll('-', ' ');

    curStr = curStr
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');

    return curStr;
  }

  String toKebabCase() {
    return replaceAll(' ', '-').toLowerCase();
  }
}
