import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FAQ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FAQPage(),
    );
  }
}

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          FAQItem(
            question: 'How can I add my car to the app?',
            answer:
                'To add your car to the app, log in to your host account and go to the "Add Car" section. Fill out the required information about your car, including brand, model, year, and photos. Once you submit the details, your car will be listed on the app for renters to see.',
          ),
          FAQItem(
            question: 'How do I set the rental price for my car?',
            answer:
                'You can set the rental price for your car from the pricing tab. You can set the hourly price for your car. Make sure to research the market to set a competitive price.',
          ),
          FAQItem(
            question: 'What are the requirements for listing a car?',
            answer:
                'To list a car on our app, your car must meet certain requirements, including being in good working condition, properly insured, and meeting safety standards. We also require you to provide clear and accurate information about your car and upload high-quality photos.',
          ),
          FAQItem(
            question: 'How do I earn money as a host?',
            answer:
                "You can earn money as a host by renting out your car to users of the app. You'll receive payment for each rental, and you can set your own pricing. The more bookings you receive, the more you can earn. Payments are usually processed within a specified time frame.",
          ),
          FAQItem(
            question:
                "What happens if there's damage to my car during a rental?",
            answer:
                'In the event of damage to your car during a rental, our insurance coverage may apply, depending on the circumstances. We recommend documenting the condition of your car before and after each rental and reporting any damage to our support team as soon as possible. We will guide you through the claims process.',
          ),
        ],
      ),
    );
  }
}

class FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});

  @override
  _FAQItemState createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              widget.question,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.blue,
              ),
            ),
            trailing: IconButton(
              icon:
                  _expanded ? Icon(Icons.expand_less) : Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                widget.answer,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
