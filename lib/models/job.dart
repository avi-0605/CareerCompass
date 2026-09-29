class Job {
  final String id;
  final String title;
  final String company;
  final String companyLogoUrl;
  final String location;
  final String workType; // Remote, Hybrid, On-site
  final String jobType;  // Full-time, Part-time, Internship, Contract
  final String salary;
  final String experience;
  final String description;
  final List<String> responsibilities;
  final List<String> requirements;
  final List<String> skills;
  final List<String> benefits;
  final DateTime postedDate;
  bool isBookmarked;

  Job({
    required this.id,
    required this.title,
    required this.company,
    required this.companyLogoUrl,
    required this.location,
    required this.workType,
    required this.jobType,
    required this.salary,
    required this.experience,
    required this.description,
    required this.responsibilities,
    required this.requirements,
    required this.skills,
    required this.benefits,
    required this.postedDate,
    this.isBookmarked = false,
  });
}
