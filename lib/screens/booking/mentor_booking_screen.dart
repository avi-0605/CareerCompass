import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../models/mentor.dart';
import '../../models/booking.dart';
import '../../providers/booking_provider.dart';
import '../../app/routes.dart';

class MentorBookingScreen extends StatefulWidget {
  final Mentor mentor;

  const MentorBookingScreen({super.key, required this.mentor});

  @override
  State<MentorBookingScreen> createState() => _MentorBookingScreenState();
}

class _MentorBookingScreenState extends State<MentorBookingScreen> {
  DateTime? _selectedDate;
  String? _selectedTimeSlot;
  SessionType? _selectedSessionType = SessionType.careerGuidance;
  final TextEditingController _messageController = TextEditingController();
  String? _validationError;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now.add(const Duration(days: 1)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 60)),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _validationError = null;
      });
    }
  }

  void _validateAndConfirmBooking() async {
    setState(() => _validationError = null);

    if (_selectedDate == null) {
      setState(() => _validationError = 'Please select a date for your session.');
      return;
    }
    if (_selectedTimeSlot == null) {
      setState(() => _validationError = 'Please select an available time slot.');
      return;
    }
    if (_selectedSessionType == null) {
      setState(() => _validationError = 'Please select a session type.');
      return;
    }
    if (_messageController.text.trim().isEmpty) {
      setState(() => _validationError = 'Please state what topic you would like to discuss.');
      return;
    }

    // Process booking
    final bookingProvider = Provider.of<BookingProvider>(context, listen: false);
    final booking = await bookingProvider.createBooking(
      mentor: widget.mentor,
      date: _selectedDate!,
      timeSlot: _selectedTimeSlot!,
      sessionType: _selectedSessionType!,
      message: _messageController.text.trim(),
    );

    if (!mounted) return;

    // Show Confirmation Dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xFFECFDF5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Color(0xFF10B981),
                  size: 48,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Booking Confirmed!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              const Text(
                'Your mentoring session has been scheduled.',
                style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Booking Details Box
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    _buildSummaryRow('Mentor:', booking.mentorName),
                    const SizedBox(height: 6),
                    _buildSummaryRow('Date:', DateFormat('EEE, MMM d, yyyy').format(booking.date)),
                    const SizedBox(height: 6),
                    _buildSummaryRow('Time:', booking.timeSlot),
                    const SizedBox(height: 6),
                    _buildSummaryRow('Type:', booking.sessionType.title),
                    const SizedBox(height: 6),
                    _buildSummaryRow('Fee:', '₹${booking.price}'),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(ctx); // Close dialog
                        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.mainNav, (r) => false, arguments: 0);
                      },
                      child: const Text('Dashboard'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx); // Close dialog
                        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.mainNav, (r) => false, arguments: 0);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2563EB)),
                      child: const Text('View Session'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Mentoring Session'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mentor Header snippet
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundImage: NetworkImage(widget.mentor.avatarUrl),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.mentor.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text('${widget.mentor.role} at ${widget.mentor.company}', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                        ],
                      ),
                    ),
                    Text(
                      '₹${widget.mentor.pricePerSession}',
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2563EB), fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Validation alert banner if present
            if (_validationError != null)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF2F2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFFCA5A5)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: Color(0xFFEF4444)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _validationError!,
                        style: const TextStyle(color: Color(0xFF991B1B), fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),

            // Step 1: Select Date
            const Text('Step 1 — Select Date', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 8),
            InkWell(
              onTap: _presentDatePicker,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_month, color: Color(0xFF2563EB)),
                        const SizedBox(width: 12),
                        Text(
                          _selectedDate == null
                              ? 'Tap to select session date'
                              : DateFormat('EEEE, MMMM d, yyyy').format(_selectedDate!),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: _selectedDate != null ? FontWeight.bold : FontWeight.normal,
                            color: _selectedDate != null ? const Color(0xFF0F172A) : const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF94A3B8)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Step 2: Select Time
            const Text('Step 2 — Select Time Slot', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: widget.mentor.availableTimeSlots.map((slot) {
                final selected = _selectedTimeSlot == slot;
                return ChoiceChip(
                  label: Text(slot),
                  selected: selected,
                  onSelected: (val) {
                    setState(() {
                      _selectedTimeSlot = val ? slot : null;
                      _validationError = null;
                    });
                  },
                  selectedColor: const Color(0xFFEFF6FF),
                  labelStyle: TextStyle(
                    color: selected ? const Color(0xFF2563EB) : const Color(0xFF334155),
                    fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Step 3: Session Type
            const Text('Step 3 — Session Type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 8),
            DropdownButtonFormField<SessionType>(
              initialValue: _selectedSessionType,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
              items: SessionType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.title),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _selectedSessionType = val;
                    _validationError = null;
                  });
                }
              },
            ),
            const SizedBox(height: 24),

            // Step 4: Discussion Topic Message
            const Text('Step 4 — Message / Topic', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 8),
            TextField(
              controller: _messageController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'What specific topics, projects, or questions would you like to discuss during this session?',
              ),
              onChanged: (_) => setState(() => _validationError = null),
            ),
            const SizedBox(height: 28),

            // Booking Summary Card
            Card(
              color: const Color(0xFFF8FAFC),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Booking Summary', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 10),
                    _buildSummaryRow('Mentor:', widget.mentor.name),
                    const SizedBox(height: 4),
                    _buildSummaryRow('Date:', _selectedDate != null ? DateFormat('MMM d, yyyy').format(_selectedDate!) : 'Not selected'),
                    const SizedBox(height: 4),
                    _buildSummaryRow('Time:', _selectedTimeSlot ?? 'Not selected'),
                    const SizedBox(height: 4),
                    _buildSummaryRow('Session Type:', _selectedSessionType?.title ?? ''),
                    const SizedBox(height: 4),
                    _buildSummaryRow('Total Fee:', '₹${widget.mentor.pricePerSession}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _validateAndConfirmBooking,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E293B)),
                child: const Text('Confirm Booking'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12.5)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5, color: Color(0xFF0F172A))),
      ],
    );
  }
}
