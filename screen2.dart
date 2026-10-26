import 'package:flutter/material.dart';

void main() {
  runApp(const ReachUApp());
}

class ReachUApp extends StatelessWidget {
  const ReachUApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReachU',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const DashboardPage(),
    );
  }
}

// DATA FOR EACH INFORMATION CARD
class TopicCardData {
  final String topic;
  final String title;
  final String description;

  const TopicCardData({
    required this.topic,
    required this.title,
    required this.description,
  });
}

// DASHBOARD PAGE
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  // INFORMATION CARDS
  static const List<TopicCardData> informationCards = [
    TopicCardData(
      topic: 'Anxiety',
      title: 'How to Deal with Anxiety',
      description:
          'Ground yourself and remind yourself of what is true.',
    ),
    TopicCardData(
      topic: 'Depression',
      title: 'How to Deal with Depression',
      description:
          'Find support and remember that difficult feelings can change.',
    ),
    TopicCardData(
      topic: 'OCD',
      title: 'Understanding OCD',
      description:
          'Learn about OCD and seek support from a qualified professional.',
    ),
    TopicCardData(
      topic: 'Loneliness',
      title: 'Coping with Loneliness',
      description:
          'Connect with others and seek social support.',
    ),
    TopicCardData(
      topic: 'Insecurity',
      title: 'Building Self-Confidence',
      description:
          'Challenge negative thoughts and practise self-compassion.',
    ),
  ];

  @override
  State<DashboardPage> createState() =>
      _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final TextEditingController _messageController =
      TextEditingController();

  final List<String> _messages = [];

  // CREATE FUNCTION
  void _createMessage() {
    final message = _messageController.text.trim();

    if (message.isEmpty) return;

    setState(() {
      _messages.add(message);
      _messageController.clear();
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      // TOP BAR
      appBar: AppBar(
        title: const Text(
          'ReachU',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: false,
      ),

      // DASHBOARD CONTENT
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Your Dashboard',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Explore information on topics that matter to you.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
            ),
          ),

          const SizedBox(height: 24),

          // ENCOURAGING MESSAGE TEXTBOX
          const Text(
            'Share Some Encouragement!',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: _messageController,
            maxLines: 3,
            maxLength: 300,
            decoration: InputDecoration(
              hintText: 'Write an encouraging message...',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          // UPLOAD BUTTON
          ElevatedButton(
            onPressed: _createMessage,
            child: const Text('Upload Message'),
          ),

          const SizedBox(height: 20),

          // DISPLAY CREATED MESSAGES
          const Text(
            'Community Messages',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          ..._messages.map(
            (message) => Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(message),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // DISPLAY INFORMATION CARDS
          ...DashboardPage.informationCards.map(
            (card) => InformationCard(card: card),
          ),
        ],
      ),
    );
  }
}

// REUSABLE INFORMATION CARD DESIGN
class InformationCard extends StatelessWidget {
  final TopicCardData card;

  const InformationCard({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TOPIC LABEL
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                card.topic,
                style: TextStyle(
                  color: Colors.blue.shade800,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // CARD TITLE
            Text(
              card.title,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            // INFORMATION TEXT
            Text(
              card.description,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}