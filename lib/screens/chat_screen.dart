import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:genui/genui.dart';
import 'package:genui_google_generative_ai/genui_google_generative_ai.dart';
import 'package:salt_and_pepper/widget/message_buble.dart';

import '../catalog/recipe_catalog.dart';

const double kBorder = 2.5;

const Color bg = Color(0xFFFFF3E6);
const Color black = Colors.black;
const Color red = Color(0xFFFF4D2D);
const Color yellow = Color(0xFFFFC700);
const Color white = Colors.white;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  late final GenUiManager _genUiManager;
  late final GoogleGenerativeAiContentGenerator _contentGenerator;
  late final GenUiConversation _conversation;

  final List<_ChatMessage> _messages = [];
  final List<String> _surfaceIds = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeGenUI();
  }

  void _initializeGenUI() {
    _genUiManager = GenUiManager(catalog: RecipeCatalog.catalog);

    final apiKey = dotenv.env['GEMINI_API_KEY'];

    _contentGenerator = GoogleGenerativeAiContentGenerator(
      catalog: RecipeCatalog.catalog,
      systemInstruction: RecipeCatalog.systemInstruction,
      modelName: 'models/gemini-2.5-flash',
      apiKey: apiKey!,
    );

    _conversation = GenUiConversation(
      genUiManager: _genUiManager,
      contentGenerator: _contentGenerator,
      onSurfaceAdded: _onSurfaceAdded,
      onSurfaceDeleted: _onSurfaceDeleted,
    );

    _contentGenerator.textResponseStream.listen((text) {
      if (text.isNotEmpty) {
        setState(() {
          _messages.add(
            _ChatMessage(text: text, isUser: false, timestamp: DateTime.now()),
          );
        });
        _scrollToBottom();
      }
    });

    _contentGenerator.errorStream.listen((error) {
      setState(() {
        _isLoading = false;
        _messages.add(
          _ChatMessage(
            text: 'Error: ${error.error}',
            isUser: false,
            isError: true,
            timestamp: DateTime.now(),
          ),
        );
      });
    });
  }

  void _onSurfaceAdded(SurfaceAdded update) {
    setState(() {
      _surfaceIds.add(update.surfaceId);
      _isLoading = false;
    });
    _scrollToBottom();
  }

  void _onSurfaceDeleted(SurfaceRemoved update) {
    setState(() {
      _surfaceIds.remove(update.surfaceId);
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    _textController.clear();

    setState(() {
      _messages.add(
        _ChatMessage(text: text, isUser: true, timestamp: DateTime.now()),
      );
      _isLoading = true;
      _surfaceIds.clear();
    });

    _scrollToBottom();
    _conversation.sendRequest(UserMessage.text(text));
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _conversation.dispose();
    _genUiManager.dispose();
    _contentGenerator.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        title: const Text(
          'SALT&PEPPER',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: white,
              border: Border.all(color: black, width: kBorder),
            ),
            child: const Row(
              children: [
                Text('SAVE', style: TextStyle(fontWeight: FontWeight.w900)),
                SizedBox(width: 6),
                Icon(Icons.bookmark, size: 16),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount:
                  _messages.length + _surfaceIds.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < _messages.length) {
                  final message = _messages[index];
                  return NeubrutalistBubble(
                    text: message.text,
                    isUser: message.isUser,
                    isError: message.isError,
                    timestamp: message.timestamp,
                  );
                }

                if (_isLoading && index == _messages.length) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: yellow,
                      border: Border.all(color: black, width: kBorder),
                    ),
                    child: const Text(
                      'PREPARING RECIPE...',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                  );
                }

                final surfaceIndex =
                    index - _messages.length - (_isLoading ? 1 : 0);

                if (surfaceIndex >= 0 && surfaceIndex < _surfaceIds.length) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: bg,
                      // border: Border.all(color: black, width: kBorder),
                    ),
                    child: GenUiSurface(
                      host: _genUiManager,
                      surfaceId: _surfaceIds[surfaceIndex],
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),

          // INPUT BAR
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bg,
              border: Border(
                top: BorderSide(color: black, width: kBorder),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'DESCRIBE INGREDIENTS',
                      hintStyle: const TextStyle(fontWeight: FontWeight.w800),
                      filled: true,
                      fillColor: white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(color: black, width: kBorder),
                      ),
                    ),
                    textInputAction: TextInputAction.send,
                    onSubmitted: _sendMessage,
                    enabled: !_isLoading,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _isLoading
                      ? null
                      : () => _sendMessage(_textController.text),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: red,
                      border: Border.all(color: black, width: kBorder),
                    ),
                    child: const Icon(Icons.send, color: white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isUser;
  final bool isError;
  final DateTime timestamp;

  _ChatMessage({
    required this.text,
    required this.isUser,
    this.isError = false,
    required this.timestamp,
  });
}
