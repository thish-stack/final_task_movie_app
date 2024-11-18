import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/media.dart';
import '../providers/media_provider.dart';
import '../widgets/media_item.dart';
import '../widgets/search_bar.dart' as custom;


final filteredMediaProvider = StateProvider<List<Media>>((ref) => []);

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaAsyncValue = ref.watch(mediaProvider);
    final filteredMedia = ref.watch(filteredMediaProvider);

    return WillPopScope(
      onWillPop: () async {
      
        if (_searchController.text.isNotEmpty) {          
          setState(() {
            _searchController.clear();
            ref.read(filteredMediaProvider.notifier).state = [];
          });
          return false; 
        }
        return true; 
      },
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          title: const Text('Movies'),
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite),
              color: Colors.red,
              onPressed: () {
                Navigator.pushNamed(context, '/favorites');
              },
            ),
          ],
        ),
        body: Column(
          children: [
            custom.SearchBar(
              controller: _searchController,
              onSearch: (query) {
                final mediaList = ref.read(mediaProvider).value ?? [];
                final filtered = mediaList
                    .where((media) => media.title.toLowerCase().contains(query.toLowerCase()))
                    .toList();
                ref.read(filteredMediaProvider.notifier).state = filtered;  
              },
            ),
            Expanded(
              child: mediaAsyncValue.when(
                data: (mediaList) {
                  final displayList = filteredMedia.isEmpty ? mediaList : filteredMedia;
                  return GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: displayList.length,
                    itemBuilder: (context, index) =>
                        MediaItem(media: displayList[index]),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Center(child: Text('Error: $err')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
