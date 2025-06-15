import 'package:flutter/material.dart';
import 'package:guidehogwarts/theme/app_colors.dart';
import 'package:guidehogwarts/widgets/profile_wave_clipper.dart';

// Uma classe modelo para representar uma mensagem
class ChatMessage {
  final String text;
  final bool isUser; // true se a mensagem for do usuário, false se for do bot

  ChatMessage({required this.text, required this.isUser});
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(text: "Olá! Sou seu assistente mágico. Como posso ajudar sobre o mundo de Harry Potter?", isUser: false),
  ];

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(text: _controller.text, isUser: true));
        // Aqui você adicionaria a lógica para obter uma resposta do "assistente"
        // Por enquanto, vamos simular uma resposta automática.
        _messages.add(ChatMessage(text: "Essa é uma ótima pergunta! Deixe-me consultar meus livros...", isUser: false));
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        title: const Text('Chat de Dúvidas', style: TextStyle(color: AppColors.brownie)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.brownie),
      ),
      body: Stack(
        children: [
          // Fundo de onda
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: ProfileWaveClipper(), // Reutilizando a onda do perfil
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                color: AppColors.coffee.withOpacity(0.5),
              ),
            ),
          ),
          Column(
            children: [
              // Lista de mensagens
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return _buildMessageBubble(message);
                  },
                ),
              ),
              // Campo de entrada de texto
              _buildTextInput(),
            ],
          ),
        ],
      ),
    );
  }

  // Widget para a bolha de mensagem
  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
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

  // Widget para o campo de texto e botão de enviar
  Widget _buildTextInput() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Digite sua pergunta...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Material(
            color: AppColors.brownie,
            borderRadius: BorderRadius.circular(30),
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: _sendMessage,
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
