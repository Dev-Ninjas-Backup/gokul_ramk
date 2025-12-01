// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';

class WorkoutCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final String difficulty;
  final bool isBookmarked;
  final bool? large;
  final VoidCallback? onBookmarkTap;

  const WorkoutCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.difficulty,
    this.isBookmarked = false,
    this.large = false,
    this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: large! ? double.maxFinite : 180,
      height: 170,
      margin: large! ? null : const EdgeInsets.only(right: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/yogaGroup.png',
                  fit: BoxFit.cover,
                );
              },
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.6),
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
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
                              "$subtitle mins | $difficulty",
                              style: getTextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: onBookmarkTap,
                        child: Icon(
                          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          color: isBookmarked?Colors.blue :Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
