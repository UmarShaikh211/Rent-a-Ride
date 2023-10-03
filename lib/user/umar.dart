// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(ChatBotApp());
// }
//
// class ChatBotApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('ChatBot'),
//         ),
//         body: ChatBot(),
//       ),
//     );
//   }
// }
//
// class ChatBot extends StatefulWidget {
//   @override
//   _ChatBotState createState() => _ChatBotState();
// }
//
// class _ChatBotState extends State<ChatBot> {
//   final List<String> questions = [
//     "1. What is your name?",
//     "2. How are you today?",
//     "3. What can you do?",
//     "4. Tell me a joke.",
//     "5. What's the weather like today?",
//     "6. Thank you!"
//   ];
//
//   final Map<String, String> answers = {
//     "1. What is your name?": "My name is ChatBot.",
//     "2. How are you today?":
//         "I'm just a computer program, so I don't have feelings, but I'm here to help!",
//     "3. What can you do?":
//         "I can answer questions, provide information, and assist with various tasks.",
//     "4. Tell me a joke.":
//         "Why don't scientists trust atoms? Because they make up everything!",
//     "5. What's the weather like today?":
//         "I'm sorry, I don't have access to real-time weather information.",
//     "6. Thank you!":
//         "You're welcome! If you have more questions, feel free to ask."
//   };
//
//   String chatMessage = "";
//
//   void handleQuestionTap(String question) {
//     if (answers.containsKey(question)) {
//       setState(() {
//         chatMessage = "Answer: " + answers[question]!;
//       });
//     } else {
//       setState(() {
//         chatMessage = "I'm sorry, I don't have an answer to that question.";
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: ListView.builder(
//               itemCount: questions.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(questions[index]),
//                   onTap: () => handleQuestionTap(questions[index]),
//                 );
//               },
//             ),
//           ),
//           Divider(),
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Text(chatMessage),
//           ),
//         ],
//       ),
//     );
//   }
// }
