import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ExpandableInlineText extends StatefulWidget {
  const ExpandableInlineText({
    super.key,
    required this.text,
    required this.expandLabel,
    required this.collapseLabel,
    this.collapsedMaxLines = 1,
    this.style,
    this.linkStyle,
    this.initiallyExpanded = false,
  });

  final String text;
  final String expandLabel;
  final String collapseLabel;
  final int collapsedMaxLines;
  final TextStyle? style;
  final TextStyle? linkStyle;
  final bool initiallyExpanded;

  @override
  State<ExpandableInlineText> createState() => _ExpandableInlineTextState();
}

class _ExpandableInlineTextState extends State<ExpandableInlineText> {
  late bool _isExpanded = widget.initiallyExpanded;
  late final TapGestureRecognizer _tapRecognizer;

  @override
  void initState() {
    super.initState();
    _tapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      };
  }

  @override
  void dispose() {
    _tapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseStyle = widget.style ?? DefaultTextStyle.of(context).style;
    final actionStyle =
        widget.linkStyle ??
        baseStyle.copyWith(
          fontWeight: FontWeight.w700,
          color: Theme.of(context).colorScheme.primary,
        );

    return LayoutBuilder(
      builder: (context, constraints) {
        final collapsedSpan = _collapsedTextSpan(
          text: widget.text,
          expandLabel: widget.expandLabel,
          style: baseStyle,
          linkStyle: actionStyle,
          maxWidth: constraints.maxWidth,
        );

        if (_isExpanded) {
          return Text.rich(
            TextSpan(
              style: baseStyle,
              children: [
                TextSpan(text: widget.text),
                const TextSpan(text: '  '),
                TextSpan(
                  text: widget.collapseLabel,
                  style: actionStyle,
                  recognizer: _tapRecognizer,
                ),
              ],
            ),
          );
        }

        if (collapsedSpan == null) {
          return Text(
            widget.text,
            maxLines: widget.collapsedMaxLines,
            overflow: TextOverflow.ellipsis,
            style: baseStyle,
          );
        }

        return Text.rich(collapsedSpan);
      },
    );
  }

  TextSpan? _collapsedTextSpan({
    required String text,
    required String expandLabel,
    required TextStyle style,
    required TextStyle linkStyle,
    required double maxWidth,
  }) {
    final fullPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: widget.collapsedMaxLines,
      textDirection: Directionality.of(context),
    )..layout(maxWidth: maxWidth);

    if (!fullPainter.didExceedMaxLines) {
      return null;
    }

    var low = 0;
    var high = text.length;
    var bestFit = '';

    while (low <= high) {
      final middle = (low + high) ~/ 2;
      final candidate = text.substring(0, middle).trimRight();
      final candidatePainter = TextPainter(
        text: TextSpan(
          style: style,
          children: [
            TextSpan(text: candidate),
            const TextSpan(text: '... '),
            TextSpan(text: expandLabel, style: linkStyle),
          ],
        ),
        maxLines: widget.collapsedMaxLines,
        textDirection: Directionality.of(context),
      )..layout(maxWidth: maxWidth);

      if (candidatePainter.didExceedMaxLines) {
        high = middle - 1;
      } else {
        bestFit = candidate;
        low = middle + 1;
      }
    }

    return TextSpan(
      style: style,
      children: [
        TextSpan(text: bestFit),
        const TextSpan(text: '... '),
        TextSpan(
          text: expandLabel,
          style: linkStyle,
          recognizer: _tapRecognizer,
        ),
      ],
    );
  }
}
