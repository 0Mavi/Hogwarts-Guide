import 'package:flutter/material.dart';
import 'package:guidehogwarts/theme/app_colors.dart';
import 'package:guidehogwarts/widgets/profile_wave_clipper.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // A cor de fundo base da tela
      backgroundColor: AppColors.cream,
      body: Stack(
        children: [
          // A forma de onda colorida no fundo
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: ProfileWaveClipper(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                color: AppColors.caramel.withOpacity(0.8),
              ),
            ),
          ),

          // O conteúdo principal da tela
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BackButton(color: AppColors.brownie),
                  const SizedBox(height: 20),
                  // Logo HP
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.brownie,
                      child: const Text(
                        'HP',
                        style: TextStyle(
                          fontFamily: 'serif',
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: AppColors.cream,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Seções de texto
                  _buildInfoSection(
                    context: context,
                    content: 'Este aplicativo foi feito especialmente para fãs de Harry Potter que queiram aprender mais sobre o universo mágico e tirar dúvidas de forma interativa e divertida.',
                  ),
                  const SizedBox(height: 32),
                  _buildInfoSection(
                    context: context,
                    title: 'Chat de Dúvidas',
                    content: 'Converse com um assistente mágico e tire todas as suas dúvidas sobre personagens, feitiços, criaturas, lugares e eventos do mundo de Harry Potter!',
                  ),
                  const SizedBox(height: 32),
                  _buildInfoSection(
                    context: context,
                    title: 'Conheça as Casas de Hogwarts',
                    content: 'Explore as quatro casas de Hogwarts — Grifinória, Sonserina, Corvinal e Lufa-Lufa — e descubra suas histórias, valores, símbolos e alunos famosos.',
                  ),
                  const SizedBox(height: 120), // Espaço para não sobrepor o texto de créditos
                ],
              ),
            ),
          ),

          // Texto de créditos posicionado na parte inferior
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: Text(
                'Feito por Maria Vitória e Pedro Henrique',
                style: TextStyle(
                  color: AppColors.cream,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget auxiliar para criar as seções de texto e evitar repetição de código
  Widget _buildInfoSection({
    required BuildContext context,
    String? title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (title != null)
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.brownie,
            ),
          ),
        if (title != null) const SizedBox(height: 8),
        Text(
          content,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.coffee,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
