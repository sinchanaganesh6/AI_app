import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:all_tools_app/screens/second_screen.dart';
import 'package:all_tools_app/utils/dialog.dart';

Future<void> convertTextToImage(String prompt, BuildContext context) async {
  const baseUrl = 'https://api.stability.ai';
  final url = Uri.parse('$baseUrl/v2beta/stable-image/generate/core');

  try {
    // Create multipart request
    var request = http.MultipartRequest("POST", url)
      ..headers["Authorization"] = "Bearer sk-DnoXJxk1l64QIv05iSOaKEBFKh3tfmXmXCVp8Fh5zpHgQ0Cu" // Replace with your key
      ..headers["Accept"] = "image/*" // Request image response
      ..fields["prompt"] = prompt
      ..fields["model"] = "stable-diffusion-xl-1024-v1-0"
      ..fields["aspect_ratio"] = "1:1"
      ..fields["output_format"] = "png"; // Ensure correct image format

    // Send request and handle binary response
    final response = await request.send();

    if (response.statusCode == 200) {
      final Uint8List imageData = await response.stream.toBytes(); // Get image bytes

      // Navigate to the second screen with the image
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondScreen(image: imageData),
        ),
      );
    } else {
      print("Stability AI Error: ${await response.stream.bytesToString()}");
      showErrorDialog('Failed to generate image', context);
    }
  } catch (e) {
    print("Error calling Stability AI API: $e");
    showErrorDialog("Error: $e", context);
  }
}
