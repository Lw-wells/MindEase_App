import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MoodJournalScreen extends StatefulWidget {
  final void Function(String) onNavigate;

  const MoodJournalScreen({Key? key, required this.onNavigate})
    : super(key: key);

  @override
  State<MoodJournalScreen> createState() => _MoodJournalScreenState();
}

class _MoodJournalScreenState extends State<MoodJournalScreen> {
  int? selectedMood;
  final TextEditingController journalController = TextEditingController();

  final List<Map<String, dynamic>> moods = [
    {"emoji": "😞", "label": "Very Sad", "value": 1, "color": Colors.red},
    {"emoji": "😐", "label": "Okay", "value": 2, "color": Colors.orange},
    {"emoji": "🙂", "label": "Good", "value": 3, "color": Colors.amber},
    {"emoji": "😄", "label": "Happy", "value": 4, "color": Colors.green},
    {"emoji": "😊", "label": "Excellent", "value": 5, "color": Colors.blue},
  ];

  final List<Map<String, dynamic>> recentEntries = [
    {
      "date": "Today",
      "mood": 4,
      "note": "Had a productive day at work and felt accomplished.",
    },
    {
      "date": "Yesterday",
      "mood": 3,
      "note": "Feeling okay, had some ups and downs.",
    },
    {
      "date": "2 days ago",
      "mood": 2,
      "note": "Struggled with anxiety but managed to get through.",
    },
  ];

  void handleSave() {
    if (selectedMood != null && journalController.text.trim().isNotEmpty) {
      // Save logic here...
      widget.onNavigate("home");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF6FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(LucideIcons.arrowLeft),
                        onPressed: () => widget.onNavigate("home"),
                      ),
                      const Text(
                        "Mood Journal",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed:
                        (selectedMood != null &&
                            journalController.text.trim().isNotEmpty)
                        ? handleSave
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0EA5E9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    child: const Text("Save"),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Mood Check-In
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(LucideIcons.calendar, size: 20),
                          SizedBox(width: 8),
                          Text(
                            "Today's Check-in",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "How are you feeling today?",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: moods.map((mood) {
                          final isSelected = selectedMood == mood["value"];
                          return GestureDetector(
                            onTap: () =>
                                setState(() => selectedMood = mood["value"]),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: isSelected
                                    ? const Color(0xFFDBEAFE)
                                    : Colors.transparent,
                                border: isSelected
                                    ? Border.all(
                                        color: const Color(0xFF60A5FA),
                                        width: 2,
                                      )
                                    : Border.all(color: Colors.transparent),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    mood["emoji"],
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    mood["label"],
                                    style: TextStyle(
                                      color: mood["color"],
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "What's on your mind? (Optional)",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: journalController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText:
                              "Share your thoughts, feelings, or what happened today...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Color(0xFFBAE6FD),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Color(0xFF60A5FA),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Mood Trends
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Icon(LucideIcons.trendingUp, size: 20),
                          SizedBox(width: 8),
                          Text(
                            "Your Mood Trends",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0F2FE),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Mood chart visualization would go here",
                          style: TextStyle(color: Color(0xFF64748B)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Column(
                            children: [
                              Text(
                                "7",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0284C7),
                                ),
                              ),
                              Text(
                                "Days tracked",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "3.4",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF10B981),
                                ),
                              ),
                              Text(
                                "Avg mood",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "↗",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple,
                                ),
                              ),
                              Text(
                                "Trending up",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Recent Entries
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Recent Entries",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      ...recentEntries.map((entry) {
                        final mood = moods.firstWhere(
                          (m) => m["value"] == entry["mood"],
                        );
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0F2FE),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Text(
                                mood["emoji"],
                                style: const TextStyle(fontSize: 24),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          entry["date"],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          mood["label"],
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Color(0xFF94A3B8),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      entry["note"],
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF475569),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
