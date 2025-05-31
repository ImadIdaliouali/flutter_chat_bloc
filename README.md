# Flutter Chat Application with BLoC Pattern

This is a Flutter chat application developed as part of the S4-FI-GLSID Mobile Development exam at École Normale Supérieure de l'Enseignement Technique de Mohammedia.

## Features

### 1. Conversation List Screen

- ✅ List of conversations with avatar, contact name, and last message
- ✅ Badge for unread messages count
- ✅ Navigation to detailed conversation screen
- ✅ Ability to create new conversations
- ✅ Timestamps formatted intelligently (time, yesterday, day, date)

### 2. Chat Detail Screen

- ✅ Messages from selected conversation
- ✅ Input field to send new messages
- ✅ Visual differentiation between user and contact messages
- ✅ Message timestamps
- ✅ Auto-scroll to bottom when new messages arrive
- ✅ Simulated responses from contacts

## Architecture

### BLoC Pattern Implementation

The application uses the BLoC (Business Logic Component) pattern for state management:

#### Events (conversation_event.dart)

- `LoadConversations`: Loads all conversations
- `LoadMessages`: Loads messages for a specific conversation
- `SendMessage`: Sends a new message
- `ReceiveMessage`: Receives a message from a contact
- `CreateNewConversation`: Creates a new conversation

#### States (conversation_state.dart)

- `ConversationInitial`: Initial state
- `ConversationLoading`: Loading data
- `ConversationLoaded`: Conversations loaded successfully
- `ConversationError`: Error occurred
- `MessagesLoaded`: Messages for a conversation loaded
- `MessageSent`: New message sent
- `MessageReceived`: New message received

#### BLoC (conversation_bloc.dart)

- Manages the application state
- Handles all events and emits appropriate states
- Maintains conversations and messages data
- Simulates automatic responses from contacts

### Data Models

#### Conversation Model

```dart
class Conversation {
  final String id;
  final String contactName;
  final String lastMessage;
  final DateTime timestamp;
  final int unreadCount;
}
```

#### Message Model

```dart
class Message {
  final String id;
  final String conversationId;
  final String content;
  final bool isMe; // for message alignment (right/left)
  final DateTime timestamp;
}
```

## Project Structure

```
lib/
├── main.dart                          # App entry point
├── models/
│   ├── conversation.dart              # Conversation data model
│   └── message.dart                   # Message data model
├── bloc/
│   ├── conversation_bloc.dart         # BLoC implementation
│   ├── conversation_event.dart        # Events definition
│   └── conversation_state.dart        # States definition
├── screens/
│   ├── conversation_list_screen.dart  # Conversations list UI
│   └── chat_detail_screen.dart        # Chat detail UI
└── data/
    └── mock_data.dart                 # Mock data for testing
```

## Navigation

The application implements navigation between screens:

- **Conversation List** → **Chat Detail**: Tap on any conversation item
- **Chat Detail** → **Conversation List**: Use back button or app bar back navigation
- **New Conversation**: Floating action button on conversation list screen

## Dependencies

```yaml
dependencies:
  flutter_bloc: ^8.1.3 # BLoC state management
  equatable: ^2.0.5 # Value equality for states/events
  intl: ^0.19.0 # Date formatting
```

## Key Features Implemented

1. **Immutable States**: All states extend Equatable for proper comparison
2. **Mock Data**: Simulated conversations and messages for testing
3. **Real-time Updates**: Messages update in real-time when sent/received
4. **Responsive UI**: Modern Material Design 3 interface
5. **Error Handling**: Proper error states and user feedback
6. **Automatic Responses**: Simulated responses from contacts after sending messages

## How to Run

1. Ensure Flutter is installed on your system
2. Navigate to the project directory
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to start the application
