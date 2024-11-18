import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/media.dart';
import '../screens/details_page.dart'; 

class MediaItem extends StatelessWidget {
  final Media media;

  const MediaItem({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsPage(media: media)),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display image
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: media.image,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          const SizedBox(height: 5),
          // Display title 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              media.title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}


