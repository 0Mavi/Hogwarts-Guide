
# 🧙‍♂️ Hogwarts Guide

Um aplicativo Flutter mágico e interativo inspirado no universo de **Harry Potter**, onde você pode conhecer mais sobre as casas de Hogwarts e tirar dúvidas com um assistente virtual encantado.

---

## ✨ Funcionalidades

- 🎓 **Tela de boas-vindas** com identidade visual inspirada em Hogwarts.
- 🏠 **Exploração das Casas de Hogwarts**: Grifinória, Sonserina, Lufa-Lufa e Corvinal.
- 📖 **Detalhes de cada casa**: valores, fundadores, características e alunos famosos.
- 💬 **Chat mágico**: Um assistente inteligente responde dúvidas sobre o mundo bruxo.
- 🎨 **Interface temática** com elementos visuais imersivos e responsivos.

---

## 🛠️ Tecnologias Utilizadas

- **Flutter** (SDK)
- **Dart**
- **API HTTP** para integração com o assistente virtual
- **Arquitetura Modular** (Separação por `screens`, `models`, `data`, `theme`)
- **Custom Colors** com `AppColors`
- **Design Responsivo e Acessível**

---

## 📁 Estrutura do Projeto

```
lib/
├── data/
│   └── house_data.dart
├── models/
│   └── house_model.dart
├── screens/
│   ├── chat_screen.dart
│   ├── house_detail_screen.dart
│   ├── menu_screen.dart
│   ├── profile_screen.dart
│   └── welcome_screen.dart
├── theme/
│   └── app_colors.dart
└── main.dart
```

---

## 🤖 Sobre o Chat Assistente

- O assistente virtual simula um personagem mágico que responde dúvidas sobre o universo de Harry Potter.
- A API utilizada é a `https://dumblechatapi.onrender.com`, que aceita um nome de usuário e a mensagem enviada.
- A sessão é mantida por um `session_id` retornado na primeira resposta.
- O app trata diferentes erros, como tempo limite e falta de conexão.

---

## 🚀 Como Rodar o Projeto

1. **Clone o repositório**:
   ```bash
   git clone https://github.com/seu-usuario/hogwarts-guide.git
   cd hogwarts-guide
   ```

2. **Instale as dependências**:
   ```bash
   flutter pub get
   ```

3. **Execute o app**:
   ```bash
   flutter run
   ```

---

## ✍️ Créditos

- Design e Desenvolvimento: **Maria Vitória** e **Pedro Henrique**
- API do Chat: [DumbleChat API](https://dumblechatapi.onrender.com)
- Documentação: [Documentação Hogwarts Guide](https://drive.google.com/drive/folders/1e-GWwmxwG3iQBwUzlbwhAwifoDJ-sYYF?usp=sharing)

---

## 📚 Licença

Este projeto é apenas para fins educacionais e sem fins lucrativos. Não possui afiliação com a marca oficial de Harry Potter.  
© 2025 - Todos os direitos reservados aos autores do projeto.
