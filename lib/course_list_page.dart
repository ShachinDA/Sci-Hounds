import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'CourseDetailPage.dart'; // ✅ Ensure this file exists

class CourseListPage extends StatefulWidget {
  @override
  _CourseListPageState createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  List<Map<String, dynamic>> courses = [];
  bool isLoading = true;
  String selectedInterest = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as String?;
    selectedInterest = args?.trim().toLowerCase() ?? '';
    fetchCourses(selectedInterest);
  }

  Future<void> fetchCourses(String interest) async {
    final uri = Uri.parse(
      'http://192.168.31.206:5000/courses?interest=${Uri.encodeComponent(interest)}',
    );

    try {
      final response = await http.get(uri);
      final data = json.decode(response.body);

      if (response.statusCode == 200 && data is List) {
        setState(() {
          courses = List<Map<String, dynamic>>.from(data);
          isLoading = false;
        });
      } else if (data is Map && data.containsKey('error')) {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['error'] ?? "No courses found.")),
        );
      } else {
        throw Exception("Unexpected response format");
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load courses. Please try again.")),
      );
    }
  }

  Future<void> fetchCourseDetails(
    BuildContext context,
    String courseName,
  ) async {
    final normalizedName = courseName.trim().toLowerCase();
    final uri = Uri.parse(
      'http://192.168.31.206:5000/course-details?name=${Uri.encodeComponent(normalizedName)}',
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(child: CircularProgressIndicator()),
    );

    try {
      final response = await http.get(uri);
      Navigator.pop(context); // Close spinner

      final data = json.decode(response.body);

      if (data.containsKey('error')) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Course not found in backend.")));
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CourseDetailPage(data: data, courseName: courseName),
        ),
      );
    } catch (e) {
      Navigator.pop(context); // Close spinner
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Could not connect to backend. Please try again."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/description_bg.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(color: Colors.black.withOpacity(0.6)),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "Courses that match your interest",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: isLoading
                      ? Center(child: CircularProgressIndicator())
                      : courses.isEmpty
                      ? Center(
                          child: Text(
                            "We couldn’t find any courses for \"$selectedInterest\".\nTry selecting a different area.",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ListView.builder(
                          itemCount: courses.length,
                          itemBuilder: (context, index) {
                            final course = courses[index];
                            return Card(
                              color: Colors.black.withOpacity(0.6),
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                title: Text(
                                  course['name'] ?? '',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  course['description'] ?? '',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                onTap: () => fetchCourseDetails(
                                  context,
                                  course['name'] ?? '',
                                ),
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
