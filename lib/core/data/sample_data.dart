import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/about_model.dart';
import '../models/project_model.dart';
import '../models/service_model.dart';
import '../models/experience_model.dart';
import '../models/education_model.dart';
import '../models/contact_model.dart';
import '../models/company_model.dart';
import '../models/resume_model.dart';

class MockDataUploader {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // ---------------------------------------------------------
  // 1️⃣ USER MOCK DATA
  // ---------------------------------------------------------
  Future<void> uploadUserMock() async {
    final user = UserModel(
      id: 'u2',
      fullName: 'Sumit Jatiya',
      title: 'Flutter Developer & Cybersecurity Enthusiast',
      bio: 'I create secure, high-performance mobile and web applications.',
      email: 'sumit@gmail.com',
      phone: '+91 9876543210',
      profileImageUrl: 'https://i.pravatar.cc/150?img=3',
      website: 'https://rudhra.dev',
      skills: ['Flutter', 'Dart', 'Firebase', 'Cybersecurity', 'UI/UX'],
      interests: ['Open Source', 'AI', 'Ethical Hacking'],
      socialLinks: {
        'github': 'https://github.com/rudhra',
        'linkedin': 'https://linkedin.com/in/rudhra',
        'twitter': 'https://twitter.com/rudhra',
      },
      dob: DateTime(1998, 6, 15),
      location: 'Mandsaur M.P, India', education: [], experiences: [], projects: [], services: [], contacts: [],
      // bannerImageUrl: 'https://picsum.photos/1200/400',
    );

    await firestore.collection('users').doc(user.id).set(user.toJson());
  }

  // ---------------------------------------------------------
  // 2️⃣ ABOUT MOCK
  // ---------------------------------------------------------
  Future<void> uploadAboutMock() async {
    final about = AboutModel(
      id: 'a1',
      userId: 'u1',
      tagline: 'Flutter Developer | Cybersecurity Explorer',
      summary:
      'Building secure, beautiful, and high-performance applications using Flutter & Firebase.',
      keySkills: [
        'Mobile App Development',
        'Cybersecurity Practices',
        'Firebase Expertise'
      ],
      achievements: [
        '10+ Completed Projects',
        'Cybersecurity Certified',
        'Built portfolio with animations'
      ],
      profileImageUrl: 'https://i.pravatar.cc/200?img=4',
      coverImageUrl: 'https://picsum.photos/800/300',
      lastUpdated: DateTime.now(),
    );

    await firestore.collection('about').doc(about.id).set(about.toJson());
  }

  // ---------------------------------------------------------
  // 3️⃣ PROJECT MOCK
  // ---------------------------------------------------------
  Future<void> uploadProjectsMock() async {
    final project = ProjectModel(
      id: 'p1',
      title: 'Portfolio Web App',
      // subtitle: 'Personal Web Portfolio',
      description: 'A Flutter web portfolio with animations, themes, and Firebase.',
      imageUrl: 'https://picsum.photos/200/300',
      projectUrl: 'https://rudhra.dev',
      // githubUrl: 'https://github.com/rudhra/portfolio',
      category: 'Web App',
      technologies: ['Flutter', 'Dart', 'Firebase'],
      achievements: ['Dark Mode', 'Animations', 'Firebase Integration'],
      startDate: DateTime(2023, 5, 1),
      endDate: DateTime(2023, 6, 15),
       role: '',
    );

    await firestore.collection('projects').doc(project.id).set(project.toJson());
  }

  // ---------------------------------------------------------
  // 4️⃣ SERVICE MOCK
  // ---------------------------------------------------------
  Future<void> uploadServicesMock() async {
    final service = ServiceModel(
      id: 's1',
      title: 'Flutter App Development',
      description: 'Designing & developing fully responsive Flutter apps.',
      iconUrl: 'assets/icons/mobile.png',
      skillsUsed: ['Flutter', 'Firebase', 'Clean Architecture'],
      category: 'Mobile',
      // priceStartsFrom: '₹15,000',
      // isPopular: true,
    );

    await firestore.collection('services').doc(service.id).set(service.toJson());
  }

  // ---------------------------------------------------------
  // 5️⃣ EXPERIENCE MOCK
  // ---------------------------------------------------------
  Future<void> uploadExperienceMock() async {
    final exp = ExperienceModel(
      id: 'e1',
      companyId: 'BoolMont Technologies Pvt Ltd',
      role: 'Flutter Developer',
      location: 'Remote',
      employmentType: 'Full-time',
      startDate: DateTime(2022, 1, 1),
      endDate: DateTime(2023, 1, 1),
      isCurrent: false,
      description:
      'Worked on mobile applications and implemented secure app architectures.',
      achievements: [
        'Developed cross-platform apps',
        'Integrated Firebase services',
        'Implemented secure authentication'
      ],
      technologies: ['Flutter', 'Firebase', 'GitHub Actions'],
    );

    await firestore.collection('experiences').doc(exp.id).set(exp.toJson());
  }

  // ---------------------------------------------------------
  // 6️⃣ EDUCATION MOCK
  // ---------------------------------------------------------
  Future<void> uploadEducationMock() async {
    final edu = EducationModel(
      id: 'edu1',
      degree: 'B.Tech in Computer Science',
      institution: 'Delhi Technological University',
      location: 'Indore, India',
      startDate: DateTime(2016, 7, 1),
      endDate: DateTime(2020, 6, 30),
      gpa: 8.9,
      description: 'Focus on software engineering & cybersecurity.',
      courses: ['Data Structures', 'Flutter Dev', 'Network Security'],
      achievements: ['Dean’s List', 'Cybersecurity Certification'],
    );

    await firestore.collection('education').doc(edu.id).set(edu.toJson());
  }

  // ---------------------------------------------------------
  // 7️⃣ CONTACT MOCK
  // ---------------------------------------------------------
  Future<void> uploadContactMock() async {
    final c = ContactModel(
      id: 'ct1',
      name: 'A Client',
      email: 'client@example.com',
      subject: 'Project Inquiry',
      message: 'Hey Rudhra, I want to build a Flutter app.',
      sentAt: DateTime.now(),
      phone: '+1 234567890',
      status: 'new',
    );

    await firestore.collection('contacts').doc(c.id).set(c.toJson());
  }

  // ---------------------------------------------------------
  // 8️⃣ COMPANY MOCK
  // ---------------------------------------------------------
  Future<void> uploadCompanyMock() async {
    final company = CompanyModel(
      id: 'c1',
      name: 'BoolMont Technologist  Pvt Ltd',
      website: 'https://techsolutions.com',
      logoUrl: 'https://picsum.photos/100',
      description: 'A leading company in mobile & web development.',
      location: 'Bangalore, India',
      foundedDate: DateTime(2010, 5, 20),
      services: ['App Development', 'Security Consulting'],
      clients: ['Client A', 'Client B'],
      technologies: ['Flutter', 'React', 'Firebase'],
    );

    await firestore.collection('companies').doc(company.id).set(company.toJson());
  }

  // ---------------------------------------------------------
  // 9️⃣ RESUME MOCK
  // ---------------------------------------------------------
  Future<void> uploadResumeMock() async {
    final resume = ResumeModel(
      id: 'r1',
      userId: 'u1',
      title: 'Sumit Jatiya  Resume',
      fileUrl: 'https://example.com/resume.pdf',
      description: 'Flutter Developer & Cybersecurity Enthusiast.',
      uploadedAt: DateTime.now(),
      skills: ['Flutter', 'Firebase', 'Dart'],
      experiences: ['Flutter Developer - Tech Solutions Pvt Ltd'],
      education: ['B.Tech in CSE - DTU'],
    );

    await firestore.collection('resumes').doc(resume.id).set(resume.toJson());
  }
}

