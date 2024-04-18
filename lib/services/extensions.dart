import 'package:flutter/material.dart';

extension CapExtension on String? {
  String get inCaps => isValid
      ? (this!.isNotEmpty
          ? '${this![0].toUpperCase()}${this!.substring(1)}'
          : '')
      : '';
  String get capitalizeFirstOfEach => isValid
      ? (this!
          .replaceAll(RegExp(' +'), ' ')
          .split(" ")
          .map((str) => str.inCaps)
          .join(" "))
      : '';
  bool get isValid => this != null && this!.isNotEmpty;
  bool get isNotValid => this == null || this!.isEmpty;
  bool get isEmail => RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(this!);
  bool get isNotEmail => !(RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(this!));
  String get initials {
    if (isValid) {
      var list = this!.trim().split(' ');
      if (list.length > 1) {
        return (list.first.isValid ? list.first[0] : '') +
            (list.last.isValid ? list.last[0] : '');
      } else {
        return this![0];
      }
      // return (this!.replaceAll(RegExp(' +'), ' ').split(" ").map((str) => str.inCaps).join(" "));
    } else {
      return '';
    }
  }

  String get getIfValid => isValid ? this! : '';
  String get removeAllWhitespace => isValid ? this!.replaceAll(' ', '') : this!;
  String get extension {
    String extension = isValid ? this!.split('/').last.split('.').last : '';
    if (extension.length > 5) {
      extension = 'jpg';
    }
    return extension;
  }

  String get url {
    if (isValid) {
      if (this!.startsWith('http') ||
          this!.startsWith('https') ||
          this!.startsWith('www.')) {
        return this!;
      } else {
        return 'https://$this';
      }
    }
    return '';
  }

  String get fileName {
    String extension = isValid ? this!.split('/').last : '';
    return extension;
  }
}

extension Context on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  Color get primaryColor => Theme.of(this).primaryColor;
  double get bottomViewInsets => MediaQuery.of(this).viewInsets.bottom;
// Color get primaryColor => Theme.of(this).copyWith();
}
