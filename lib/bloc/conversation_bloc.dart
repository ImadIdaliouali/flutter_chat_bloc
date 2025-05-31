import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/mock_data.dart';
import '../models/conversation.dart';
import '../models/message.dart';
import 'conversation_event.dart';
import 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  List<Conversation> _conversations = [];
  Map<String, List<Message>> _messagesMap = {};

  ConversationBloc() : super(ConversationInitial()) {
    on<LoadConversations>(_onLoadConversations);
    on<LoadMessages>(_onLoadMessages);
    on<SendMessage>(_onSendMessage);
    on<ReceiveMessage>(_onReceiveMessage);
    on<CreateNewConversation>(_onCreateNewConversation);
  }

  Future<void> _onLoadConversations(
    LoadConversations event,
    Emitter<ConversationState> emit,
  ) async {
    try {
      emit(ConversationLoading());
      
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      _conversations = List.from(MockData.mockConversations);
      _messagesMap = Map.from(MockData.mockMessages);
      
      emit(ConversationLoaded(conversations: _conversations));
    } catch (e) {
      emit(ConversationError(message: e.toString()));
    }
  }

  Future<void> _onLoadMessages(
    LoadMessages event,
    Emitter<ConversationState> emit,
  ) async {
    try {
      final messages = _messagesMap[event.conversationId] ?? [];
      emit(MessagesLoaded(
        messages: messages,
        conversationId: event.conversationId,
      ));
    } catch (e) {
      emit(ConversationError(message: e.toString()));
    }
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<ConversationState> emit,
  ) async {
    try {
      final newMessage = Message(
        id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
        conversationId: event.conversationId,
        content: event.content,
        isMe: true,
        timestamp: DateTime.now(),
      );

      // Add message to the conversation
      if (_messagesMap[event.conversationId] == null) {
        _messagesMap[event.conversationId] = [];
      }
      _messagesMap[event.conversationId]!.add(newMessage);

      // Update conversation last message
      final conversationIndex = _conversations.indexWhere(
        (conv) => conv.id == event.conversationId,
      );
      
      if (conversationIndex != -1) {
        _conversations[conversationIndex] = _conversations[conversationIndex].copyWith(
          lastMessage: event.content,
          timestamp: DateTime.now(),
        );
      }

      emit(MessageSent(message: newMessage));
      
      // Emit updated messages
      final updatedMessages = _messagesMap[event.conversationId] ?? [];
      emit(MessagesLoaded(
        messages: updatedMessages,
        conversationId: event.conversationId,
      ));

      // Simulate receiving a response after a delay
      _simulateResponse(event.conversationId);
    } catch (e) {
      emit(ConversationError(message: e.toString()));
    }
  }

  Future<void> _onReceiveMessage(
    ReceiveMessage event,
    Emitter<ConversationState> emit,
  ) async {
    try {
      final newMessage = Message(
        id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
        conversationId: event.conversationId,
        content: event.content,
        isMe: false,
        timestamp: DateTime.now(),
      );

      // Add message to the conversation
      if (_messagesMap[event.conversationId] == null) {
        _messagesMap[event.conversationId] = [];
      }
      _messagesMap[event.conversationId]!.add(newMessage);

      // Update conversation last message and increment unread count
      final conversationIndex = _conversations.indexWhere(
        (conv) => conv.id == event.conversationId,
      );
      
      if (conversationIndex != -1) {
        _conversations[conversationIndex] = _conversations[conversationIndex].copyWith(
          lastMessage: event.content,
          timestamp: DateTime.now(),
          unreadCount: _conversations[conversationIndex].unreadCount + 1,
        );
      }

      emit(MessageReceived(message: newMessage));
      
      // Emit updated messages
      final updatedMessages = _messagesMap[event.conversationId] ?? [];
      emit(MessagesLoaded(
        messages: updatedMessages,
        conversationId: event.conversationId,
      ));
    } catch (e) {
      emit(ConversationError(message: e.toString()));
    }
  }

  Future<void> _onCreateNewConversation(
    CreateNewConversation event,
    Emitter<ConversationState> emit,
  ) async {
    try {
      final newConversation = Conversation(
        id: 'conv_${DateTime.now().millisecondsSinceEpoch}',
        contactName: event.contactName,
        lastMessage: 'New conversation started',
        timestamp: DateTime.now(),
        unreadCount: 0,
      );

      _conversations.insert(0, newConversation);
      _messagesMap[newConversation.id] = [];

      emit(ConversationLoaded(conversations: _conversations));
    } catch (e) {
      emit(ConversationError(message: e.toString()));
    }
  }

  void _simulateResponse(String conversationId) {
    Future.delayed(const Duration(seconds: 2), () {
      final responses = [
        "That's interesting!",
        "Thanks for letting me know!",
        "I'll get back to you soon.",
        "Sounds good to me!",
        "Let me think about it.",
      ];
      
      final randomResponse = responses[DateTime.now().millisecond % responses.length];
      add(ReceiveMessage(conversationId: conversationId, content: randomResponse));
    });
  }
}
