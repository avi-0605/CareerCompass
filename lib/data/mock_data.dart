import '../models/resume.dart';
import '../models/job.dart';
import '../models/assessment.dart';
import '../models/question.dart';
import '../models/mentor.dart';
import '../models/booking.dart';

class MockData {
  // Initial Resume Data
  static Resume initialResume = Resume(
    id: 'res_001',
    name: 'Aavani Sharma',
    email: 'aavani.sharma@example.com',
    phone: '+91 98765 43210',
    location: 'Bengaluru, Karnataka',
    linkedIn: 'https://linkedin.com/in/aavanisharma',
    gitHub: 'https://github.com/aavani-dev',
    portfolio: 'https://aavani.dev',
    summary: 'Passionate Flutter & Mobile App Developer with 2+ years of experience building performant cross-platform user interfaces, implementing state management, and consuming REST APIs.',
    education: [
      Education(
        id: 'edu_1',
        institution: 'Indian Institute of Technology, Bangalore',
        degree: 'Bachelor of Technology',
        fieldOfStudy: 'Computer Science and Engineering',
        startYear: '2021',
        endYear: '2025',
        grade: '8.8 CGPA',
      ),
    ],
    experience: [
      Experience(
        id: 'exp_1',
        jobTitle: 'Flutter Developer Intern',
        company: 'TechCraft Solutions',
        location: 'Bengaluru, India',
        startDate: 'Jan 2024',
        endDate: 'Jul 2024',
        description: 'Developed responsive UI screens with Material 3, implemented Provider state management, and improved app load time by 35%.',
      ),
      Experience(
        id: 'exp_2',
        jobTitle: 'Frontend Developer Trainee',
        company: 'Innovate Labs',
        location: 'Remote',
        startDate: 'Jun 2023',
        endDate: 'Dec 2023',
        description: 'Built interactive dashboard components using React and TypeScript, integrated GraphQL endpoints, and wrote clean unit tests.',
      ),
    ],
    skills: [
      Skill(name: 'Flutter', level: SkillLevel.expert),
      Skill(name: 'Dart', level: SkillLevel.advanced),
      Skill(name: 'REST APIs', level: SkillLevel.advanced),
      Skill(name: 'Provider / Riverpod', level: SkillLevel.intermediate),
      Skill(name: 'Git & GitHub', level: SkillLevel.advanced),
      Skill(name: 'UI/UX Design', level: SkillLevel.intermediate),
      Skill(name: 'Firebase', level: SkillLevel.intermediate),
    ],
    projects: [
      Project(
        id: 'proj_1',
        name: 'CareerCompass App',
        description: 'A comprehensive career guidance platform with resume builder, quiz scoring, and mentor booking.',
        technologies: 'Flutter, Dart, Provider, Material 3',
        projectLink: 'https://github.com/aavani-dev/career_compass',
      ),
      Project(
        id: 'proj_2',
        name: 'EduTrack Mobile',
        description: 'Student academic performance dashboard with custom chart visualizations and assignment reminders.',
        technologies: 'Flutter, Firebase, Charts Flutter',
        projectLink: 'https://github.com/aavani-dev/edutrack',
      ),
    ],
    certifications: [
      Certification(
        id: 'cert_1',
        name: 'Google Certified Associate Android / Flutter Developer',
        issuingOrganization: 'Google Developers',
        date: 'Mar 2024',
        credentialUrl: 'https://g.co/credentials/flutter_aavani',
      ),
    ],
  );

  // Mock Jobs
  static List<Job> mockJobs = [
    Job(
      id: 'job_1',
      title: 'Frontend Developer',
      company: 'Google',
      companyLogoUrl: 'https://images.unsplash.com/photo-1573804633927-bfcbcd909acd?auto=format&fit=crop&w=120&q=80',
      location: 'Mumbai • Hybrid',
      workType: 'Hybrid',
      jobType: 'Full-time',
      salary: '₹12–18 LPA',
      experience: '2+ years',
      description: 'We are looking for a creative Frontend Developer to design and implement highly engaging user interfaces for next-generation Google Cloud dashboard products.',
      responsibilities: [
        'Build responsive, scalable web interfaces using React, TypeScript, and modern CSS frameworks.',
        'Collaborate with product designers and UX researchers to refine interactive prototypes.',
        'Optimize component render speeds and maintain comprehensive unit test coverage (>85%).',
        'Participate in design reviews and mentor junior engineering team members.'
      ],
      requirements: [
        'Bachelor\'s degree in Computer Science, STEM, or equivalent experience.',
        'Strong proficiency in JavaScript, TypeScript, HTML5, and CSS3/Sass.',
        '2+ years of hands-on experience building web applications with modern JS frameworks.',
        'Familiarity with CI/CD tools, Webpack/Vite build configurations, and Git workflow.'
      ],
      skills: ['React', 'JavaScript', 'TypeScript', 'CSS3', 'REST APIs'],
      benefits: ['Flexible Working Hours', 'Health Insurance & Wellness Credits', 'Annual Education & Course Allowance', 'Free On-site Meals'],
      postedDate: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Job(
      id: 'job_2',
      title: 'Senior Flutter Engineer',
      company: 'Swiggy',
      companyLogoUrl: 'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?auto=format&fit=crop&w=120&q=80',
      location: 'Bengaluru • On-site',
      workType: 'On-site',
      jobType: 'Full-time',
      salary: '₹24–32 LPA',
      experience: '4+ years',
      description: 'Join Swiggy\'s Mobile Core team to spearhead architecting scalable Flutter mobile modules served to over 20M active users.',
      responsibilities: [
        'Architect robust Flutter modules using BLoC or Riverpod architecture.',
        'Implement native iOS/Android platform channels when interfacing with device sensors & payment SDKs.',
        'Maintain zero-crash runtime standards and conduct peer code reviews.',
        'Optimize app launch performance, memory footprints, and frame frame rate stability (60fps).'
      ],
      requirements: [
        'Degree in Computer Science or related engineering background.',
        '4+ years of professional mobile app development (Flutter & Dart expertise required).',
        'Demonstrated experience shipping 2+ production apps to Play Store & App Store.',
        'In-depth knowledge of Dart async runtime, isolate channels, and dynamic animations.'
      ],
      skills: ['Flutter', 'Dart', 'BLoC', 'iOS/Android Native', 'State Management'],
      benefits: ['Generous Stock Options (ESOPs)', 'Comprehensive Medical Insurance', 'Learning Stipend', 'Flexible Leaves'],
      postedDate: DateTime.now().subtract(const Duration(days: 1)),
      isBookmarked: true,
    ),
    Job(
      id: 'job_3',
      title: 'Mobile App Developer (Flutter)',
      company: 'Razorpay',
      companyLogoUrl: 'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?auto=format&fit=crop&w=120&q=80',
      location: 'Remote',
      workType: 'Remote',
      jobType: 'Full-time',
      salary: '₹14–22 LPA',
      experience: '2–4 years',
      description: 'Razorpay is hiring Flutter developers to craft smooth, secure merchant checkouts and mobile wallet interfaces across India.',
      responsibilities: [
        'Develop secure financial UI components using Flutter & Dart.',
        'Integrate payment gateways, bio-metric auth, and real-time socket connections.',
        'Work closely with backend teams to define clean OpenAPI endpoints.'
      ],
      requirements: [
        '2+ years experience building mobile applications.',
        'Deep familiarity with Dart null safety, Material 3, and state management.',
        'Passion for high security and sleek UI micro-animations.'
      ],
      skills: ['Flutter', 'Dart', 'Security', 'REST APIs', 'Provider'],
      benefits: ['100% Remote Flexibility', 'Home Office Setup Stipend', 'Health Insurance', 'Sabbatical Policy'],
      postedDate: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Job(
      id: 'job_4',
      title: 'UI/UX Mobile Designer',
      company: 'CRED',
      companyLogoUrl: 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?auto=format&fit=crop&w=120&q=80',
      location: 'Bengaluru • Hybrid',
      workType: 'Hybrid',
      jobType: 'Full-time',
      salary: '₹18–25 LPA',
      experience: '3+ years',
      description: 'Craft bold visual styles, micro-interactions, and dark mode UI components for high-trust financial rewards apps.',
      responsibilities: [
        'Create high-fidelity wireframes, UI mocks, and interactive prototypes in Figma.',
        'Collaborate with Flutter mobile engineers to ensure pixel-perfect visual fidelity.'
      ],
      requirements: [
        'Strong portfolio displaying mobile app visual design mastery.',
        'Proficiency in Figma, Principle, and UI prototyping tools.'
      ],
      skills: ['Figma', 'UI/UX Design', 'Prototyping', 'Design Systems', 'Micro-interactions'],
      benefits: ['Unlimited Paid Time Off', 'Mental Health Support', 'Top-tier Tech Gear'],
      postedDate: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Job(
      id: 'job_5',
      title: 'Flutter Developer Intern',
      company: 'Zomato',
      companyLogoUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=120&q=80',
      location: 'Gurugram • On-site',
      workType: 'On-site',
      jobType: 'Internship',
      salary: '₹35,000 / month',
      experience: '0–1 year',
      description: 'Ideal 6-month internship for enthusiastic college students looking to get hands-on experience building consumer mobile apps at scale.',
      responsibilities: [
        'Assist senior developers in fixing UI bugs and building new feature components.',
        'Write clean unit tests and widget tests.'
      ],
      requirements: [
        'Pursuing or freshly completed B.Tech / BCA / MCA in CS/IT.',
        'Working knowledge of Flutter, Dart, and Git.'
      ],
      skills: ['Flutter', 'Dart', 'Git', 'Widget Testing'],
      benefits: ['Pre-placement Offer (PPO) Potential', 'Free Food & Snacks', 'Certificate & Mentorship'],
      postedDate: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  // Mock Skill Assessments
  static List<Assessment> mockAssessments = [
    Assessment(
      id: 'assess_flutter',
      title: 'Flutter Development',
      category: 'Mobile Development',
      difficulty: 'Intermediate',
      estimatedTimeMinutes: 15,
      questions: [
        Question(
          id: 'q1',
          text: 'Which widget is commonly used for vertically arranging children in Flutter?',
          options: ['Row', 'Column', 'Stack', 'Container'],
          correctAnswerIndex: 1,
        ),
        Question(
          id: 'q2',
          text: 'What method is called to force a StatefulWidget to rebuild its UI?',
          options: ['setState()', 'build()', 'initState()', 'reload()'],
          correctAnswerIndex: 0,
        ),
        Question(
          id: 'q3',
          text: 'Which file stores project dependencies and metadata in a Flutter app?',
          options: ['build.gradle', 'pubspec.yaml', 'manifest.xml', 'config.json'],
          correctAnswerIndex: 1,
        ),
        Question(
          id: 'q4',
          text: 'What is the purpose of the Expanded widget in Flutter layout rendering?',
          options: [
            'Adds padding around a widget',
            'Expands a child of Row/Column to fill available flex space',
            'Scales the text font size',
            'Makes a container scrollable'
          ],
          correctAnswerIndex: 1,
        ),
        Question(
          id: 'q5',
          text: 'In Flutter, what lifecycle method is called exactly once when a StatefulWidget is created?',
          options: ['build()', 'dispose()', 'initState()', 'didUpdateWidget()'],
          correctAnswerIndex: 2,
        ),
      ],
    ),
    Assessment(
      id: 'assess_dart',
      title: 'Dart Language Basics',
      category: 'Programming Languages',
      difficulty: 'Beginner',
      estimatedTimeMinutes: 10,
      questions: [
        Question(
          id: 'dart_q1',
          text: 'Which operator is used for Dart null-aware assignment?',
          options: ['??=', '?=', '?:', '!!='],
          correctAnswerIndex: 0,
        ),
        Question(
          id: 'dart_q2',
          text: 'Are Dart objects pass-by-reference or pass-by-value?',
          options: ['Pass by reference', 'Pass by value', 'Depends on type', 'None of above'],
          correctAnswerIndex: 0,
        ),
        Question(
          id: 'dart_q3',
          text: 'What keyword defines a compile-time immutable constant in Dart?',
          options: ['final', 'const', 'var', 'static'],
          correctAnswerIndex: 1,
        ),
        Question(
          id: 'dart_q4',
          text: 'Which return type represents an asynchronous single-value completion in Dart?',
          options: ['Stream', 'Future', 'Isolate', 'AsyncVal'],
          correctAnswerIndex: 1,
        ),
      ],
    ),
    Assessment(
      id: 'assess_web',
      title: 'Web & React Fundamentals',
      category: 'Web Development',
      difficulty: 'Intermediate',
      estimatedTimeMinutes: 12,
      questions: [
        Question(
          id: 'web_q1',
          text: 'Which React hook is used to execute side effects after render?',
          options: ['useState', 'useContext', 'useEffect', 'useReducer'],
          correctAnswerIndex: 2,
        ),
        Question(
          id: 'web_q2',
          text: 'What CSS property aligns items along the cross axis in Flexbox?',
          options: ['justify-content', 'align-items', 'flex-direction', 'align-content'],
          correctAnswerIndex: 1,
        ),
      ],
    ),
    Assessment(
      id: 'assess_dsa',
      title: 'Data Structures & Algorithms',
      category: 'Computer Science',
      difficulty: 'Advanced',
      estimatedTimeMinutes: 20,
      questions: [
        Question(
          id: 'dsa_q1',
          text: 'What is the average time complexity of searching in a balanced Binary Search Tree?',
          options: ['O(1)', 'O(n)', 'O(log n)', 'O(n log n)'],
          correctAnswerIndex: 2,
        ),
        Question(
          id: 'dsa_q2',
          text: 'Which data structure follows the LIFO (Last In First Out) principle?',
          options: ['Queue', 'Stack', 'Linked List', 'Tree'],
          correctAnswerIndex: 1,
        ),
      ],
    ),
    Assessment(
      id: 'assess_uiux',
      title: 'UI/UX Design Systems',
      category: 'Design',
      difficulty: 'Beginner',
      estimatedTimeMinutes: 10,
      questions: [
        Question(
          id: 'ui_q1',
          text: 'What is the standard base grid spacing used in Material Design?',
          options: ['4dp / 8dp grid', '5dp grid', '10dp grid', '12dp grid'],
          correctAnswerIndex: 0,
        ),
      ],
    ),
  ];

  // Mock Mentors
  static List<Mentor> mockMentors = [
    Mentor(
      id: 'mentor_1',
      name: 'Rahul Sharma',
      role: 'Senior Software Engineer',
      company: 'Google',
      avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80',
      experienceYears: 8,
      rating: 4.9,
      totalReviews: 142,
      pricePerSession: 999,
      expertise: ['Flutter', 'Backend Architecture', 'System Design', 'Interview Prep'],
      bio: 'Ex-Amazon and current Senior Engineer at Google. Mentored 300+ students and engineers into top tech companies.',
      languages: ['English', 'Hindi'],
      background: 'Passionate tech career coach with 8+ years experience in Android, iOS, and distributed cloud systems.',
      availableTimeSlots: ['10:00 AM', '11:30 AM', '02:00 PM', '04:30 PM', '06:00 PM'],
      reviews: [
        MentorReview(
          id: 'rev_1',
          userName: 'Priya Patel',
          userAvatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=100&q=80',
          rating: 5.0,
          comment: 'Rahul gave crisp, actionable resume feedback that landed me interviews at 3 product companies!',
          date: DateTime.now().subtract(const Duration(days: 7)),
        ),
        MentorReview(
          id: 'rev_2',
          userName: 'Karan Verma',
          userAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=100&q=80',
          rating: 4.8,
          comment: 'Super insightful mock interview session! Clarified deep Flutter state management concepts.',
          date: DateTime.now().subtract(const Duration(days: 14)),
        ),
      ],
    ),
    Mentor(
      id: 'mentor_2',
      name: 'Ananya Roy',
      role: 'Lead Staff Mobile Engineer',
      company: 'Microsoft',
      avatarUrl: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=200&q=80',
      experienceYears: 10,
      rating: 4.95,
      totalReviews: 210,
      pricePerSession: 1499,
      expertise: ['Flutter', 'Cross-Platform UI', 'Career Planning', 'Resume Review'],
      bio: 'Leading mobile frontend engineering teams at Microsoft. Speaker at international Flutter conferences.',
      languages: ['English', 'Bengali', 'Hindi'],
      background: 'Has authored popular open-source packages in Dart and published guides on cross-platform performance.',
      availableTimeSlots: ['09:00 AM', '01:00 PM', '03:30 PM', '05:00 PM'],
      reviews: [
        MentorReview(
          id: 'rev_3',
          userName: 'Vikram Singh',
          userAvatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=100&q=80',
          rating: 5.0,
          comment: 'Ananya is an extraordinary mentor. She helped me restructure my portfolio and gain immense confidence.',
          date: DateTime.now().subtract(const Duration(days: 3)),
        ),
      ],
    ),
    Mentor(
      id: 'mentor_3',
      name: 'Devendra Kulkarni',
      role: 'Staff Product Designer',
      company: 'Uber',
      avatarUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=200&q=80',
      experienceYears: 7,
      rating: 4.85,
      totalReviews: 89,
      pricePerSession: 899,
      expertise: ['UI/UX', 'Design Systems', 'Figma Prototyping', 'Portfolio Review'],
      bio: 'Design lead creating seamless global mobility interfaces. Specializes in helping developers master UI/UX.',
      languages: ['English', 'Marathi'],
      background: 'Spearheaded design system overhauls at Uber and Ola.',
      availableTimeSlots: ['11:00 AM', '02:30 PM', '07:00 PM'],
      reviews: [],
    ),
  ];

  // Initial Bookings
  static List<Booking> initialBookings = [
    Booking(
      id: 'bk_101',
      mentorId: 'mentor_1',
      mentorName: 'Rahul Sharma',
      mentorRole: 'Senior Software Engineer at Google',
      mentorAvatar: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80',
      date: DateTime.now().add(const Duration(days: 2)),
      timeSlot: '11:30 AM',
      sessionType: SessionType.interviewPrep,
      message: 'Looking forward to conducting a Flutter technical mock interview and discussing state management questions.',
      price: 999,
      status: BookingStatus.confirmed,
      createdAt: DateTime.now().subtract(const Duration(hours: 12)),
    ),
  ];
}
