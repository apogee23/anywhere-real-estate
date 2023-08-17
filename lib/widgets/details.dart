import 'package:flutter/material.dart';
import 'package:realogy/models/models.dart';

class Detail extends StatelessWidget {
  const Detail({
    Key? key,
    required this.relatedTopic,
  }) : super(key: key);

  final RelatedTopicModel relatedTopic;

  @override
  Widget build(BuildContext context) {
    var textPieces = relatedTopic.text.split(" - ");
    var name = textPieces.isNotEmpty ? textPieces[0] : null;
    var description = textPieces.length > 1 ? textPieces[1] : null;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Image.network(
            relatedTopic.icon.url != ""
                ? "https://duckduckgo.com/${relatedTopic.icon.url}"
                : "https://picsum.photos/200",
            width: double.tryParse(relatedTopic.icon.width) ?? 200,
            height: double.tryParse(relatedTopic.icon.height) ?? 200,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          name ?? "[Missing Name]",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Text(description ?? "[Missing Description]"),
      ],
    );
  }
}
