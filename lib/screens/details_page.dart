import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/media.dart';
import '../widgets/favorite_button.dart';

class DetailsPage extends StatelessWidget {
  final Media media;

  const DetailsPage({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          media.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              media.bigImage,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 300,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          media.title,
                          style: Theme.of(context).textTheme.titleLarge,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      FavoriteButton(media: media),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Rating: ${media.rating}',
                      style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 8),
                  Text('Genre: ${media.genre.join(', ')}',
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 8),
                  Text('Year: ${media.year}',
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 16),
                  Text(media.description,
                      style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.amber, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 32),
                    ),
                    onPressed: () async {
                      if (!await launchUrl(Uri.parse(media.imdbLink))) {
                        throw Exception('Could not launch URL');
                      }
                    },
                    child: const Text('View on IMDb'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
