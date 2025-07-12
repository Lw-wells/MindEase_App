import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CounselorScreen extends StatefulWidget {
  final void Function(String) onNavigate;

  const CounselorScreen({super.key, required this.onNavigate});

  @override
  State<CounselorScreen> createState() => _CounselorScreenState();
}

class _CounselorScreenState extends State<CounselorScreen> {
  String searchTerm = '';
  String selectedSpecialty = 'All';

  final List<String> specialties = [
    'All',
    'Anxiety & Depression',
    'Youth Therapy',
    'Trauma & PTSD',
    'Relationship Counseling',
  ];

  final List<Map<String, dynamic>> counselors = [
    {
      'id': 1,
      'name': 'Dr. Sarah Chen',
      'specialty': 'Anxiety & Depression',
      'rating': 4.9,
      'experience': '8 years',
      'image': null,
      'available': true,
    },
    {
      'id': 2,
      'name': 'Dr. Michael Rodriguez',
      'specialty': 'Youth Therapy',
      'rating': 4.8,
      'experience': '6 years',
      'image': null,
      'available': true,
    },
    {
      'id': 3,
      'name': 'Dr. Emily Johnson',
      'specialty': 'Trauma & PTSD',
      'rating': 4.9,
      'experience': '10 years',
      'image': null,
      'available': false,
    },
    {
      'id': 4,
      'name': 'Dr. David Kim',
      'specialty': 'Relationship Counseling',
      'rating': 4.7,
      'experience': '5 years',
      'image': null,
      'available': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredCounselors = counselors.where((c) {
      final matchesSearch =
          c['name'].toLowerCase().contains(searchTerm.toLowerCase()) ||
          c['specialty'].toLowerCase().contains(searchTerm.toLowerCase());
      final matchesSpecialty =
          selectedSpecialty == 'All' || c['specialty'] == selectedSpecialty;
      return matchesSearch && matchesSpecialty;
    }).toList();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF0F9FF), Color(0xFFF5F3FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => widget.onNavigate('home'),
                      icon: const Icon(LucideIcons.arrowLeft),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Professional Counselors',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  ],
                ),
              ),

              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  onChanged: (value) => setState(() => searchTerm = value),
                  decoration: InputDecoration(
                    hintText: 'Search counselors...',
                    prefixIcon: const Icon(LucideIcons.search, size: 20),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                      borderSide: const BorderSide(color: Color(0xFFBAE6FD)),
                    ),
                  ),
                ),
              ),

              // Specialty Chips
              Container(
                height: 48,
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: specialties.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (_, i) {
                    final selected = specialties[i] == selectedSpecialty;
                    return ChoiceChip(
                      label: Text(specialties[i]),
                      selected: selected,
                      onSelected: (_) =>
                          setState(() => selectedSpecialty = specialties[i]),
                      selectedColor: const Color(0xFF0EA5E9),
                      backgroundColor: const Color(0xFFE0F2FE),
                      labelStyle: TextStyle(
                        color: selected
                            ? Colors.white
                            : const Color(0xFF0369A1),
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),
              ),

              // Counselors List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filteredCounselors.length,
                  itemBuilder: (_, i) {
                    final counselor = filteredCounselors[i];
                    final available = counselor['available'];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 32,
                              backgroundImage: AssetImage(
                                'assets/images/placeholder.png',
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        counselor['name'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: available
                                              ? const Color(0xFFD1FAE5)
                                              : const Color(0xFFF1F5F9),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Text(
                                          available ? 'Available' : 'Busy',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: available
                                                ? const Color(0xFF047857)
                                                : const Color(0xFF475569),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    counselor['specialty'],
                                    style: const TextStyle(
                                      color: Color(0xFF0284C7),
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            size: 16,
                                            color: Colors.amber,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${counselor['rating']}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        '${counselor['experience']} experience',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF64748B),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          onPressed: available ? () {} : null,
                                          icon: const Icon(
                                            LucideIcons.messageCircle,
                                            size: 16,
                                          ),
                                          label: const Text("Message"),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(
                                              0xFF0EA5E9,
                                            ),
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      IconButton(
                                        icon: const Icon(LucideIcons.phone),
                                        onPressed: available ? () {} : null,
                                        color: const Color(0xFF0284C7),
                                      ),
                                      IconButton(
                                        icon: const Icon(LucideIcons.mail),
                                        onPressed: available ? () {} : null,
                                        color: const Color(0xFF0284C7),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
