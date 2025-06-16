import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:guidehogwarts/theme/app_colors.dart';

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      text:
      "Olá! Sou seu assistente mágico. Como posso ajudar sobre o mundo de Harry Potter?",
      isUser: false,
    ),
  ];

  bool _isLoading = false;
  String? _sessionId;
  String? _userName;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _promptForUserName(context);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _promptForUserName(BuildContext context) async {
    final nameController = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.cream,
          title: const Text(
            'Bem-vindo, bruxo(a)!',
            style: TextStyle(color: AppColors.brownie),
          ),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: "Qual é o seu nome?"),
            autofocus: true,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Confirmar',
                style: TextStyle(color: AppColors.brownie),
              ),
              onPressed: () {
                final name = nameController.text.trim();
                if (name.isNotEmpty) {
                  setState(() {
                    _userName = name;
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage() async {
    final text = _controller.text;
    if (text.isEmpty || _isLoading) {
      return;
    }

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _isLoading = true;
    });

    _controller.clear();
    _scrollToBottom();

    try {
      final url = Uri.parse('https://dumblechatapi.onrender.com');
      final headers = {'Content-Type': 'application/json; charset=UTF-8'};

      final body = _sessionId == null
          ? jsonEncode({'nome': _userName, 'content': text})
          : jsonEncode({'session_id': _sessionId, 'content': text});

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        try {
          final responseBody = jsonDecode(utf8.decode(response.bodyBytes));
          if (responseBody is Map && responseBody.containsKey('resposta')) {
            final String botResponse = responseBody['resposta'];
            setState(() {
              _sessionId = responseBody['session_id'];
              _messages.add(ChatMessage(text: botResponse, isUser: false));
            });
          } else {
            _messages.add(ChatMessage(
              text: "Erro: resposta inesperada da API.",
              isUser: false,
            ));
          }
        } catch (e) {
          _messages.add(ChatMessage(
            text: "Erro ao interpretar a resposta da API.",
            isUser: false,
          ));
        }
      } else {
        _messages.add(ChatMessage(
          text: "Oh, não! Minha coruja se perdeu. Código: ${response.statusCode}",
          isUser: false,
        ));
      }

    } on TimeoutException {
      _messages.add(ChatMessage(
          text:
          "A coruja demorou muito para responder. Verifique sua conexão e tente novamente.",
          isUser: false));
    } on SocketException {
      _messages.add(ChatMessage(
          text:
          "Não consigo me conectar à rede dos bruxos. Verifique sua conexão com a internet.",
          isUser: false));
    } catch (e) {
      _messages.add(ChatMessage(
          text:
          "Parece que há uma interferência na rede mágica. Tente novamente mais tarde.",
          isUser: false));
    } finally {
      setState(() {
        _isLoading = false;
      });
      _scrollToBottom();
    }
  }

  void _resetChat() {
    setState(() {
      _sessionId = null;
      _messages.clear();
      _messages.add(ChatMessage(
        text:
        "Sessão reiniciada! Olá, sou seu assistente mágico. Como posso ajudar no mundo de Harry Potter?",
        isUser: false,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_userName == null) {
      return const Scaffold(
        backgroundColor: AppColors.cream,
        body: Center(
          child: CircularProgressIndicator(color: AppColors.brownie),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        title: const Text(
          'Chat de Dúvidas',
          style: TextStyle(color: AppColors.brownie),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.brownie),
        actions: [
          IconButton(
            onPressed: _resetChat,
            icon: const Icon(Icons.restart_alt),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return _buildMessageBubble(message);
                  },
                ),
              ),
              if (_isLoading) _buildTypingIndicator(),
              _buildTextInput(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, bottom: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            const SizedBox(
              width: 15,
              height: 15,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.brownie,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Assistente está digitando...',
              style: TextStyle(
                color: AppColors.brownie.withOpacity(0.8),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment:
      message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding:
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: message.isUser ? AppColors.caramel : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isUser ? AppColors.cream : AppColors.brownie,
          ),
        ),
      ),
    );
  }

  Widget _buildTextInput() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              onSubmitted: (_) => _sendMessage(),
              textInputAction: TextInputAction.send,
              decoration: InputDecoration(
                hintText: 'Digite sua pergunta...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Material(
            color: _isLoading ? Colors.grey : AppColors.brownie,
            borderRadius: BorderRadius.circular(30),
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: _isLoading ? null : _sendMessage,
              child: const SizedBox(
                height: 50,
                width: 50,
                child: Icon(Icons.send, color: AppColors.cream),
              ),
            ),
          )
        ],
      ),
    );
  }
}
