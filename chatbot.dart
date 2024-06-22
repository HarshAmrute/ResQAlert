import 'package:flutter/material.dart';

class ChatbotPage extends StatefulWidget {
  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  // Define chatbot responses based on intents
  final Map<String, String> _intents = {
    "greeting": "Hi there! How can I assist you today?",
    "thank_you": "You're welcome! If you need further assistance, feel free to ask.",
    "default": "I'm sorry, I didn't understand that. Can you please rephrase?"
  };

  // Define keywords for each intent
  final Map<String, List<String>> _keywords = {
    "greeting": ["hi", "hello", "hey"],
    "thank_you": ["thank you", "thanks"],
  };

  // Function to classify user query into an intent
  String _classifyIntent(String query) {
    for (var intent in _keywords.keys) {
      for (var keyword in _keywords[intent]!) {
        if (query.toLowerCase().contains(keyword)) {
          return intent;
        }
      }
    }
    return "default"; // Default intent if no match found
  }

  void _handleSubmitted(String text) {
    if (text.isNotEmpty) {
      _controller.clear();
      setState(() {
        _messages.insert(0, {"sender": "user", "text": text});
      });
      String response = _getChatbotResponse(text);
      _displayChatbotResponse(response);
    }
  }

  String _getChatbotResponse(String userQuery) {
    String intent = _classifyIntent(userQuery);
    return _intents[intent]!;
  }

  void _displayChatbotResponse(String response) {
    setState(() {
      _messages.insert(0, {"sender": "chatbot", "text": response});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Chatbot'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _buildMessageBubble(_messages[index]);
                },
              ),
            ),
            _buildInputField(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, String> message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Align(
        alignment: message['sender'] == 'user' ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: message['sender'] == 'user' ? Colors.blueAccent : Colors.grey[800],
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
          margin: EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            message['text']!,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[900],
                hintText: 'Type a message...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
              ),
              style: TextStyle(color: Colors.white),
              textCapitalization: TextCapitalization.sentences,
              onSubmitted: _handleSubmitted,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () => _handleSubmitted(_controller.text),
            color: Colors.blueAccent,
          ),
        ],
      ),
    );
  }
}
