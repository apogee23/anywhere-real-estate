import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realogy/flavors.dart';
import 'package:realogy/models/models.dart';
import 'package:realogy/providers/providers.dart';
import 'package:realogy/screens/detail_screen.dart';
import 'package:realogy/utils/show_common_modal_bottom_sheet.dart';
import 'package:realogy/widgets/details.dart';
import 'package:searchable_listview/searchable_listview.dart';

class ListScreen extends ConsumerStatefulWidget {
  const ListScreen({
    super.key,
  });

  @override
  ConsumerState<ListScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<ListScreen> {
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    ref.read(dataProvider).getData();
  }

  @override
  Widget build(BuildContext context) {
    var dataState = ref.watch(dataProvider);

    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(F.title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 12,
          left: 12,
          right: 12,
        ),
        child: SearchableList<RelatedTopicModel>(
          initialList: dataState.data?.relatedTopics ?? [],
          builder: (int index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: isTablet
                  ? null
                  : Text(
                      dataState.data?.relatedTopics[index].text
                              .split(" - ")[0] ??
                          "",
                    ),
              onTap: () => isTablet
                  ? showCommonModalBottomSheet(
                      context: context,
                      child: Detail(
                        relatedTopic: dataState.data!.relatedTopics[index],
                      ),
                    )
                  : Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(
                          relatedTopic: dataState.data!.relatedTopics[index],
                        ),
                      ),
                    ),
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
          filter: (value) => (dataState.data?.relatedTopics ?? [])
              .where(
                (relatedTopic) => relatedTopic.text.toLowerCase().contains(
                      value.toLowerCase(),
                    ),
              )
              .toList(),
          emptyWidget: const Text("No results found"),
          inputDecoration: InputDecoration(
            labelText: "Search for a topic",
            fillColor: Colors.white,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreenContainer extends ConsumerStatefulWidget {
  const HomeScreenContainer({
    super.key,
  });

  @override
  ConsumerState<HomeScreenContainer> createState() =>
      _HomeScreenContainerState();
}

class _HomeScreenContainerState extends ConsumerState<HomeScreenContainer> {
  @override
  void initState() {
    ref.read(dataProvider).getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dataState = ref.watch(dataProvider);

    return dataState.data == null
        ? Center(
            child: Image.network(
              'https://i.imgur.com/nqBnLLE.gif',
              height: 200,
              width: 200,
            ),
          )
        : const ListScreen();
  }
}
