import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/media.dart';
import '../services/api_service.dart';

final mediaProvider = FutureProvider<List<Media>>((ref) async {
  final apiService = ApiService();
  return await apiService.fetchMedia();
});

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Media>>((ref) {
  return FavoritesNotifier();
});

final filteredMediaProvider = StateProvider<List<Media>>((ref) => []);

class FavoritesNotifier extends StateNotifier<List<Media>> {
  FavoritesNotifier() : super([]);

  void toggleFavorite(Media media) {
    if (state.contains(media)) {
      state = state.where((item) => item.id != media.id).toList();
    } else {
      state = [...state, media];
    }
  }
}
