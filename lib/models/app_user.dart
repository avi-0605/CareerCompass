class AppUser {
  final String uid;
  final String name;
  final String email;
  final String? photoUrl;
  final String provider; // 'email' or 'google'

  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    this.photoUrl,
    this.provider = 'email',
  });
}
