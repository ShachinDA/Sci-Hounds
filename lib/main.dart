import 'package:flutter/material.dart';
import 'start_page.dart';
import 'student_info_page.dart';
import 'interest_selection_page.dart';
import 'course_list_page.dart';
import 'CourseDetailPage.dart';

void main() => runApp(CareerApp());

class CareerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Career Guidance',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => StartPage());

          case '/details':
            return MaterialPageRoute(builder: (_) => StudentInfoPage());

          case '/interests':
            final stream = settings.arguments as String? ?? 'engineering';
            return MaterialPageRoute(
              builder: (_) => InterestSelectionPage(stream: stream),
            );

          case '/courses':
            return MaterialPageRoute(
              builder: (_) => CourseListPage(),
              settings: RouteSettings(arguments: settings.arguments),
            );

          case '/course-detail':
            final args = settings.arguments as Map<String, dynamic>? ?? {};
            final data = args['data'] ?? {};
            final courseName = args['courseName'] ?? '';
            return MaterialPageRoute(
              builder: (_) =>
                  CourseDetailPage(data: data, courseName: courseName),
            );

          default:
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Center(
                  child: Text("Page not found", style: TextStyle(fontSize: 18)),
                ),
              ),
            );
        }
      },
    );
  }
}
