import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/models/conversation.dart';
import 'package:myapp/models/message.dart';
import 'package:myapp/data/mock_data.dart';

void main() {
  group('Chat App Models Tests', () {
    test('Conversation model should be created correctly', () {
      final conversation = Conversation(
        id: 'test1',
        contactName: 'Test User',
        lastMessage: 'Hello World',
        timestamp: DateTime.now(),
        unreadCount: 2,
      );

      expect(conversation.id, 'test1');
      expect(conversation.contactName, 'Test User');
      expect(conversation.lastMessage, 'Hello World');
      expect(conversation.unreadCount, 2);
    });

    test('Message model should be created correctly', () {
      final message = Message(
        id: 'msg1',
        conversationId: 'conv1',
        content: 'Test message',
        isMe: true,
        timestamp: DateTime.now(),
      );

      expect(message.id, 'msg1');
      expect(message.conversationId, 'conv1');
      expect(message.content, 'Test message');
      expect(message.isMe, true);
    });

    test('Mock data should be available', () {
      expect(MockData.mockConversations.isNotEmpty, true);
      expect(MockData.mockMessages.isNotEmpty, true);
      
      final firstConversation = MockData.mockConversations.first;
      expect(firstConversation.contactName.isNotEmpty, true);
      
      final messages = MockData.getMessagesForConversation(firstConversation.id);
      expect(messages.isNotEmpty, true);
    });

    test('Conversation copyWith should work correctly', () {
      final original = Conversation(
        id: 'test1',
        contactName: 'Test User',
        lastMessage: 'Hello',
        timestamp: DateTime.now(),
        unreadCount: 1,
      );

      final updated = original.copyWith(
        lastMessage: 'Updated message',
        unreadCount: 3,
      );

      expect(updated.id, original.id);
      expect(updated.contactName, original.contactName);
      expect(updated.lastMessage, 'Updated message');
      expect(updated.unreadCount, 3);
    });

    test('Message copyWith should work correctly', () {
      final original = Message(
        id: 'msg1',
        conversationId: 'conv1',
        content: 'Original content',
        isMe: true,
        timestamp: DateTime.now(),
      );

      final updated = original.copyWith(
        content: 'Updated content',
        isMe: false,
      );

      expect(updated.id, original.id);
      expect(updated.conversationId, original.conversationId);
      expect(updated.content, 'Updated content');
      expect(updated.isMe, false);
    });
  });
}
