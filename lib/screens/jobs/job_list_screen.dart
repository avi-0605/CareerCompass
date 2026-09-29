import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/job_provider.dart';
import '../../widgets/cards/job_card.dart';
import '../../widgets/common/custom_search_bar.dart';
import '../../widgets/common/empty_state.dart';
import '../../app/routes.dart';

class JobListScreen extends StatefulWidget {
  const JobListScreen({super.key});

  @override
  State<JobListScreen> createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showFilterBottomSheet(BuildContext context) {
    final jobProvider = Provider.of<JobProvider>(context, listen: false);
    String tempWorkType = jobProvider.selectedWorkType;
    String tempJobType = jobProvider.selectedJobType;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Filter Opportunities',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('Work Mode', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: ['All', 'Remote', 'Hybrid', 'On-site'].map((mode) {
                      final selected = tempWorkType == mode;
                      return ChoiceChip(
                        label: Text(mode),
                        selected: selected,
                        onSelected: (val) {
                          if (val) setModalState(() => tempWorkType = mode);
                        },
                        selectedColor: const Color(0xFFEFF6FF),
                        labelStyle: TextStyle(
                          color: selected ? const Color(0xFF2563EB) : const Color(0xFF475569),
                          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  const Text('Job Type', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: ['All', 'Full-time', 'Part-time', 'Internship', 'Contract'].map((type) {
                      final selected = tempJobType == type;
                      return ChoiceChip(
                        label: Text(type),
                        selected: selected,
                        onSelected: (val) {
                          if (val) setModalState(() => tempJobType = type);
                        },
                        selectedColor: const Color(0xFFEFF6FF),
                        labelStyle: TextStyle(
                          color: selected ? const Color(0xFF2563EB) : const Color(0xFF475569),
                          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            jobProvider.clearFilters();
                            _searchController.clear();
                            Navigator.pop(ctx);
                          },
                          child: const Text('Reset All'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            jobProvider.setWorkTypeFilter(tempWorkType);
                            jobProvider.setJobTypeFilter(tempJobType);
                            Navigator.pop(ctx);
                          },
                          child: const Text('Apply Filters'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<JobProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Your Next Opportunity'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search & Filter header
          Container(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            color: Colors.white,
            child: Column(
              children: [
                CustomSearchBar(
                  controller: _searchController,
                  hintText: 'Search jobs, companies or skills',
                  onChanged: (q) => jobProvider.setSearchQuery(q),
                  onFilterTap: () => _showFilterBottomSheet(context),
                ),
                const SizedBox(height: 12),
                // Active filter chips bar
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      if (jobProvider.selectedWorkType != 'All')
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Chip(
                            label: Text('Mode: ${jobProvider.selectedWorkType}'),
                            onDeleted: () => jobProvider.setWorkTypeFilter('All'),
                            deleteIcon: const Icon(Icons.close, size: 14),
                          ),
                        ),
                      if (jobProvider.selectedJobType != 'All')
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Chip(
                            label: Text('Type: ${jobProvider.selectedJobType}'),
                            onDeleted: () => jobProvider.setJobTypeFilter('All'),
                            deleteIcon: const Icon(Icons.close, size: 14),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Main list with Loading, Empty, and Success states
          Expanded(
            child: jobProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : jobProvider.jobs.isEmpty
                    ? EmptyState(
                        title: 'No jobs found',
                        subtitle: 'Try adjusting your search keywords or active filters.',
                        onRetry: () {
                          _searchController.clear();
                          jobProvider.clearFilters();
                        },
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(20),
                        itemCount: jobProvider.jobs.length,
                        itemBuilder: (context, index) {
                          final job = jobProvider.jobs[index];
                          return JobCard(
                            job: job,
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.jobDetail, arguments: job);
                            },
                            onBookmarkToggle: () {
                              jobProvider.toggleBookmark(job.id);
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
