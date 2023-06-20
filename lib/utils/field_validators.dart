import 'dart:developer';
import 'dart:ffi';

extension FieldValidator on String {
  //---------------- Empty Validator -----------------
  validateEmpty(String message) {
    if (isEmpty) {
      return '$message field can\'t be empty.';
    } else {
      return null;
    }
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
