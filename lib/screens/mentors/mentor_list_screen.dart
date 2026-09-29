import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/mentor_provider.dart';
import '../../widgets/cards/mentor_card.dart';
import '../../widgets/common/custom_search_bar.dart';
import '../../widgets/common/empty_state.dart';
import '../../app/routes.dart';

class MentorListScreen extends StatefulWidget {
  const MentorListScreen({super.key});

  @override
  State<MentorListScreen> createState() => _MentorListScreenState();
}

class _MentorListScreenState extends State<MentorListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mentorProvider = Provider.of<MentorProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Find a Career Mentor'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            color: Colors.white,
            child: Column(
              children: [
                CustomSearchBar(
                  controller: _searchController,
                  hintText: 'Search mentors by skill or role',
                  onChanged: (q) => mentorProvider.setSearchQuery(q),
                ),
                const SizedBox(height: 12),
                // Expertise filter chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: ['All', 'Flutter', 'UI/UX', 'System Design', 'Backend Architecture'].map((exp) {
                      final selected = mentorProvider.selectedExpertise == exp;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(exp),
                          selected: selected,
                          onSelected: (_) => mentorProvider.setExpertiseFilter(exp),
                          selectedColor: const Color(0xFFEFF6FF),
                          labelStyle: TextStyle(
                            color: selected ? const Color(0xFF2563EB) : const Color(0xFF475569),
                            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: mentorProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : mentorProvider.mentors.isEmpty
                    ? EmptyState(
                        title: 'No mentors found',
                        subtitle: 'Try adjusting your search query or skill filter.',
                        onRetry: () {
                          _searchController.clear();
                          mentorProvider.setSearchQuery('');
                          mentorProvider.setExpertiseFilter('All');
                        },
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(20),
                        itemCount: mentorProvider.mentors.length,
                        itemBuilder: (context, index) {
                          final mentor = mentorProvider.mentors[index];
                          return MentorCard(
                            mentor: mentor,
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.mentorProfile, arguments: mentor);
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
