import 'package:equatable/equatable.dart';
import '../models/conversation.dart';
import '../models/message.dart';

abstract class ConversationState extends Equatable {
  const ConversationState();

  @override
  List<Object> get props => [];
}

class ConversationInitial extends ConversationState {}

class ConversationLoading extends ConversationState {}

class ConversationLoaded extends ConversationState {
  final List<Conversation> conversations;

  const ConversationLoaded({required this.conversations});

  @override
  List<Object> get props => [conversations];
}

class ConversationError extends ConversationState {
  final String message;

  const ConversationError({required this.message});

  @override
  List<Object> get props => [message];
}

class MessagesLoaded extends ConversationState {
  final List<Message> messages;
  final String conversationId;

  const MessagesLoaded({
    required this.messages,
    required this.conversationId,
  });

  @override
  List<Object> get props => [messages, conversationId];
}

class MessageSent extends ConversationState {
  final Message message;

  const MessageSent({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageReceived extends ConversationState {
  final Message message;

  const MessageReceived({required this.message});

  @override
  List<Object> get props => [message];
}
