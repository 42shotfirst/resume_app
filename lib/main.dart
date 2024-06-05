import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/services.dart';  // Required for rootBundle

void main() {
  runApp(const ResumeApp());
}

class ResumeApp extends StatelessWidget {
  const ResumeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: SingleChildScrollView( // Allow scrolling for long resumes
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align text left
                children: <Widget>[
                  const CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage('assets/MorganDF.jpeg.'),
                  ),
                  const Text(
                    'Morgan Reed',
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 40.0,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Tech Lead & Software Developer',
                    style: TextStyle(
                      fontFamily: 'SourceSansPro',
                      fontSize: 30.0,
                      color: Colors.teal.shade100,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  FutureBuilder<String>(
                    future: rootBundle.loadString('assets/MKRResume.html'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Text('Error loading HTML: ${snapshot.error}');
                        }
                        return Html(
                          data: snapshot.data,
                          style: {
                            '*': Style(
                              fontSize: const FontSize(16.0), // Set default font size
                            ),
                          },
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  // Add contact information or other sections here (optional)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
