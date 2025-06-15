import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:guidehogwarts/screens/menu_screen.dart';
import 'package:guidehogwarts/theme/app_colors.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
  late AnimationController _buttonController;
  late Animation<double> _scaleAnimation;
  late AnimationController _candleController;

  @override
  void initState() {
    super.initState();
    // Animação para o botão de "Entrar"
    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeInOut),
    );

    // Animação para as velas flutuantes
    _candleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _buttonController.dispose();
    _candleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Cor de fundo principal
          Container(color: AppColors.brownie),


          // Velas flutuantes animadas
          _buildAnimatedCandle(top: 100, left: 40, height: 60, controller: _candleController, begin: -5, end: 5),
          _buildAnimatedCandle(top: 60, left: 130, height: 40, controller: _candleController, delay: 0.5, begin: 5, end: -5),
          _buildAnimatedCandle(top: 180, left: 90, height: 80, controller: _candleController, delay: 0.2, begin: -8, end: 8),
          _buildAnimatedCandle(bottom: 60, right: 50, height: 70, controller: _candleController, delay: 0.3, begin: 6, end: -6),
          _buildAnimatedCandle(bottom: 110, right: 100, height: 50, controller: _candleController, delay: 0.7, begin: -4, end: 4),


          // Conteúdo Principal (Título e Botão)
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 5),
                  // Título estilizado
                  const Text(
                    'Hogwarts',
                    style: TextStyle(
                      fontFamily: 'serif',
                      fontSize: 55,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 2,
                      shadows: [
                        Shadow(blurRadius: 20.0, color: Colors.black, offset: Offset(3.0, 3.0)),
                      ],
                    ),
                  ),
                  const Text(
                    'Guide',
                    style: TextStyle(
                      fontFamily: 'serif',
                      fontSize: 55,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 2,
                      shadows: [
                        Shadow(blurRadius: 20.0, color: Colors.black, offset: Offset(3.0, 3.0)),
                      ],
                    ),
                  ),
                  const Spacer(flex: 3),

                  // Botão de Entrar com animação
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => const MenuScreen(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return FadeTransition(opacity: animation, child: child);
                            },
                            transitionDuration: const Duration(milliseconds: 800),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(12, 12, 20, 12),
                            decoration: BoxDecoration(
                                color: AppColors.coffee.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: AppColors.cream.withOpacity(0.2))
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                      color: AppColors.caramel,
                                      shape: BoxShape.circle
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: AppColors.brownie,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                const Text(
                                  'Entrar',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColors.cream,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(flex: 1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget para a vela animada
  Widget _buildAnimatedCandle({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required double height,
    required AnimationController controller,
    double delay = 0.0,
    double begin = -5,
    double end = 5,
  }) {
    final animation = Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(delay, 1.0, curve: Curves.easeInOut),
      ),
    );

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Positioned(
          top: top,
          bottom: bottom,
          left: left,
          right: right,
          child: Transform.translate(
            offset: Offset(animation.value, 0),
            child: child,
          ),
        );
      },
      child: _Candle(height: height),
    );
  }
}

// Widget para desenhar a chama da vela
class _CandleFlamePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [Colors.amber.shade400, Colors.orange.withOpacity(0.5), Colors.transparent],
        stops: const [0.3, 0.7, 1.0],
      ).createShader(Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width));

    final path = Path();
    path.moveTo(size.width * 0.5, size.height);
    path.quadraticBezierTo(size.width, size.height * 0.5, size.width * 0.5, 0);
    path.quadraticBezierTo(0, size.height * 0.5, size.width * 0.5, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Widget para o corpo da vela
class _Candle extends StatelessWidget {
  final double height;
  const _Candle({required this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomPaint(
          size: const Size(12, 18),
          painter: _CandleFlamePainter(),
        ),
        Container(
          width: 15,
          height: height,
          decoration: BoxDecoration(
              color: AppColors.cream.withOpacity(0.95),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(2,2)
                )
              ]
          ),
        ),
      ],
    );
  }
}



