import 'package:flutter/material.dart';

class CourseDetailPage extends StatelessWidget {
  final Map<String, dynamic> data;
  final String courseName;

  const CourseDetailPage({
    required this.data,
    required this.courseName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final roadmap = data['roadmap'];
    final headerStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
    final bulletStyle = TextStyle(fontSize: 16);

    Widget buildBulletList(List<dynamic>? items) {
      if (items == null || items.isEmpty) {
        return Text("Not available", style: bulletStyle);
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) {
          return Text("• $item", style: bulletStyle);
        }).toList(),
      );
    }

    Widget buildMilestones(List<dynamic>? milestones) {
      if (milestones == null || milestones.isEmpty) {
        return Text("Milestones not available.", style: bulletStyle);
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: milestones.map((milestone) {
          if (milestone is Map<String, dynamic>) {
            final stage = milestone['stage'] ?? 'Unknown stage';
            final duration = milestone['duration'] ?? 'Unknown duration';
            return Text("• $stage ($duration)", style: bulletStyle);
          }
          return SizedBox.shrink();
        }).toList(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(courseName),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("📘 Description:", style: headerStyle),
              Text(data['description'] ?? 'No description available.'),
              SizedBox(height: 16),

              Text("📚 Syllabus:", style: headerStyle),
              buildBulletList(data['syllabus']),
              SizedBox(height: 16),

              Text("🎯 Career Paths:", style: headerStyle),
              buildBulletList(data['career_paths']),
              SizedBox(height: 16),

              Text("🏫 Top Colleges:", style: headerStyle),
              buildBulletList(data['colleges']),
              SizedBox(height: 16),

              Text("📝 Prep Tips:", style: headerStyle),
              Text(data['prep_tips'] ?? 'No tips available.'),
              SizedBox(height: 24),

              if (roadmap != null) ...[
                Text(
                  "🛣 Career Roadmap:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 8),
                Text(
                  "Target Role: ${roadmap['career_path'] ?? 'Not specified'}",
                  style: bulletStyle,
                ),
                SizedBox(height: 8),

                Text("📍 Milestones:", style: headerStyle),
                buildMilestones(roadmap['milestones']),
                SizedBox(height: 16),

                Text("🧠 Required Skills:", style: headerStyle),
                buildBulletList(roadmap['required_skills']),
                SizedBox(height: 16),

                Text("📜 Certifications:", style: headerStyle),
                buildBulletList(roadmap['certifications']),
                SizedBox(height: 16),

                Text("📚 Learning Resources:", style: headerStyle),
                buildBulletList(roadmap['learning_resources']),
                SizedBox(height: 16),

                Text("📈 Market Outlook:", style: headerStyle),
                Text(
                  roadmap['market_outlook'] ?? 'Not available',
                  style: bulletStyle,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
