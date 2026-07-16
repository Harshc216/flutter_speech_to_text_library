# flutter_speech_to_text_library_example

A premium, interactive voice recognizer application demonstrating the features of `flutter_speech_to_text_library`.

## Getting Started

This example app demonstrates:
1. Embedding the `SimpleSpeechToTextWidget` directly into a custom Scaffold layout.
2. Handling real-time speech transcription results using the `onResult` callback.
3. Reacting to voice activation/listening state updates with `onListeningStateChanged`.
4. Customizing the colors (button, icons, glow) and text style of the widget to match the app theme.

## Code Example

```dart
SimpleSpeechToTextWidget(
  useScaffold: false,
  placeholderText: 'Tap the mic and speak to transcribe...',
  glowColor: Colors.purpleAccent,
  buttonColor: Colors.purple,
  iconColor: Colors.white,
  textStyle: const TextStyle(
    fontSize: 26.0,
    fontWeight: FontWeight.w500,
    color: Colors.white70,
    fontStyle: FontStyle.italic,
  ),
  onResult: (words) {
    debugPrint('Recognized speech: $words');
  },
  onListeningStateChanged: (isListening) {
    debugPrint('Is recording: $isListening');
  },
)
```

Refer to the main [README.md](../README.md) for detailed guidelines on the package configuration, features, and full API options.
