// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourcesScreen extends StatefulWidget {
  final void Function(String) onNavigate;

  const ResourcesScreen({super.key, required this.onNavigate});

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  String searchTerm = "";
  String selectedCategory = "All";

  final List<Map<String, dynamic>> resources = [
    {
      'title': '5-Minute Breathing Exercise',
      'category': 'Stress',
      'type': 'audio',
      'duration': '6 min 34 secs',
      'icon': LucideIcons.headphones,
      'description': 'Quick breathing technique to reduce anxiety',
      'url': 'https://youtu.be/9fEo9my03Ks?si=YIM-YmW98cgZkU40',
    },
    {
      'title': 'Sleep Better Tonight',
      'category': 'Sleep',
      'type': 'video',
      'duration': '10 min 1 sec',
      'icon': LucideIcons.video,
      'description': 'Guided meditation for better sleep quality',
      'url': 'https://youtu.be/aEqlQvczMJQ?si=4PvosAWCGQ0bgNNd',
    },
    {
      'title': 'Understanding Depression',
      'category': 'Depression',
      'type': 'article',
      'duration': '8 min read',
      'icon': LucideIcons.bookOpen,
      'description': 'Learn about depression symptoms and coping strategies',
      'url': 'https://my.clevelandclinic.org/health/diseases/9290-depression',
    },
    {
      'title': 'Journaling for Mental Health',
      'category': 'Self-Care',
      'type': 'guide',
      'duration': '10 min read',
      'icon': LucideIcons.bookOpen,
      'description': 'How to start and maintain a mental health journal',
      'url':
          'https://www.helpguide.org/mental-health/wellbeing/journaling-for-mental-health-and-wellness',
    },
    {
      'title': 'Progressive Muscle Relaxation',
      'category': 'Stress',
      'type': 'audio',
      'duration': '9 min 5 secs',
      'icon': LucideIcons.headphones,
      'description': 'Full body relaxation technique',
      'url': 'https://youtu.be/SNqYG95j_UQ?si=wWitaykih6SYxKdz',
    },
    {
      'title': 'Coping with Anxiety',
      'category': 'Anxiety',
      'type': 'video',
      'duration': '7 min 18 secs',
      'icon': LucideIcons.video,
      'description': 'Practical strategies for managing anxiety',
      'url': 'https://youtu.be/FpiWSFcL3-c?si=qXjnZ_W_v9BOURnI',
    },
  ];

  final List<String> categories = [
    "All",
    "Stress",
    "Sleep",
    "Depression",
    "Anxiety",
    "Self-Care",
  ];

  @override
  Widget build(BuildContext context) {
    final filteredResources = resources.where((resource) {
      final matchSearch =
          resource['title'].toLowerCase().contains(searchTerm.toLowerCase()) ||
          resource['description'].toLowerCase().contains(
            searchTerm.toLowerCase(),
          );
      final matchCategory =
          selectedCategory == 'All' || resource['category'] == selectedCategory;
      return matchSearch && matchCategory;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF0F9FF),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                border: const Border(
                  bottom: BorderSide(color: Color(0xFFBAE6FD)),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => widget.onNavigate('home'),
                    icon: const Icon(LucideIcons.arrowLeft),
                  ),
                  const Text(
                    'Mental Health Resources',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
            ),

            // Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Search Bar
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(LucideIcons.search),
                        hintText: 'Search resources...',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color(0xFFBAE6FD),
                          ),
                        ),
                      ),
                      onChanged: (value) => setState(() => searchTerm = value),
                    ),
                    const SizedBox(height: 12),

                    // Categories
                    SizedBox(
                      height: 36,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          final selected = selectedCategory == category;
                          return ChoiceChip(
                            label: Text(category),
                            selected: selected,
                            onSelected: (_) =>
                                setState(() => selectedCategory = category),
                            selectedColor: const Color(0xFF0EA5E9),
                            backgroundColor: const Color(0xFFE0F2FE),
                            labelStyle: TextStyle(
                              color: selected
                                  ? Colors.white
                                  : const Color(0xFF0369A1),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Featured Card
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF34D399), Color(0xFF10B981)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Icon(
                            LucideIcons.heart,
                            size: 40,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Daily Wellness Check-in",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            "Track your mood and build healthy habits",
                            style: TextStyle(color: Color(0xFFD1FAE5)),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () => widget.onNavigate('mood-journal'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF10B981),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text("Start Check-in"),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Resource List
                    ...filteredResources.map((resource) {
                      return Card(
                        color: Colors.white.withOpacity(0.9),
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFFBAE6FD),
                            child: Icon(
                              resource['icon'],
                              color: const Color(0xFF0EA5E9),
                            ),
                          ),
                          title: Text(
                            resource['title'],
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE0F2FE),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      resource['category'],
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF0369A1),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    resource['duration'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF64748B),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                resource['description'],
                                style: const TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              LucideIcons.play,
                              color: Color(0xFF0EA5E9),
                            ),
                            onPressed: () async {
                              final url = resource['url'];
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Could not open resource'),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
