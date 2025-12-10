class AppConstants {
  // ----------------- Basic App Info -----------------
  static const String appName = "Boolmont Portfolio";
  static const String companyName = "Boolmont Technologies";
  static const String founderName = "Sumit Jatiya";

  // ----------------- About Founder -----------------
  static const String shortBio =
      "Flutter Developer & Cybersecurity Learner • Future Founder of Boolmont Technologies.";

  static const String longBio =
      "I am a Computer Science Engineer, passionate about building secure, scalable "
      "and innovative digital products. I work on Flutter development, UI/UX, "
      "and cybersecurity fundamentals. I aim to build Boolmont Technologies — "
      "a company focused on modern apps, premium designs, and security-first development.";

  // ----------------- Contact Info -----------------
  static const String email = "your_email@example.com";
  static const String phone = "+91 00000 00000";
  static const String location = "India";
  static const String website = "https://www.boolmont.com";
  static const String portfolio = "https://www.boolmont.com/portfolio";

  // ----------------- Social Profiles -----------------
  static const Map<String, String> socialLinks = {
    "github": "https://github.com/YOUR_USERNAME",
    "linkedin": "https://linkedin.com/in/YOUR_PROFILE",
    "instagram": "https://instagram.com/YOUR_ID",
    "twitter": "https://twitter.com/YOUR_ID",
    "facebook": "https://facebook.com/YOUR_ID",
  };

  // ----------------- Company Vision & Mission -----------------
  static const String companyVision =
      "To deliver modern, secure, and innovative digital solutions "
      "that empower businesses across the world.";

  static const String companyMission =
      "Providing high-class app development, cybersecurity-focused products, "
      "and future-ready tech innovations.";

  // ----------------- Assets -----------------
  static const String profileImage = "assets/images/profile.png";
  static const String companyLogo = "assets/images/logo.png";

  // ----------------- Lottie Animations -----------------
  static const String splashAnimation = "assets/lottie/splash.json";
  static const String loadingAnimation = "assets/lottie/loading.json";

  // ----------------- App Version -----------------
  static const String version = "v1.0.0";

  // ----------------- Skills -----------------
  static const List<String> skills = [
    "Flutter",
    "Dart",
    "Firebase",
    "Cybersecurity Basics",
    "UI/UX Design",
    "Git & GitHub",
    "API Integration",
  ];

  // Optional: Categorized skills for future UI
  static const Map<String, List<String>> skillCategories = {
    "Development": ["Flutter", "Dart", "API Integration", "Firebase"],
    "Design": ["UI/UX Design"],
    "Tools": ["Git & GitHub"],
    "Security": ["Cybersecurity Basics"],
  };
}
