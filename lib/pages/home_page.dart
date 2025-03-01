import 'package:flutter/material.dart';
import '../models/message_model.dart';
import '../models/api_response_model.dart';
import '../services/chat_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textController = TextEditingController();
  final List<Message> _messages = [];
  final ChatService _chatService = ChatService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MURPHYs AI"),
        centerTitle: true,
        elevation: 2,
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 100,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Start a conversation!',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(16),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                return _buildMessage(message);
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: LinearProgressIndicator(),
            ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessage(Message message) {
    final isUser = message.role == 'user';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment:
        isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser)
            CircleAvatar(
              backgroundColor: Colors.blue,
              child: const Icon(
                Icons.smart_toy,
                color: Colors.white,
              ),
            ),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: isUser ? Colors.blue[100] : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: Text(
                message.content,
                style: TextStyle(
                  fontSize: 16,
                  color: isUser ? Colors.black87 : Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          if (isUser)
            CircleAvatar(
              backgroundColor: Colors.blue[700],
              child: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Type a message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              textCapitalization: TextCapitalization.sentences,
              maxLines: null,
              onSubmitted: _isLoading ? null : _sendMessage,
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            onPressed: _isLoading ? null : () => _sendMessage(_textController.text),
            backgroundColor: Colors.blue,
            elevation: 0,
            child: const Icon(Icons.send, color: Colors.white),
          ),
        ],
      ),
    );
  }

  void _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(Message(
        content: text,
        role: 'user',
      ));
      _textController.clear();
      _isLoading = true;
    });

    try {
      final response = await _chatService.sendMessage([..._messages]);
      setState(() {
        // Convert the API response Message to our Message type
        final apiMessage = response.choices[0].message;
        final message = Message(
          content: apiMessage.content,
          role: apiMessage.role,
        );
        _messages.add(message);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _messages.add(Message(
          content: 'Error: Failed to get response. Please try again.',
          role: 'assistant',
        ));
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}