/// Returns [true] if [s] is a not null or empty string.
bool isNotEmpty(String s) => s != null && s.isNotEmpty && s != 'null';
String listOfStringToFormattedString(List data) {
  return data[0].toString();
  // return data.join("\n\n");
}
