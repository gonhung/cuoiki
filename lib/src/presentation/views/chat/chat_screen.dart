import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/chat_repository.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, String>> messages = [];
  final TextEditingController _controller = TextEditingController();
  final ChatRepository chatRepository = ChatRepository();
  void _sendMessage() async {
    // if (_controller.text.trim().isEmpty) return;
    // setState(() {
    //   messages.add({'sender': 'user', 'text': _controller.text});
    //   messages.add({'sender': 'bot', 'text': 'Hello! How can I help you?'});
    // });
    // _controller.clear();
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      messages.add({'sender': 'user', 'text': _controller.text});
    });

    String userMessage = _controller.text;
    _controller.clear();

    try {
      String botResponse = await chatRepository.sendMessage(msg: userMessage);
      setState(() {
        messages.add({'sender': 'bot', 'text': botResponse});
      });
    } catch (e) {
      setState(() {
        messages
            .add({'sender': 'bot', 'text': 'Error: Unable to get response'});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat Bot')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUser = message['sender'] == 'user';
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue[200] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(message['text']!,
                        style: const TextStyle(fontSize: 16)),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
