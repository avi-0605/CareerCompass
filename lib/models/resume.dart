enum SkillLevel {
  beginner('Beginner'),
  intermediate('Intermediate'),
  advanced('Advanced'),
  expert('Expert');

  final String label;
  const SkillLevel(this.label);
}

class Skill {
  String name;
  SkillLevel level;

  Skill({
    required this.name,
    this.level = SkillLevel.intermediate,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'level': level.name,
      };

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
        name: json['name'],
        level: SkillLevel.values.firstWhere(
          (e) => e.name == json['level'],
          orElse: () => SkillLevel.intermediate,
        ),
      );
}

class Education {
  String id;
  String institution;
  String degree;
  String fieldOfStudy;
  String startYear;
  String endYear;
  String grade;

  Education({
    required this.id,
    required this.institution,
    required this.degree,
    required this.fieldOfStudy,
    required this.startYear,
    required this.endYear,
    required this.grade,
  });
}

class Experience {
  String id;
  String jobTitle;
  String company;
  String location;
  String startDate;
  String endDate;
  String description;

  Experience({
    required this.id,
    required this.jobTitle,
    required this.company,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.description,
  });
}

class Project {
  String id;
  String name;
  String description;
  String technologies;
  String projectLink;

  Project({
    required this.id,
    required this.name,
    required this.description,
    required this.technologies,
    required this.projectLink,
  });
}

class Certification {
  String id;
  String name;
  String issuingOrganization;
  String date;
  String credentialUrl;

  Certification({
    required this.id,
    required this.name,
    required this.issuingOrganization,
    required this.date,
    required this.credentialUrl,
  });
}

class Resume {
  String id;
  String name;
  String email;
  String phone;
  String location;
  String linkedIn;
  String gitHub;
  String portfolio;
  String summary;
  List<Education> education;
  List<Experience> experience;
  List<Skill> skills;
  List<Project> projects;
  List<Certification> certifications;

  Resume({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.location,
    required this.linkedIn,
    required this.gitHub,
    required this.portfolio,
    required this.summary,
    required this.education,
    required this.experience,
    required this.skills,
    required this.projects,
    required this.certifications,
  });

  int calculateCompletionPercentage() {
    int score = 0;
    int maxScore = 7; // 7 sections

    if (name.isNotEmpty && email.isNotEmpty && phone.isNotEmpty) score++;
    if (summary.trim().isNotEmpty) score++;
    if (education.isNotEmpty) score++;
    if (experience.isNotEmpty) score++;
    if (skills.isNotEmpty) score++;
    if (projects.isNotEmpty) score++;
    if (certifications.isNotEmpty) score++;

    return ((score / maxScore) * 100).round();
  }
}
