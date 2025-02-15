import 'package:get/get.dart';

class InboxController extends GetxController {
  final chats = <Chat>[
    Chat(
      name: 'Barbarella Inova',
      image: 'https://example.com/image1.jpg',
      lastMessage: 'Your appointment has been confirmed',
      date: 'Dec 20, 2024',
      unread: true,
    ),
    Chat(
      name: 'The Classic Cut',
      image: 'https://example.com/image2.jpg',
      lastMessage: 'Thank you for choosing our service',
      date: 'Dec 07, 2024',
      unread: false,
    ),
    Chat(
      name: 'Nathan Alexander',
      image: 'https://example.com/image3.jpg',
      lastMessage: 'See you tomorrow at 2 PM',
      date: 'Nov 19, 2024',
      unread: true,
    ),
    Chat(
      name: 'Oh La La Barber',
      image: 'https://example.com/image4.jpg',
      lastMessage: 'Would you like to reschedule?',
      date: 'Nov 12, 2024',
      unread: false,
    ),
    Chat(
      name: 'Luke Garfield',
      image: 'https://example.com/image5.jpg',
      lastMessage: 'Your booking has been confirmed',
      date: 'Oct 23, 2024',
      unread: false,
    ),
    Chat(
      name: 'Jenny Winkles',
      image: 'https://example.com/image6.jpg',
      lastMessage: 'Looking forward to seeing you',
      date: 'Oct 05, 2024',
      unread: true,
    ),
    Chat(
      name: 'Chesterfield Barber',
      image: 'https://example.com/image7.jpg',
      lastMessage: 'How was your experience?',
      date: 'Oct 21, 2024',
      unread: false,
    ),
    Chat(
      name: 'Sarah Wilson',
      image: 'https://example.com/image8.jpg',
      lastMessage: 'Your appointment reminder',
      date: 'Oct 01, 2024',
      unread: false,
    ),
  ].obs;

  void openChat(Chat chat) {
    // Chat sahifasiga o'tish
    Get.toNamed('/chat-details', arguments: chat);
  }
}

class Chat {
  final String name;
  final String image;
  final String lastMessage;
  final String date;
  final bool unread;

  Chat({
    required this.name,
    required this.image,
    required this.lastMessage,
    required this.date,
    required this.unread,
  });
}
