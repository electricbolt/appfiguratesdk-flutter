// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:appfigurateflutter/appfigurateflutter.dart';

class ExampleConfiguration extends APLNativeConfiguration {
  factory ExampleConfiguration() => _instance;

  static final ExampleConfiguration _instance = ExampleConfiguration._internal();

  ExampleConfiguration._internal();
  
  bool get boolean => nativeBool(Platform.isAndroid ? 'bool' : 'boolean');

  String get string_Textfield => nativeString('string_Textfield');

  String get string_RegexTextfield => nativeString('string_RegexTextfield');

  String get string_List => nativeString('string_List');

  String get string_Textfield_List => nativeString('string_Textfield_List');

  String get string_RegexTextfield_List =>
      nativeString('string_RegexTextfield_List');

  String get encrypted_string_Textfield_List =>
      nativeString('encrypted_string_Textfield_List');

  String get encrypted_string_RegexTextfield_List =>
      nativeString('encrypted_string_RegexTextfield_List');

  int get integer_Slider => nativeInt('integer_Slider');

  int get integer_Textfield => nativeInt('integer_Textfield');

  int get integer_RegexTextfield => nativeInt('integer_RegexTextfield');

  int get integer_List => nativeInt('integer_List');

  int get integer_Textfield_List => nativeInt('integer_Textfield_List');

  int get integer_RegexTextfield_List =>
      nativeInt('integer_RegexTextfield_List');

  double get float_Slider => nativeDouble('float_Slider');

  double get float_Textfield => nativeDouble('float_Textfield');

  double get float_RegexTextfield => nativeDouble('float_RegexTextfield');

  double get float_List => nativeDouble('float_List');

  double get float_Textfield_List => nativeDouble('float_Textfield_List');

  double get float_RegexTextfield_List =>
      nativeDouble('float_RegexTextfield_List');

  double get double_Slider => nativeDouble('double_Slider');

  double get double_Textfield => nativeDouble('double_Textfield');

  double get double_RegexTextfield => nativeDouble('double_RegexTextfield');

  double get double_List => nativeDouble('double_List');

  double get double_Textfield_List => nativeDouble('double_Textfield_List');

  double get double_RegexTextfield_List =>
      nativeDouble('double_RegexTextfield_List');

  @override
  void actionExecuted(String action) {
    print(action);
  }

}
