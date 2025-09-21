import 'package:flutter/material.dart';

class InterestSelectionPage extends StatefulWidget {
  final String stream;
  InterestSelectionPage({required this.stream});

  @override
  _InterestSelectionPageState createState() => _InterestSelectionPageState();
}

class _InterestSelectionPageState extends State<InterestSelectionPage> {
  final Map<String, List<String>> interestOptions = {
    'engineering': ['dealing with computers', 'construction', 'electronics'],
    'medical': ['helping people', 'lab work', 'surgery'],
    'business': ['marketing', 'finance', 'entrepreneurship'],
  };

  late List<String> options;

  @override
  void initState() {
    super.initState();
    final selectedStream = widget.stream.trim().toLowerCase();
    options = interestOptions[selectedStream] ?? [];
    print("Stream received: $selectedStream");
    print("Options loaded: $options");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/gn_interest_bg.jpg', fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.6)),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "What area feels most familiar to you?",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black45,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      final interest = options[index];
                      final normalizedInterest = interest.toLowerCase().trim();

                      return Card(
                        color: Colors.black.withOpacity(0.6),
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          title: Text(
                            interest,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/courses',
                              arguments: normalizedInterest,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
