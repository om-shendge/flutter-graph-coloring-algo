import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../input/input_page.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _proceed() {
    final count = int.tryParse(_controller.text);
    if (count != null && count > 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => InputPage(vertexCount: count)),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(height: 100),
                Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: const TextSpan(
                          text: 'Graph coloring algorithm\nVisualization.',
                          style: TextStyle(
                            fontFamily: AppConstants.fontFamily,
                            fontSize: 60,
                            color: Colors.white,
                          ),
                          children: [
                            TextSpan(
                              text: '\nCoded in Dart.',
                              style: TextStyle(
                                fontFamily: AppConstants.fontFamily,
                                fontSize: 40,
                                color: Colors.white54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'To proceed enter number of vertices (preferably single digit number >0).\n'
                        'App uses adjacency matrix representation to solve vertex coloring problem '
                        'using Recursive Backtracking and Greedy approach.',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.cyanAccent.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 100),
                Column(
                  children: [
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: _controller,
                        autofocus: true,
                        cursorColor: Colors.redAccent,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: 'Enter number of vertices',
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: AppConstants.fontFamily,
                          ),
                          hintStyle: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xffFC4A71),
                      ),
                      onPressed: _proceed,
                      child: const Text(
                        'Proceed',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}

