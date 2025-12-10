/*
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/contact_model.dart';

final contactErrorProvider = StateProvider<String?>((ref) => null);

final contactListProvider = StateNotifierProvider<ContactController, List<ContactModel>>(
      (ref) => ContactController(ref),
);

class ContactController extends StateNotifier<List<ContactModel>> {
  final Ref ref;
  ContactController(this.ref) : super([]);

  void addContact(ContactModel contact) {
    try {
      state = [...state, contact];
      ref.read(contactErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(contactErrorProvider.notifier).state = e.toString();
    }
  }

  void updateContact(String id, ContactModel updatedContact) {
    try {
      state = [
        for (final c in state)
          if (c.id == id) updatedContact else c
      ];
      ref.read(contactErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(contactErrorProvider.notifier).state = e.toString();
    }
  }

  void deleteContact(String id) {
    try {
      state = state.where((c) => c.id != id).toList();
      ref.read(contactErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(contactErrorProvider.notifier).state = e.toString();
    }
  }

  ContactModel? getContactById(String id) {
    try {
      return state.firstWhere((c) => c.id == id);
    } catch (e) {
      ref.read(contactErrorProvider.notifier).state = "Contact not found";
      return null;
    }
  }

  List<ContactModel> searchByName(String name) {
    return state.where((c) => c.name.toLowerCase().contains(name.toLowerCase())).toList();
  }

  List<ContactModel> filterByStatus(String status) {
    return state.where((c) => c.status.toLowerCase() == status.toLowerCase()).toList();
  }

  Future<void> fetchContacts() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      ref.read(contactErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(contactErrorProvider.notifier).state = e.toString();
    }
  }
}
*/


// -------------------- Contacts Controller --------------------
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/contact_model.dart';

class ContactsController extends StateNotifier<ContactsState> {
  ContactsController() : super(ContactsState());

  // Text Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // ------------------ VALIDATIONS ------------------
  bool validateAllFields(BuildContext context) {
    if ((nameController.text.isEmpty)) {
      _showSnackBar(context, "Please enter your name.", Colors.orange);
      return false;
    }
    if ((emailController.text.isEmpty ||
        !emailController.text.contains('@') ||
        !emailController.text.contains('.'))) {
      _showSnackBar(context, "Please enter a valid email.", Colors.orange);
      return false;
    }
    if (subjectController.text.isEmpty) {
      _showSnackBar(context, "Please enter a subject.", Colors.orange);
      return false;
    }
    if (messageController.text.length < 10) {
      _showSnackBar(context, "Message must be at least 10 characters.", Colors.orange);
      return false;
    }
    if (phoneController.text.isNotEmpty &&
        !RegExp(r'^\+?\d{7,15}$').hasMatch(phoneController.text)) {
      _showSnackBar(context, "Enter a valid phone number.", Colors.orange);
      return false;
    }
    return true;
  }

  // ------------------ SEND FORM ------------------
  Future<void> sendContactForm(GlobalKey<FormState> formKey, BuildContext context) async {
    if (!validateAllFields(context)) return;

    state = state.copyWith(isSubmitting: true, errorMessage: null, isSuccess: false);

    try {
      final id = DateTime.now().millisecondsSinceEpoch.toString();

      final contact = ContactModel(
        id: id,
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        subject: subjectController.text.trim(),
        message: messageController.text.trim(),
        phone: phoneController.text.trim(),
        sentAt: DateTime.now(),
      );

      await FirebaseFirestore.instance.collection('contacts').doc(id).set(contact.toJson());

      state = state.copyWith(isSubmitting: false, isSuccess: true);

      _showSnackBar(context, "Message sent successfully!", Colors.green);

      // Clear all fields
      nameController.clear();
      emailController.clear();
      subjectController.clear();
      messageController.clear();
      phoneController.clear();

      // Reset success after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        state = state.copyWith(isSuccess: false);
      });
    } catch (e, st) {
      debugPrint('Firestore error: $e\n$st');
      state = state.copyWith(
        isSubmitting: false,
        isSuccess: false,
        errorMessage: 'Failed to send message. Please try again.',
      );
      _showSnackBar(context, "Failed to send message. Please try again.", Colors.red);
    }
  }

  // ------------------ HELPER ------------------
  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}

// ------------------ STATE ------------------
class ContactsState {
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  final String email;
  final String phone;
  final String location;

  ContactsState({
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
    this.email = "officialboolmont@gmail.com",
    this.phone = "+91 9425323096",
    this.location = "India",
  });

  ContactsState copyWith({
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return ContactsState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
      email: email,
      phone: phone,
      location: location,
    );
  }
}

// ------------------ PROVIDER ------------------
final contactsControllerProvider =
StateNotifierProvider<ContactsController, ContactsState>((ref) => ContactsController());
