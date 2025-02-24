import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../api/strapi_service.dart';
import 'third_screen.dart';

class SecondScreen extends StatefulWidget {
  final Uint8List image;
  const SecondScreen({super.key, required this.image});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  bool isUploading = false;

  Future<void> _uploadImage() async {
    setState(() => isUploading = true);

    // ✅ Upload the image first
    String? imageUrl = await uploadImageToStrapi(widget.image);

    if (imageUrl != null) {
      // ✅ Save the metadata in Strapi
      bool success = await saveImageMetadataToStrapi("Generated Image", imageUrl);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("✅ Image uploaded successfully!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("❌ Failed to save metadata.")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Failed to upload image.")),
      );
    }

    setState(() => isUploading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF27374D),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            width: 340,
            height: 500,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(25),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.memory(
                widget.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RoundedContainerWithIcon(icon: Icons.home),
              RoundedContainerWithIcon(icon: Icons.save_alt_outlined),
              RoundedContainerWithIcon(icon: Icons.share),
              ],
          ),

          const SizedBox(height: 20),

          // ✅ Upload Button
          ElevatedButton.icon(
            onPressed: isUploading ? null : _uploadImage,
            icon: isUploading
                ? CircularProgressIndicator(color: Colors.white)
                : Icon(Icons.upload),
            label: Text(isUploading ? "Uploading..." : "Upload to Strapi"),
          ),

          // ✅ Display All Images Button
          ElevatedButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ThirdScreen()),
            ),
            icon: Icon(Icons.image),
            label: Text("Show All Images"),
          ),
        ]),
      ),
    );
  }
}
class RoundedContainerWithIcon extends StatelessWidget {
  final IconData icon;

  const RoundedContainerWithIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0XFF9DB2BF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Icon(
          icon,
          size: 30,
          color: Colors.black, // Change the icon color as needed
        ),
      ),
    );
  }
}