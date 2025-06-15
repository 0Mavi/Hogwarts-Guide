import 'package:flutter/material.dart';
import 'package:guidehogwarts/models/house_model.dart';
import 'package:guidehogwarts/theme/app_colors.dart';
import 'package:guidehogwarts/widgets/wavy_clipper.dart';

class HouseDetailScreen extends StatelessWidget {
  final House house;

  const HouseDetailScreen({super.key, required this.house});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          // Cor de fundo base
          Container(color: AppColors.cream),
          // A forma ondulada colorida
          ClipPath(
            clipper: WavyClipper(),
            child: Container(
              color: house.primaryColor.withOpacity(0.8),
            ),
          ),
          // Conteúdo da tela que rola
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Botão de voltar
                    BackButton(color: house.name == 'Lufa-Lufa' ? AppColors.brownie : Colors.white),
                    const SizedBox(height: 20),
                    Center(
                      child: Hero(
                        tag: house.name,
                        child: Image.asset(
                          house.imagePath,
                          height: 150,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Fundador:', house.founder),
                    _buildSectionTitle('Cores:', house.colorsDescription),
                    _buildSectionTitle('Animal:', house.animal),
                    const SizedBox(height: 24),
                    _buildInfoCard(
                      title: 'Valores e Qualidades',
                      content: house.values,
                      color: house.primaryColor,
                    ),
                    const SizedBox(height: 16),
                    _buildInfoCard(
                      title: 'Características dos Grifinórios',
                      content: house.characteristics,
                      color: house.primaryColor,
                    ),
                    const SizedBox(height: 16),
                    _buildInfoCard(
                      title: 'Alunos Famosos',
                      content: house.famousMembers,
                      color: house.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Widget auxiliar para os títulos de seção
  Widget _buildSectionTitle(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.brownie,
            fontFamily: 'serif',
          ),
          children: [
            TextSpan(
              text: '$title ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para os cards de informação
  Widget _buildInfoCard(
      {required String title,
        required String content,
        required Color color}) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              color: AppColors.coffee,
              fontSize: 15,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
