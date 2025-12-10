import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Helpers {
  // ----------------- Navigation -----------------
  static void navigateTo(BuildContext context, String route) {
    try {
      Navigator.pushNamed(context, route);
    } catch (e) {
      debugPrint("❌ Navigation error: $e");
    }
  }

  static void navigateReplace(BuildContext context, String route) {
    try {
      Navigator.pushReplacementNamed(context, route);
    } catch (e) {
      debugPrint("❌ Navigation replacement error: $e");
    }
  }

  static void goBack(BuildContext context) {
    try {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    } catch (e) {
      debugPrint("❌ Navigation pop error: $e");
    }
  }

  // ----------------- Snackbar -----------------
  static void showSnack(
      BuildContext context,
      String message, {
        bool isError = false,
        Duration duration = const Duration(seconds: 2),
      }) {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? Colors.redAccent : Colors.green,
          behavior: SnackBarBehavior.floating,
          duration: duration,
        ),
      );
    } catch (e) {
      debugPrint("❌ Snackbar error: $e");
    }
  }

  // ----------------- URL Launch -----------------
  static Future<void> openUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        debugPrint("❌ Could not launch URL: $url");
      }
    } catch (e) {
      debugPrint("❌ openUrl error: $e");
    }
  }

  static Future<void> sendEmail(String email) async {
    try {
      final Uri uri = Uri(scheme: 'mailto', path: email);
      if (!await launchUrl(uri)) {
        debugPrint("❌ Could not open email app for: $email");
      }
    } catch (e) {
      debugPrint("❌ sendEmail error: $e");
    }
  }

  // ----------------- Validators -----------------
  static bool isValidEmail(String email) {
    return RegExp(
        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(email);
  }

  static bool isValidPhone(String phone) {
    return RegExp(r"^[0-9]{10}$").hasMatch(phone);
  }

  // ----------------- Screen Size Utilities -----------------
  static Size screenSize(BuildContext context) => MediaQuery.of(context).size;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  // ----------------- Logging -----------------
  static void log(String message) {
    debugPrint("📌 LOG: $message");
  }

  // ----------------- Random ID Generator -----------------
  static String generateId() => DateTime.now().millisecondsSinceEpoch.toString();

  // ----------------- Misc Utilities -----------------
  /// Show a simple dialog with title, message and optional OK button
  static void showDialogMessage(
      BuildContext context, {
        required String title,
        required String message,
        String buttonText = "OK",
      }) {
    try {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(buttonText),
            ),
          ],
        ),
      );
    } catch (e) {
      debugPrint("❌ showDialogMessage error: $e");
    }
  }
}
