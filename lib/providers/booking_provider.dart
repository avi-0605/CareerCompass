import 'package:flutter/material.dart';
import '../models/booking.dart';
import '../models/mentor.dart';
import '../repositories/booking_repository.dart';

class BookingProvider extends ChangeNotifier {
  final BookingRepository _repository;

  List<Booking> _bookings = [];
  bool _isLoading = false;
  String? _error;

  BookingProvider(this._repository) {
    loadBookings();
  }

  List<Booking> get bookings => _bookings;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Booking? get upcomingSession {
    if (_bookings.isEmpty) return null;
    try {
      return _bookings.firstWhere((b) => b.status == BookingStatus.confirmed);
    } catch (_) {
      return null;
    }
  }

  Future<void> loadBookings() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _bookings = await _repository.getBookings();
    } catch (e) {
      _error = 'Failed to load bookings.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Booking> createBooking({
    required Mentor mentor,
    required DateTime date,
    required String timeSlot,
    required SessionType sessionType,
    required String message,
  }) async {
    final newBooking = Booking(
      id: 'bk_${DateTime.now().millisecondsSinceEpoch}',
      mentorId: mentor.id,
      mentorName: mentor.name,
      mentorRole: '${mentor.role} at ${mentor.company}',
      mentorAvatar: mentor.avatarUrl,
      date: date,
      timeSlot: timeSlot,
      sessionType: sessionType,
      message: message,
      price: mentor.pricePerSession,
      status: BookingStatus.confirmed,
      createdAt: DateTime.now(),
    );

    await _repository.addBooking(newBooking);
    _bookings.insert(0, newBooking);
    notifyListeners();
    return newBooking;
  }
}
