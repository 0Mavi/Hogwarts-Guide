import 'package:flutter/material.dart';

class ProfileWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, size.height * 0.75);

    // Cria uma curva suave para cima
    path.quadraticBezierTo(
      size.width * 0.4,
      size.height * 0.6,
      size.width * 0.7,
      size.height * 0.8,
    );

    // Cria a segunda curva que desce para o canto inferior direito
    path.quadraticBezierTo(
      size.width * 0.9,
      size.height * 0.9,
      size.width,
      size.height * 0.85,
    );

    // Linha até o canto inferior direito e depois para o esquerdo para fechar
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
