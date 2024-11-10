import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:forum_app/constants/constant.dart';
import 'package:forum_app/views/home_page.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class AuthenticationController extends GetxController {
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final token = ''.obs;
  final box = GetStorage();

  Future register({
    required String name,
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    var data = {
      'name': name,
      'username': username,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
    };

    try {
      isLoading.value = true;

      if (name.isEmpty ||
          username.isEmpty ||
          email.isEmpty ||
          password.isEmpty ||
          confirmPassword.isEmpty) {
        _showErrorSnackbar('All fields must be filled!');
        return;
      }

      if (password != confirmPassword) {
        _showErrorSnackbar(
            'Password and Confirmation Password must be the same!');
        return;
      }

      final response = await http.post(
        Uri.parse('$url/auth/register'),
        headers: {'Accept': 'application/json'},
        body: data,
      );

      if (response.statusCode == 201) {
        debugPrint('Response: ${jsonDecode(response.body)}');
        _showSuccessSnackbar("Registration Successful");
        token.value = jsonDecode(response.body)['token'];
        box.write('token', token.value);
        Get.offAll(() => HomePage());
      } else {
        _handleError(response);
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: ${e.toString()}';
      debugPrint(errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future login({required String username, required String password}) async {
    var data = {'username': username, 'password': password};

    try {
      isLoading.value = true;

      if (username.isEmpty || password.isEmpty) {
        _showErrorSnackbar('Username and Password are required!');
        return;
      }

      final response = await http.post(
        Uri.parse('$url/auth/login'),
        headers: {'Accept': 'application/json'},
        body: data,
      );

      if (response.statusCode == 200) {
        debugPrint('Response: ${jsonDecode(response.body)}');
        _showSuccessSnackbar("Login Successful");
        token.value = jsonDecode(response.body)['token'];
        box.write('token', token.value);
        Get.offAll(() => HomePage());
      } else {
        _handleError(response);
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: ${e.toString()}';
      debugPrint(errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  void _handleError(http.Response response) {
    try {
      final errorResponse = jsonDecode(response.body);
      errorMessage.value = errorResponse['message'] ?? 'An error occurred';
    } catch (e) {
      errorMessage.value = 'An error occurred';
    }
    debugPrint(errorMessage.value);
    _showErrorSnackbar(errorMessage.value);
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  void _showSuccessSnackbar(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
