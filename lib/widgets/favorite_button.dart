//favorite_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/media.dart';
import '../providers/media_provider.dart';

class FavoriteButton extends ConsumerWidget {
  final Media media;

  const FavoriteButton({super.key, required this.media});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final isFavorite = favorites.contains(media);

    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : Colors.grey,
      ),
      onPressed: () {
        ref.read(favoritesProvider.notifier).toggleFavorite(media);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Added to Favorites')),
        );
      },
    );
  }
}
