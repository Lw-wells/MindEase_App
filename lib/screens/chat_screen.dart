import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter/services.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> messages = [
    {
      "role": "assistant",
      "content":
          "Hi, I'm Maya — your mental wellness companion. I'm here to listen and support you. How are you feeling today?",
    },
  ];

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  List<String> quickPrompts = [
    "I feel anxious",
    "I need motivation",
    "I had a bad day",
    "I'm feeling overwhelmed",
  ];

  void sendMessage(String message) {
    if (message.trim().isEmpty) return;
    setState(() {
      messages.add({"role": "user", "content": message});
      isLoading = true;
      _controller.clear();
    });
    HapticFeedback.lightImpact();

    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });

    // Simulated AI reply
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        messages.add({
          "role": "assistant",
          "content": "I'm here for you. Let's take a deep breath together 🤝",
        });
        isLoading = false;
      });
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  Widget buildMessageBubble(String content, bool isUser) => Align(
    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      constraints: const BoxConstraints(maxWidth: 300),
      decoration: BoxDecoration(
        color: isUser ? const Color(0xFF0EA5E9) : Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        content,
        style: TextStyle(color: isUser ? Colors.white : Colors.black87),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F9FF), // sky-50
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Maya", style: TextStyle(color: Color(0xFF1E293B))),
            Text(
              "AI Wellness Companion",
              style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/counselor');
            },
            icon: const Icon(
              LucideIcons.users,
              size: 16,
              color: Color(0xFF0EA5E9),
            ),
            label: const Text(
              "Real Counselor",
              style: TextStyle(color: Color(0xFF0EA5E9)),
            ),
          ),
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: messages.length + (isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= messages.length) {
                  return Row(
                    children: const [
                      SizedBox(
                        width: 32,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      SizedBox(width: 12),
                      Text("Maya is typing..."),
                    ],
                  );
                }

                final msg = messages[index];
                final isUser = msg["role"] == "user";
                return buildMessageBubble(msg["content"], isUser);
              },
            ),
          ),
          if (messages.length <= 1)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: quickPrompts.map((prompt) {
                  return OutlinedButton(
                    onPressed: () => sendMessage(prompt),
                    child: Text(prompt),
                  );
                }).toList(),
              ),
            ),
          const Divider(height: 1),
          Container(
            color: Colors.white.withOpacity(0.8),
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(LucideIcons.send),
                  onPressed: () => sendMessage(_controller.text),
                  color: const Color(0xFF0EA5E9),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
