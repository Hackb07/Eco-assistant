import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../widgets/glass_card.dart';
import '../services/waste_engine.dart';
import 'result_detail_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {'text': 'Hello! I can help you with waste identification and recycling. Ask me anything, or type a waste material name.', 'isUser': false},
  ];

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'text': text, 'isUser': true});
    });
    _controller.clear();

    // Process with engine
    final response = WasteEngine.processInput(textInput: text);
    
    Future.delayed(const Duration(milliseconds: 500), () {
      if (response.category != null) {
        setState(() {
          _messages.add({
            'text': 'I found information about ${response.category!.name}. Would you like to see the details?',
            'isUser': false,
            'response': response
          });
        });
      } else {
        setState(() {
          _messages.add({
            'text': 'I am not sure about "$text". Try asking about Plastic, E-waste, or Paper.',
            'isUser': false,
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Assistant')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildMessageBubble(msg);
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> msg) {
    final isUser = msg['isUser'] as bool;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        child: GlassCard(
          padding: const EdgeInsets.all(16),
          borderRadius: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                msg['text'],
                style: TextStyle(color: isUser ? AppColors.accent : Colors.white),
              ),
              if (msg['response'] != null) ...[
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ResultDetailScreen(response: msg['response'] as WasteResponse),
                    ),
                  ),
                  child: const Text('View Details'),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Ask about waste...',
                border: InputBorder.none,
                hintStyle: TextStyle(color: AppColors.textSecondary),
              ),
              onSubmitted: (_) => _handleSend(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: AppColors.accent),
            onPressed: _handleSend,
          ),
        ],
      ),
    );
  }
}
