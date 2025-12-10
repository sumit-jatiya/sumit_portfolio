import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String description;
  final String? imageUrl;
  final VoidCallback? onTap;
  final double borderRadius;
  final double elevation;
  final double width;
  final double imageHeight;

  const CustomCard({
    super.key,
    required this.title,
    required this.description,
    this.imageUrl,
    this.onTap,
    this.borderRadius = 16,
    this.elevation = 4,
    this.width = 200,
    this.imageHeight = 120,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius),
      splashColor: Theme.of(context).primaryColor.withOpacity(0.2),
      child: Card(
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        shadowColor: Colors.black26,
        child: Container(
          width: width,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -------- Image / Thumbnail --------
              if (imageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: Image.network(
                    imageUrl!,
                    height: imageHeight,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return SizedBox(
                        height: imageHeight,
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2.5),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: imageHeight,
                        color: Colors.grey.shade200,
                        child: const Center(
                          child: Icon(
                            Icons.broken_image,
                            color: Colors.grey,
                            size: 40,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              if (imageUrl != null) const SizedBox(height: 12),

              // -------- Title --------
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 6),

              // -------- Description --------
              Text(
                description,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
