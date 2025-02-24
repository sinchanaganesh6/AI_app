import 'package:flutter/material.dart';
import '../api/strapi_service.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  late Future<List<String>> imageUrlsFuture;

  @override
  void initState() {
    super.initState();
    imageUrlsFuture = fetchImagesFromStrapi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Generated Images")),
      body: FutureBuilder<List<String>>(
        future: imageUrlsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No images found."));
          }

          List<String> imageUrls = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              print("✅ Displaying Image: ${imageUrls[index]}");

              return ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  "${imageUrls[index]}?timestamp=${DateTime.now().millisecondsSinceEpoch}",
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Icon(Icons.broken_image, size: 50));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
