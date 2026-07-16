import 'package:flutter/material.dart';
import 'package:flutter_speech_to_text_library/flutter_speech_to_text_library.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speech to Text Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Voice Recognizer'),
          centerTitle: true,
          elevation: 2,
        ),
        body: SimpleSpeechToTextWidget(
          useScaffold: false,
          placeholderText: 'Tap the mic and speak to transcribe...',
          glowColor: Colors.purpleAccent,
          buttonColor: Colors.purple,
          iconColor: Colors.white,
          textStyle: const TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
            fontStyle: FontStyle.italic,
          ),
          onResult: (words) {
            debugPrint('Recognized speech: $words');
          },
          onListeningStateChanged: (isListening) {
            debugPrint('Is recording: $isListening');
          },
        ),
      ),
    );
  }
}
