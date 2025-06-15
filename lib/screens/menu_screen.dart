import 'package:flutter/material.dart';
import 'package:guidehogwarts/data/house_data.dart';
import 'package:guidehogwarts/models/house_model.dart';
import 'package:guidehogwarts/screens/chat_screen.dart';
import 'package:guidehogwarts/screens/house_detail_screen.dart';
import 'package:guidehogwarts/screens/profile_screen.dart';
import 'package:guidehogwarts/theme/app_colors.dart';
import 'package:guidehogwarts/widgets/profile_wave_clipper.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // Ícone de menu à esquerda
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: AppColors.brownie,
            size: 30,
          ),
          onPressed: () {

          },
        ),
        // Logo centralizada
        title: Image.asset(
          'assets/images/wand_logo.png', // IMPORTANTE: Adicione a imagem da varinha aqui
          height: 20,
          color: AppColors.brownie,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.account_circle_outlined,
              color: AppColors.brownie,
              size: 32,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Stack(
        children: [
          // Fundo de onda
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: ProfileWaveClipper(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                color: AppColors.caramel.withOpacity(0.4),
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Card de boas-vindas
                  _buildWelcomeCard(),
                  const SizedBox(height: 18),
                  // Seção "Entre no Grande Salão"
                  const Text(
                    'Entre no Grande Salão',
                    style: TextStyle(
                      fontFamily: 'serif',
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.brownie,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Pergunte sobre feitiços, poções, criaturas e muito mais!',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.coffee,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChatScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brownie,
                      foregroundColor: AppColors.cream,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Começar a Conversar'),
                  ),
                  const SizedBox(height: 20),
                  // Seção "Explorar Casas"
                  const Text(
                    'Explorar Casas',
                    style: TextStyle(
                      fontFamily: 'serif',
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.brownie,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Grid para exibir os cards das casas
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: HouseData.allHouses.length,
                    itemBuilder: (context, index) {
                      final house = HouseData.allHouses[index];
                      return _HouseCard(house: house);
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Card de boas-vindas
  Widget _buildWelcomeCard() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: AppColors.coffee,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Olá, bruxo(a)!',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.cream,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Pronto(a) para sua próxima aventura?',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.cream,
            ),
          ),
        ],
      ),
    );
  }
}

// Widget reutilizável para o card de cada casa
class _HouseCard extends StatelessWidget {
  final House house;
  const _HouseCard({required this.house});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HouseDetailScreen(house: house),
          ),
        );
      },
      child: Container(

        decoration: BoxDecoration(
          color: house.primaryColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: house.name,
              child: Image.asset(
                house.imagePath,
                height: 70,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              house.name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,

                color: house.name == 'Lufa-Lufa' ? AppColors.brownie : AppColors.cream,
              ),
            )
          ],
        ),
      ),
    );
  }
}
