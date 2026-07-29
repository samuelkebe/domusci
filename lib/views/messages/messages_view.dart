import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ressources/app_colors.dart';
import '../../ressources/app_text_styles.dart';
import '../../views-models/messages_view_model.dart';
import '../widgets/chat/chat_bubble.dart';
import '../widgets/search/domus_search_bar.dart';
import 'chat_view.dart';

/// Vue — Liste des conversations.
class MessagesView extends StatelessWidget {
  const MessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MessagesViewModel()..load(),
      child: Consumer<MessagesViewModel>(
        builder: (context, vm, _) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Text('Messages'),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: DomusSearchBar(hint: 'Rechercher une conversation…'),
                  ),
                  Expanded(
                    child: vm.isLoading
                        ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                        : ListView.separated(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
                            itemCount: vm.conversations.length,
                            separatorBuilder: (_, __) => const Divider(),
                            itemBuilder: (context, i) {
                              final c = vm.conversations[i];
                              return ConversationTile(
                                conversation: c,
                                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ChatView(conversation: c))),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
