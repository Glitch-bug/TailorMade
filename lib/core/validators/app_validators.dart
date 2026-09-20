class AppValidators {
  static String? requiredField(String? value){
    if (value == null || value == '') {
      return 'This field is required';
    }
    return null;
  }
}