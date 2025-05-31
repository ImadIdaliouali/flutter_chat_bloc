import '../models/conversation.dart';
import '../models/message.dart';

class MockData {
  static final List<Conversation> mockConversations = [
    Conversation(
      id: '1',
      contactName: 'Alice Johnson',
      lastMessage: 'Hey! How are you doing today?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      unreadCount: 2,
    ),
    Conversation(
      id: '2',
      contactName: 'Bob Smith',
      lastMessage: 'Thanks for the help with the project!',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      unreadCount: 0,
    ),
    Conversation(
      id: '3',
      contactName: 'Carol Williams',
      lastMessage: 'See you tomorrow at the meeting',
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      unreadCount: 1,
    ),
    Conversation(
      id: '4',
      contactName: 'David Brown',
      lastMessage: 'The Flutter project looks great!',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      unreadCount: 0,
    ),
    Conversation(
      id: '5',
      contactName: 'Emma Davis',
      lastMessage: 'Can you review my code please?',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      unreadCount: 3,
    ),
  ];

  static final Map<String, List<Message>> mockMessages = {
    '1': [
      Message(
        id: 'm1',
        conversationId: '1',
        content: 'Hi Alice! I\'m doing great, thanks for asking.',
        isMe: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
      Message(
        id: 'm2',
        conversationId: '1',
        content: 'How about you? How\'s your day going?',
        isMe: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 9)),
      ),
      Message(
        id: 'm3',
        conversationId: '1',
        content: 'Pretty good! Just working on some Flutter stuff.',
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 7)),
      ),
      Message(
        id: 'm4',
        conversationId: '1',
        content: 'Hey! How are you doing today?',
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
    ],
    '2': [
      Message(
        id: 'm5',
        conversationId: '2',
        content: 'No problem at all! Happy to help.',
        isMe: true,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Message(
        id: 'm6',
        conversationId: '2',
        content: 'Thanks for the help with the project!',
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      ),
    ],
    '3': [
      Message(
        id: 'm7',
        conversationId: '3',
        content: 'Sure, what time is the meeting?',
        isMe: true,
        timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      ),
      Message(
        id: 'm8',
        conversationId: '3',
        content: 'See you tomorrow at the meeting',
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      ),
    ],
    '4': [
      Message(
        id: 'm9',
        conversationId: '4',
        content: 'Thank you! I\'ve been working hard on it.',
        isMe: true,
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
      ),
      Message(
        id: 'm10',
        conversationId: '4',
        content: 'The Flutter project looks great!',
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ],
    '5': [
      Message(
        id: 'm11',
        conversationId: '5',
        content: 'I\'ll take a look at it this afternoon.',
        isMe: true,
        timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 1)),
      ),
      Message(
        id: 'm12',
        conversationId: '5',
        content: 'Can you review my code please?',
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ],
  };

  static List<Message> getMessagesForConversation(String conversationId) {
    return mockMessages[conversationId] ?? [];
  }
}
