// import 'package:flutter/material.dart';
// import 'package:iconify_flutter/iconify_flutter.dart';
// import 'package:iconify_flutter/icons/lucide.dart';
// import '../../models/conversation.dart';
// import '../widgets/chat/chat_bubble.dart';
//
// /// Vue — Conversation individuelle (chat bubbles, appel rapide).
// class ChatView extends StatefulWidget {
//   final Conversation conversation;
//   const ChatView({super.key, required this.conversation});
//
//   @override
//   State<ChatView> createState() => _ChatViewState();
// }
//
// class _ChatViewState extends State<ChatView> {
//   late List<ChatMessage> _messages = List.from(widget.conversation.messages);
//   final _textController = TextEditingController();
//
//   void _send() {
//     if (_textController.text.trim().isEmpty) return;
//     setState(() {
//       _messages = [..._messages, ChatMessage(text: _textController.text.trim(), isMe: true, time: 'Maintenant')];
//     });
//     _textController.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final c = widget.conversation;
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () => Navigator.of(context).maybePop(),
//                     child: Container(
//                       width: 34,
//                       height: 34,
//                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
//                       child: const Iconify(Lucide.chevron_left, size: 17),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(c.avatarUrl, width: 38, height: 38, fit: BoxFit.cover)),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(c.name, style: AppTextStyles.bodyMd.copyWith(fontWeight: FontWeight.w700)),
//                         Text(c.online ? 'En ligne' : 'Hors ligne', style: AppTextStyles.caption.copyWith(color: c.online ? AppColors.success : AppColors.textSecondary)),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: 34,
//                     height: 34,
//                     decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
//                     child: const Iconify(Lucide.phone_call, size: 15, color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//             const Divider(height: 1),
//             Expanded(
//               child: ListView.builder(
//                 padding: const EdgeInsets.all(20),
//                 itemCount: _messages.length,
//                 itemBuilder: (context, i) => ChatBubble(message: _messages[i]),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 36,
//                     height: 36,
//                     decoration: const BoxDecoration(color: AppColors.background, shape: BoxShape.circle),
//                     child: const Iconify(Lucide.camera, size: 16, color: AppColors.primary),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(100)),
//                       child: TextField(
//                         controller: _textController,
//                         decoration: const InputDecoration(hintText: 'Écrire un message…', border: InputBorder.none),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   GestureDetector(
//                     onTap: _send,
//                     child: Container(
//                       width: 36,
//                       height: 36,
//                       decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
//                       child: const Iconify(Lucide.arrow_right, size: 16, color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

