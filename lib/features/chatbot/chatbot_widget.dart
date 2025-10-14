import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'chatbot_store.dart';

class ChatbotFloating extends ConsumerStatefulWidget {
  const ChatbotFloating({super.key});

  @override
  ConsumerState<ChatbotFloating> createState() => _ChatbotFloatingState();
}

class _ChatbotFloatingState extends ConsumerState<ChatbotFloating> {
  bool open = false;
  final ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatbotProvider);
    return Stack(
      children: [
        Positioned(
          right: 16,
          bottom: 90,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: !open
                ? const SizedBox.shrink()
                : Container(
                    width: 320,
                    height: 380,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [BoxShadow(blurRadius: 10, color: Colors.black12)],
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 44,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          ),
                          child: const Text('AI Assistant'),
                        ),
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(12),
                            itemCount: state.messages.length,
                            itemBuilder: (context, index) {
                              final m = state.messages[index];
                              final isUser = m.type == 'user';
                              return Align(
                                alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 4),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: isUser ? Colors.blue.shade50 : Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(m.content),
                                ),
                              );
                            },
                          ),
                        ),
                        const Divider(height: 1),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: ctrl,
                                  decoration: const InputDecoration(hintText: 'Hỏi trợ lý...'),
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  final t = ctrl.text.trim();
                                  if (t.isEmpty) return;
                                  ref.read(chatbotProvider.notifier).send(t);
                                  ctrl.clear();
                                },
                                child: const Text('Gửi'),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
          ),
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton(
            onPressed: () => setState(() => open = !open),
            child: Icon(open ? Icons.close : Icons.smart_toy_outlined),
          ),
        )
      ],
    );
  }
}



