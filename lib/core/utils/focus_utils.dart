import 'package:flutter/widgets.dart';

/// Whether keyboard input currently belongs to a text field.
///
/// Editor-wide shortcuts — Delete, Cut, Copy, Paste — must step aside while
/// the user is typing, or Backspace would delete the selected object instead
/// of a character and Cmd+C would copy the object instead of the selected
/// text.
bool textInputHasFocus() {
  final context = FocusManager.instance.primaryFocus?.context;
  if (context == null) {
    return false;
  }

  var isTextInput = false;
  context.visitAncestorElements((element) {
    if (element.widget is EditableText) {
      isTextInput = true;
      return false; // Stop visiting
    }
    return true; // Continue visiting
  });
  return isTextInput;
}
