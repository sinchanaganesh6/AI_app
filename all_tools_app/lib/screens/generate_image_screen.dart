import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '/api/rest.dart';

class GenerateImageScreen extends StatefulWidget {
  const GenerateImageScreen({super.key});

  @override
  State<GenerateImageScreen> createState() => _GenerateImageScreenState();
}

class _GenerateImageScreenState extends State<GenerateImageScreen>
    with SingleTickerProviderStateMixin {
  final textController = TextEditingController();
  bool isLoading = false;
  late AnimationController _animationController;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _generateImage() {
    setState(() => isLoading = true);
    convertTextToImage(textController.text, context).then((_) {
      setState(() => isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF27374D),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
                TextField(
                  controller: textController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Enter your prompt',
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: const EdgeInsets.all(16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelStyle: const TextStyle(color: Colors.red),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
            SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XFF9DB2BF),
                    ),
                    onPressed: () {
                      convertTextToImage(textController.text, context);
                      isLoading = true;

                      setState(() {});
                    },
                    child: isLoading
                        ? const SizedBox(
                            height: 15,
                            width: 15,
                            child:
                                CircularProgressIndicator(color: Colors.black))
                        : const Text('Generate Image',
                            style: TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
          ],
        ),
      ),
    );
  }
}
