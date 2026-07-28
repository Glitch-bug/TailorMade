extension StringExtension on String {
  String  toTitleCase() {
   return replaceFirst(this[0], this[0].toUpperCase());
  } 
  
}

