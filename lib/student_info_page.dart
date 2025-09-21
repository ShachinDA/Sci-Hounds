import 'package:flutter/material.dart';

class StudentInfoPage extends StatefulWidget {
  @override
  _StudentInfoPageState createState() => _StudentInfoPageState();
}

class _StudentInfoPageState extends State<StudentInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();

  String? status;
  String? stream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/profile_bg.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(color: Colors.black.withOpacity(0.6)),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      "Start Your Journey",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 30),

                    // Name Field
                    TextFormField(
                      controller: nameController,
                      style: TextStyle(color: Colors.white),
                      decoration: _inputDecoration("Name"),
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                          ? 'Please enter your name'
                          : null,
                    ),
                    SizedBox(height: 15),

                    // Age Field
                    TextFormField(
                      controller: ageController,
                      style: TextStyle(color: Colors.white),
                      decoration: _inputDecoration("Age"),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                          ? 'Please enter your age'
                          : null,
                    ),
                    SizedBox(height: 15),

                    // Status Dropdown
                    DropdownButtonFormField<String>(
                      value: status,
                      hint: Text(
                        "Select your status",
                        style: TextStyle(color: Colors.white70),
                      ),
                      style: TextStyle(color: Colors.white),
                      dropdownColor: Colors.black87,
                      decoration: _inputDecoration("Status"),
                      items: ['12th', 'Graduated']
                          .map(
                            (s) => DropdownMenuItem(
                              value: s,
                              child: Text(
                                s,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (val) => setState(() => status = val),
                      validator: (value) =>
                          value == null ? 'Please select your status' : null,
                    ),
                    SizedBox(height: 15),

                    // Stream Dropdown
                    DropdownButtonFormField<String>(
                      value: stream,
                      hint: Text(
                        "Select your preferred stream",
                        style: TextStyle(color: Colors.white70),
                      ),
                      style: TextStyle(color: Colors.white),
                      dropdownColor: Colors.black87,
                      decoration: _inputDecoration("Preferred Stream"),
                      items: ['Engineering', 'Medical', 'Business']
                          .map(
                            (s) => DropdownMenuItem(
                              value: s,
                              child: Text(
                                s,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (val) => setState(() => stream = val),
                      validator: (value) =>
                          value == null ? 'Please select your stream' : null,
                    ),
                    SizedBox(height: 30),

                    // Next Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.tealAccent[700],
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text("Next", style: TextStyle(fontSize: 18)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final normalizedStream = stream!.trim().toLowerCase();
                          print(
                            'Passing stream: $normalizedStream',
                          ); // ✅ Debug print
                          Navigator.pushNamed(
                            context,
                            '/interests',
                            arguments: normalizedStream,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white70),
      filled: true,
      fillColor: Colors.white12,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
