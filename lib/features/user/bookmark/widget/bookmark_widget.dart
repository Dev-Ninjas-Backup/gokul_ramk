import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';

class BookmarkWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final bool isBookmarked;

  const BookmarkWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    this.isBookmarked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withValues(alpha: 0.3),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: getTextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: getTextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
