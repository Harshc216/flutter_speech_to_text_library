import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SimpleSpeechToTextWidget extends StatefulWidget {
  final void Function(String recognizedWords) onResult;
  final void Function(bool isListening)? onListeningStateChanged;
  final String placeholderText;
  final Color? glowColor;
  final Color? buttonColor;
  final Color? iconColor;
  final TextStyle? textStyle;
  final bool useScaffold;

  const SimpleSpeechToTextWidget({
    super.key,
    required this.onResult,
    this.onListeningStateChanged,
    this.placeholderText = 'Press the button and start speaking',
    this.glowColor,
    this.buttonColor,
    this.iconColor,
    this.textStyle,
    this.useScaffold = true,
  });

  @override
  State<SimpleSpeechToTextWidget> createState() => _SimpleSpeechToTextWidgetState();
}

class _SimpleSpeechToTextWidgetState extends State<SimpleSpeechToTextWidget> {
  final SpeechToText _speechToText = SpeechToText();
  bool _isListening = false;
  String _text = '';

  @override
  void initState() {
    super.initState();
    _text = widget.placeholderText;
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speechToText.initialize(
        onStatus: (val) => debugPrint('onStatus: $val'),
        onError: (val) => debugPrint('onError: $val'),
      );
      if (available) {
        setState(() {
          _isListening = true;
        });
        widget.onListeningStateChanged?.call(true);

        _speechToText.listen(
          onResult: (val) {
            setState(() {
              _text = val.recognizedWords;
            });
            widget.onResult(val.recognizedWords);
          },
        );
      }
    } else {
      setState(() {
        _isListening = false;
      });
      widget.onListeningStateChanged?.call(false);
      _speechToText.stop();
    }
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: SingleChildScrollView(
            reverse: true,
            child: Container(
              padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
              alignment: Alignment.center,
              child: Text(
                _text,
                style: widget.textStyle ??
                    TextStyle(
                      fontSize: 28.0,
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w400,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: AvatarGlow(
            animate: _isListening,
            glowColor: widget.glowColor ?? Theme.of(context).colorScheme.primary,
            duration: const Duration(milliseconds: 2000),
            repeat: true,
            child: FloatingActionButton(
              onPressed: _listen,
              backgroundColor: widget.buttonColor,
              child: Icon(
                _isListening ? Icons.mic : Icons.mic_none,
                color: widget.iconColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.useScaffold) {
      return Scaffold(
        body: SafeArea(
          child: _buildContent(context),
        ),
      );
    }
    return _buildContent(context);
  }
}
