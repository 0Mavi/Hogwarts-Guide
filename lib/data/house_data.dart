import 'package:flutter/material.dart';
import 'package:guidehogwarts/models/house_model.dart';



class HouseData {
  static const gryffindor = House(
    name: 'Grifinória',
    imagePath: 'assets/images/Gryffindor.webp',
    primaryColor: Color(0xFF7F0909),
    secondaryColor: Color(0xFFD3A625),
    founder: 'Godrico Gryffindor',
    animal: 'Leão',
    colorsDescription: 'Vermelho e dourado',
    values: 'A Grifinória é conhecida por valorizar a coragem, ousadia, determinação e bravura. Seus membros são frequentemente destemidos, mesmo que isso signifique enfrentar grandes perigos.',
    characteristics: '• Companheiros destemidos\n• Líderes natos\n• Fortes em espírito\n• Dispostos a lutar pelo que acreditam',
    famousMembers: '• Harry Potter\n• Hermione Granger\n• Rony Weasley\n• Minerva McGonagall\n• Alvo Dumbledore',
  );

  static const slytherin = House(
    name: 'Sonserina',
    imagePath: 'assets/images/slytherin.webp',
    primaryColor: Color(0xFF1A472A),
    secondaryColor: Color(0xFF5D5D5D),
    founder: 'Salazar Slytherin',
    animal: 'Serpente',
    colorsDescription: 'Verde e prata',
    values: 'A Sonserina valoriza ambição, astúcia, determinação e liderança. Seus membros tendem a ser muito espertos e ter um forte senso de autopreservação.',
    characteristics: '• Ambiciosos e estratégicos\n• Inteligentes e calculistas\n• Fazem o que for necessário para atingir seus objetivos\n• Leais aos seus pares',
    famousMembers: '• Tom Riddle (Lord Voldemort)\n• Severo Snape\n• Draco Malfoy\n• Bellatrix Lestrange\n• Horácio Slughorn',
  );

  static const hufflepuff = House(
    name: 'Lufa-Lufa',
    imagePath: 'assets/images/hufflepuff.webp',
    primaryColor: Color(0xFFEEB939),
    secondaryColor: Color(0xFF372E29),
    founder: 'Helga Hufflepuff',
    animal: 'Texugo',
    colorsDescription: 'Amarelo e preto',
    values: 'A Lufa-Lufa valoriza trabalho duro, paciência, lealdade e justiça. É a casa mais inclusiva, acolhendo bruxos que demonstram dedicação e coração puro.',
    characteristics: '• Leais e confiáveis\n• Justos e pacientes\n• Trabalhadores e prestativos\n• Justos e acolhedores',
    famousMembers: '• Newton Scamander\n• Cedrico Diggory\n• Ninfadora Tonks\n• Pomona Sprout\n• Teseu Scamander',
  );

  static const ravenclaw = House(
    name: 'Corvinal',
    imagePath: 'assets/images/ravenclaw.webp',
    primaryColor: Color(0xFF0E1A40),
    secondaryColor: Color(0xFF946B2D),
    founder: 'Rowena Ravenclaw',
    animal: 'Águia',
    colorsDescription: 'Azul e bronze',
    values: 'A Corvinal preza pela inteligência, criatividade, sabedoria e aprendizado. Seus membros são conhecidos por suas ideias originais e paixão pelo conhecimento.',
    characteristics: '• Pensadores independentes\n• Curiosos e dispostos a aprender de tudo\n• Criativos e imaginativos\n• Lógicos e muito perspicazes',
    famousMembers: '• Luna Lovegood\n• Fílio Flitwick\n• Cho Chang\n• Gilderoy Lockhart\n• Garrick Olivaras',
  );

  static const List<House> allHouses = [gryffindor, slytherin, hufflepuff, ravenclaw];
}
