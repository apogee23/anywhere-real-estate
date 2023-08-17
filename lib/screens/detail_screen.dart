import 'package:flutter/material.dart';
import 'package:realogy/models/models.dart';
import 'package:realogy/widgets/details.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    Key? key,
    required this.relatedTopic,
  }) : super(key: key);

  final RelatedTopicModel relatedTopic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(relatedTopic.text.split(" - ")[0]),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Detail(
            relatedTopic: relatedTopic,
          ),
        ),
      ),
    );
  }
}
