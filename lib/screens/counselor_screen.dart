import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

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
      'name': 'Dr. Esther Mwanzia',
      'specialty': 'Anxiety & Depression',
      'rating': 4.9,
      'experience': '8 years',
      'image': 'assets/images/dr_sarah.jpg',
      'available': true,
      'email': 'mwanzia.es@NairobiHospital.org',
      'phone': '+254757038269',
      'whatsapp': '+254757038269',
    },
    {
      'id': 2,
      'name': 'Dr. Michael Oginga',
      'specialty': 'Youth Therapy',
      'rating': 4.8,
      'experience': '6 years',
      'image': 'assets/images/dr_michael.jpg',
      'available': true,
      'email': 'michael.Og@muthaigaHospital.org',
      'phone': '+254757038269',
      'whatsapp': '+254757038269',
    },
    {
      'id': 3,
      'name': 'Dr. Emily Kerubo',
      'specialty': 'Trauma & PTSD',
      'rating': 4.9,
      'experience': '10 years',
      'image': 'assets/images/dr_emily.jpg',
      'available': false,
      'email': 'emily.ke@equityafya.org',
      'phone': '+254757038269',
      'whatsapp': '+254757038269',
    },
    {
      'id': 4,
      'name': 'Dr. Stanley Wells',
      'specialty': 'Relationship Counseling',
      'rating': 4.7,
      'experience': '5 years',
      'image': 'assets/images/dr_david.jpg',
      'available': true,
      'email': 'wells.stan@ruaifamilyConsultants',
      'phone': '+254757038269',
      'whatsapp': '+254757038269',
    },
  ];

  Future<void> _sendEmail(String email) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      query: Uri.encodeFull(
        'subject=Consultation Request&body=Hi, I would like to consult with you.',
      ),
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open email client.')),
      );
    }
  }

  void _showPhoneDialog(String name, String phone) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Contact $name'),
        content: Text('Phone: $phone'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _openWhatsApp(String phoneNumber, String message) async {
    final url = Uri.parse(
      'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Could not open WhatsApp.')));
    }
  }

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
                              backgroundImage: AssetImage(counselor['image']),
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
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          onPressed: available
                                              ? () => _sendEmail(
                                                  counselor['email'],
                                                )
                                              : null,
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
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          onPressed: available
                                              ? () => _showPhoneDialog(
                                                  counselor['name'],
                                                  counselor['phone'],
                                                )
                                              : null,
                                          icon: const Icon(
                                            LucideIcons.phone,
                                            size: 16,
                                          ),
                                          label: const Text("Call"),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(
                                              0xFF10B981,
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
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          onPressed: available
                                              ? () => _openWhatsApp(
                                                  counselor['whatsapp'],
                                                  'Hello ${counselor['name']}, I would like to consult with you.',
                                                )
                                              : null,
                                          icon: const Icon(
                                            LucideIcons.messageSquare,
                                            size: 16,
                                          ),
                                          label: const Text("WhatsApp"),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(
                                              0xFF22C55E,
                                            ),
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                        ),
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
