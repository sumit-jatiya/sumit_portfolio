import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? iconData;
  final String? imageUrl;
  final VoidCallback? onTap;
  final double borderRadius;
  final double elevation;
  final double width;
  final double iconSize;

  const SectionCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.iconData,
    this.imageUrl,
    this.onTap,
    this.borderRadius = 16,
    this.elevation = 4,
    this.width = 180,
    this.iconSize = 50, required bool isLarge,
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
              // -------- Icon or Image --------
              if (iconData != null)
                Container(
                  height: iconSize,
                  width: iconSize,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    iconData,
                    size: iconSize * 0.56, // 28 by default
                    color: Theme.of(context).primaryColor,
                  ),
                )
              else if (imageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: Image.network(
                    imageUrl!,
                    height: iconSize,
                    width: iconSize,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return SizedBox(
                        height: iconSize,
                        width: iconSize,
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2.5),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: iconSize,
                        width: iconSize,
                        color: Colors.grey.shade200,
                        child: const Center(
                          child: Icon(
                            Icons.broken_image,
                            color: Colors.grey,
                            size: 28,
                          ),
                        ),
                      );
                    },
                  ),
                ),

              const SizedBox(height: 12),

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

              // -------- Subtitle --------
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
