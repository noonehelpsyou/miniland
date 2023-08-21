import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ClickableText extends StatelessWidget {
  final String textMessage;
  ClickableText({required this.textMessage});

  void _onLinkTap(String url) {
    // Handle link tap, e.g., launch the URL
    print('Tapped on URL: $url');
  }

  @override
  Widget build(BuildContext context) {
    final String text = textMessage;

    final List<TextSpan> textSpans = [];

    final RegExp urlRegex = RegExp(r'http(s)?://\S+');
    final Iterable<RegExpMatch> matches = urlRegex.allMatches(text);

    int currentIndex = 0;
    for (final match in matches) {
      final String linkText = match.group(0)!;
      final String plainText = text.substring(currentIndex, match.start);
      currentIndex = match.end;

      if (plainText.isNotEmpty) {
        textSpans.add(TextSpan(text: plainText));
      }

      textSpans.add(
        TextSpan(
          text: linkText,
          style: const TextStyle(
            color: Colors.red,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () => _onLinkTap(linkText),
        ),
      );
    }

    if (currentIndex < text.length) {
      textSpans.add(TextSpan(text: text.substring(currentIndex)));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text.rich(
        TextSpan(children: textSpans),
        textAlign: TextAlign.start, // Align text at the start
      ),
    );
  }
}
