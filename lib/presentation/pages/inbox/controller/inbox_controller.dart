import 'package:get/get.dart';
import '../../../../core/utils/logger.dart';

class InboxController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    AppLogger.debug('Initializing InboxController');
    loadMessages();
  }

  Future<void> loadMessages() async {
    try {
      AppLogger.debug('Loading messages');
      // API call to load messages
      AppLogger.info('Messages loaded successfully');
    } catch (e) {
      AppLogger.error('Error loading messages: $e');
    }
  }

  final chats = <Chat>[
    Chat(
      name: 'Barbarella Inova',
      image:
          'https://as1.ftcdn.net/v2/jpg/00/67/74/94/1000_F_67749471_QLMZc2MowgEm0QEz9onaicGiR0Qt3YZJ.jpg',
      lastMessage: 'Your appointment has been confirmed',
      date: 'Dec 20, 2024',
      unread: true,
    ),
    Chat(
      name: 'The Classic Cut',
      image:
          'https://as1.ftcdn.net/v2/jpg/00/67/74/94/1000_F_67749471_QLMZc2MowgEm0QEz9onaicGiR0Qt3YZJ.jpg',
      lastMessage: 'Thank you for choosing our service',
      date: 'Dec 07, 2024',
      unread: false,
    ),
    Chat(
      name: 'Nathan Alexander',
      image:
          'https://as1.ftcdn.net/v2/jpg/00/67/74/94/1000_F_67749471_QLMZc2MowgEm0QEz9onaicGiR0Qt3YZJ.jpg',
      lastMessage: 'See you tomorrow at 2 PM',
      date: 'Nov 19, 2024',
      unread: true,
    ),
    Chat(
      name: 'Oh La La Barber',
      image:
          'https://as1.ftcdn.net/v2/jpg/00/67/74/94/1000_F_67749471_QLMZc2MowgEm0QEz9onaicGiR0Qt3YZJ.jpg',
      lastMessage: 'Would you like to reschedule?',
      date: 'Nov 12, 2024',
      unread: false,
    ),
    Chat(
      name: 'Luke Garfield',
      image:
          'https://as1.ftcdn.net/v2/jpg/00/67/74/94/1000_F_67749471_QLMZc2MowgEm0QEz9onaicGiR0Qt3YZJ.jpg',
      lastMessage: 'Your booking has been confirmed',
      date: 'Oct 23, 2024',
      unread: false,
    ),
    Chat(
      name: 'Jenny Winkles',
      image:
          'https://as1.ftcdn.net/v2/jpg/00/67/74/94/1000_F_67749471_QLMZc2MowgEm0QEz9onaicGiR0Qt3YZJ.jpg',
      lastMessage: 'Looking forward to seeing you',
      date: 'Oct 05, 2024',
      unread: true,
    ),
    Chat(
      name: 'Chesterfield Barber',
      image:
          'https://as1.ftcdn.net/v2/jpg/00/67/74/94/1000_F_67749471_QLMZc2MowgEm0QEz9onaicGiR0Qt3YZJ.jpg',
      lastMessage: 'How was your experience?',
      date: 'Oct 21, 2024',
      unread: false,
    ),
    Chat(
      name: 'Sarah Wilson',
      image:
          'https://as1.ftcdn.net/v2/jpg/00/67/74/94/1000_F_67749471_QLMZc2MowgEm0QEz9onaicGiR0Qt3YZJ.jpg',
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
