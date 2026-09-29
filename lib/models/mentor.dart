class MentorReview {
  final String id;
  final String userName;
  final String userAvatar;
  final double rating;
  final String comment;
  final DateTime date;

  MentorReview({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.rating,
    required this.comment,
    required this.date,
  });
}

class Mentor {
  final String id;
  final String name;
  final String role;
  final String company;
  final String avatarUrl;
  final int experienceYears;
  final double rating;
  final int totalReviews;
  final int pricePerSession;
  final List<String> expertise;
  final String bio;
  final List<String> languages;
  final String background;
  final List<String> availableTimeSlots;
  final List<MentorReview> reviews;

  Mentor({
    required this.id,
    required this.name,
    required this.role,
    required this.company,
    required this.avatarUrl,
    required this.experienceYears,
    required this.rating,
    required this.totalReviews,
    required this.pricePerSession,
    required this.expertise,
    required this.bio,
    required this.languages,
    required this.background,
    required this.availableTimeSlots,
    required this.reviews,
  });
}
