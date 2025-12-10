import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/modules/contacts/contacts_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/constants/custom_app_bar.dart';
import '../../app/theme/app_theme.dart';
import '../../widgets/custom_button.dart';

// --- UTILITY FUNCTION ---
void _launchURL(String url) async {
  if (url.isNotEmpty && await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  } else {
    debugPrint('Could not launch $url');
  }
}
class ContactsScreen extends ConsumerStatefulWidget {
  const ContactsScreen({super.key});

  @override
  ConsumerState<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends ConsumerState<ContactsScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // --- FocusNodes for each field ---
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _subjectFocus = FocusNode();
  final FocusNode _messageFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _subjectFocus.dispose();
    _messageFocus.dispose();
    super.dispose();
  }

  Map<String, Color> get _colors {
    final isDarkMode = ref.watch(isDarkThemeProvider);
    return getCurrentColors(isDarkMode);
  }

  Widget _buildAnimatedTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    // required String? Function(String?) validator,
    required FocusNode focusNode,
    int maxLines = 1,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: _colors['cardColor']!.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: focusNode.hasFocus
              ? _colors['primaryAccent']!
              : _colors['secondaryText']!.withOpacity(0.5),
          width: focusNode.hasFocus ? 2 : 1,
        ),
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        // validator: validator,
        maxLines: maxLines,
        style: TextStyle(color: _colors['linkColor'], fontSize: 16),
        cursorColor: _colors['primaryAccent'],
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: _colors['secondaryText'], fontWeight: FontWeight.w500),
          prefixIcon: Icon(icon, color: _colors['primaryAccent'], size: 20),
          border: InputBorder.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(contactsControllerProvider.notifier);
    final state = ref.watch(contactsControllerProvider);
    final colors = getCurrentColors(ref.watch(isDarkThemeProvider));

    return Scaffold(
      backgroundColor: _colors['background'],
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 800;
          final double padding = isDesktop ? 60.0 : 20.0;

          return FocusScope(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: padding, vertical: 30),
              child: isDesktop
                  ? Column(
                    children: [
                      if (isDesktop) CustomNavigationBar(isDesktop: true),
                      SizedBox(height: 10,),

                      Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                      Expanded(flex: 1, child: _buildContactInfoPanel(state, true)),
                      const SizedBox(width: 40),
                      Expanded(flex: 2, child: _buildAnimatedFormCard(controller, state)),
                                      ],
                                    ),
                    ],
                  )
                  : Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/boolMont_logo.png',
                        height: 60,
                        fit: BoxFit.contain,
                        colorBlendMode: BlendMode
                            .srcATop, // Or another BlendMode like BlendMode.srcIn
                        color:
                        colors['primaryAccent'], // The color you want to apply
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  _buildContactInfoPanel(state, false),
                  const SizedBox(height: 30),
                  _buildAnimatedFormCard(controller, state),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnimatedFormCard(ContactsController controller, ContactsState state) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
        ),
        child: Card(
          color: _colors['cardColor'],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 12,
          shadowColor: _colors['primaryAccent']!.withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Send Me A Message",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: _colors['linkColor'],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildAnimatedTextField(
                      controller: controller.nameController,
                      labelText: "Full Name",
                      icon: FontAwesomeIcons.solidUser,
                      // validator: controller.validateName,
                      focusNode: _nameFocus),
                  const SizedBox(height: 20),
                  _buildAnimatedTextField(
                      controller: controller.emailController,
                      labelText: "Email",
                      icon: FontAwesomeIcons.solidEnvelope,
                      // validator: controller.validateEmail,
                      focusNode: _emailFocus),
                  const SizedBox(height: 20),
                  _buildAnimatedTextField(
                      controller: controller.subjectController,
                      labelText: "Subject",
                      icon: FontAwesomeIcons.tag,
                      // validator: controller.validateSubject,
                      focusNode: _subjectFocus),
                  const SizedBox(height: 20),
                  _buildAnimatedTextField(
                      controller: controller.messageController,
                      labelText: "Message",
                      icon: FontAwesomeIcons.solidCommentDots,
                      maxLines: 6,
                      // validator: controller.validateMessage,
                      focusNode: _messageFocus),
                  const SizedBox(height: 30),
                  if (state.errorMessage != null)
                    Text(state.errorMessage!, style: TextStyle(color: Colors.red)),
                  // if (state.isSuccess)
                  //   Text("Message sent successfully!", style: TextStyle(color: Colors.green)),
                  // const SizedBox(height: 20),
                  const SizedBox(height: 30),

// Only show the button; messages are shown via SnackBar (top toast)
                  CustomButton(
                    text: state.isSubmitting ? "Sending..." : "Send Message",
                    isLoading: state.isSubmitting,
                    onPressed: state.isSubmitting
                        ? () {}
                        : () => controller.sendContactForm(_formKey, context),
                    height: 55,
                    borderRadius: 16,
                    fontSize: 18,
                    // color: _colors['primaryAccent']!,
                    // textColor: _colors['secondaryText']!,
                    backgroundColor:  _colors['primaryAccent']!,
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfoPanel(ContactsState state, bool isDesktop) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: _colors['primaryAccent']!.withOpacity(0.1),
        borderRadius:  BorderRadius.circular(16) ,
        border:  Border.all(color: _colors['primaryAccent']!, width: 1.5)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Direct Contact Details",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: _colors['primaryAccent'])),
          const Divider(height: 30, thickness: 2, color: Colors.transparent),
          _buildInfoItem(FontAwesomeIcons.solidEnvelope, "Email", state.email, () => _launchURL('mailto:${state.email}')),
          const SizedBox(height: 20),
          _buildInfoItem(FontAwesomeIcons.phone, "Phone", state.phone, () => _launchURL('tel:${state.phone}')),
          const SizedBox(height: 20),
          _buildInfoItem(FontAwesomeIcons.locationDot, "Location", state.location),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String title, String subtitle, [VoidCallback? onTap]) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon, color: _colors['primaryAccent'], size: 20),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: _colors['linkColor'],
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2), // space between text and line
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          color: _colors['secondaryText'],
                          fontSize: 15,
                        ),
                      ),
                    ),
                    if (onTap != null)
                      Positioned(
                        bottom: 0, // underline at bottom
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 1.5, // underline thickness
                          color: _colors['primaryAccent'],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
