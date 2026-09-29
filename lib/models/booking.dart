enum SessionType {
  careerGuidance('Career Guidance'),
  resumeReview('Resume Review'),
  interviewPrep('Interview Preparation'),
  technicalMentoring('Technical Mentoring'),
  careerPlanning('Career Planning');

  final String title;
  const SessionType(this.title);
}

enum BookingStatus {
  confirmed('Confirmed'),
  pending('Pending'),
  completed('Completed'),
  cancelled('Cancelled');

  final String label;
  const BookingStatus(this.label);
}

class Booking {
  final String id;
  final String mentorId;
  final String mentorName;
  final String mentorRole;
  final String mentorAvatar;
  final DateTime date;
  final String timeSlot;
  final SessionType sessionType;
  final String message;
  final int price;
  final BookingStatus status;
  final DateTime createdAt;

  Booking({
    required this.id,
    required this.mentorId,
    required this.mentorName,
    required this.mentorRole,
    required this.mentorAvatar,
    required this.date,
    required this.timeSlot,
    required this.sessionType,
    required this.message,
    required this.price,
    this.status = BookingStatus.confirmed,
    required this.createdAt,
  });
}
