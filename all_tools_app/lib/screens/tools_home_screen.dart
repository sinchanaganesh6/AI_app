import 'package:flutter/material.dart';
import 'generate_image_screen.dart'; // Import the AI Image Generation screen

class ToolsHomeScreen extends StatelessWidget {
  const ToolsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF27374D),
      appBar: AppBar(
        title: const Text("AI Tools"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: _buildToolCard(context, 'AI Image Generation', 'assets/icons/ai_image.png', GenerateImageScreen()),
      ),
    );
  }

  // Single Tool Card Widget
  Widget _buildToolCard(BuildContext context, String title, String iconPath, Widget screen) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(iconPath, width: 80, height: 80),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
