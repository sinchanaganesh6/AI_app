import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

const String strapiBaseUrl = "http://10.0.2.2:1337/api"; // For Android Emulator
const String uploadUrl = "$strapiBaseUrl/upload";
const String imagesUrl = "$strapiBaseUrl/images";

// ✅ **Step 1: Upload Image to Strapi**
Future<String?> uploadImageToStrapi(Uint8List imageData) async {
  try {
    var request = http.MultipartRequest("POST", Uri.parse(uploadUrl))
      ..files.add(
        http.MultipartFile.fromBytes(
          "files",
          imageData,
          filename: "generated_image.png",
        ),
      );

    final response = await request.send();
    final responseData = await response.stream.bytesToString();
    print("Upload Response: $responseData"); // Debugging

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(responseData);
      
      if (data.isNotEmpty && data[0].containsKey("url")) {
        String imageUrl = "http://localhost:1337${data[0]['url']}";
        return imageUrl; // ✅ Return the correct image URL
      } else {
        print("❌ Invalid Upload Response: $responseData");
        return null;
      }
    } else {
      print("❌ Strapi Upload Error: $responseData");
      return null;
    }
  } catch (e) {
    print("❌ Error Uploading Image to Strapi: $e");
    return null;
  }
}

// ✅ **Step 2: Save Image Metadata (Prompt + Image URL)**
Future<bool> saveImageMetadataToStrapi(String prompt, String imageUrl) async {
  try {
    final response = await http.post(
      Uri.parse(imagesUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "data": {
          "prompt": prompt,
          "image_url": imageUrl,
        }
      }),
    );

    print("Metadata Response: ${response.body}"); // Debugging

    return response.statusCode == 200 || response.statusCode == 201;
  } catch (e) {
    print("❌ Error Saving Metadata to Strapi: $e");
    return false;
  }
}

Future<List<String>> fetchImagesFromStrapi() async {
  try {
    final response = await http.get(Uri.parse("$strapiBaseUrl/images"));
    print("🔍 Full Strapi Response: ${response.body}");

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      if (decodedData == null || !decodedData.containsKey('data') || decodedData['data'] == null) {
        print("❌ API response missing 'data' field or returned null");
        return [];
      }

      final List<dynamic> items = decodedData['data'];
      List<String> imageUrls = [];

      for (var item in items) {
        final attributes = item;
        String imgUrl = attributes.containsKey('image_url') ? attributes['image_url'] : "";

        print("🖼️ Image URL Before Fix: $imgUrl");

        if (imgUrl == null || imgUrl.trim().isEmpty) {
          print("❌ Skipping invalid image URL: Empty or null");
          continue;
        }

        // Fix Localhost URLs for Emulator
        if (imgUrl.contains("localhost")) {
          imgUrl = imgUrl.replaceAll("localhost", "10.0.2.2");
        }

        // Ensure URLs are correctly formatted
        if (!imgUrl.startsWith("http")) {
          imgUrl = "http://10.0.2.2:1337" + imgUrl;
        }

        print("✅ Final Image URL: $imgUrl");
        imageUrls.add(imgUrl);
      }

      return imageUrls;
    } else {
      print("❌ Strapi Fetch Error: ${response.body}");
      return [];
    }
  } catch (e) {
    print("❌ Error Fetching Images from Strapi: $e");
    return [];
  }
}




