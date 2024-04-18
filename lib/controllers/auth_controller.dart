import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../services/constants.dart';

class AuthController extends GetxController implements GetxService {
  bool _isLoading = false;
}
