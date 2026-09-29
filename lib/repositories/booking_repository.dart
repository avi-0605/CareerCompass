import '../models/booking.dart';
import '../data/mock_data.dart';

class BookingRepository {
  final List<Booking> _bookings = List.from(MockData.initialBookings);

  Future<List<Booking>> getBookings() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return _bookings;
  }

  Future<void> addBooking(Booking newBooking) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _bookings.insert(0, newBooking);
  }
}
