import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ExpandableSelectableText extends StatefulWidget {
  const ExpandableSelectableText({
    super.key,
    required this.text,
    required this.expandLabel,
    this.collapsedMaxLines = 3,
    this.style,
    this.linkStyle,
  });

  final String text;
  final String expandLabel;
  final int collapsedMaxLines;
  final TextStyle? style;
  final TextStyle? linkStyle;

  @override
  State<ExpandableSelectableText> createState() =>
      _ExpandableSelectableTextState();
}

class _ExpandableSelectableTextState extends State<ExpandableSelectableText> {
  late final TapGestureRecognizer _tapRecognizer;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _tapRecognizer = TapGestureRecognizer()..onTap = _expand;
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
        final collapsedSpan = _buildCollapsedSpan(
          text: widget.text,
          expandLabel: widget.expandLabel,
          style: baseStyle,
          linkStyle: actionStyle,
          maxWidth: constraints.maxWidth,
        );

        if (_isExpanded || collapsedSpan == null) {
          return SelectableText(widget.text, style: baseStyle);
        }

        return SelectableText.rich(
          collapsedSpan,
          maxLines: widget.collapsedMaxLines,
        );
      },
    );
  }

  TextSpan? _buildCollapsedSpan({
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
            const TextSpan(text: ' '),
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
        TextSpan(text: bestFit.trimRight()),
        const TextSpan(text: ' '),
        TextSpan(
          text: expandLabel,
          style: linkStyle,
          recognizer: _tapRecognizer,
        ),
      ],
    );
  }

  void _expand() {
    setState(() {
      _isExpanded = true;
    });
  }
}
