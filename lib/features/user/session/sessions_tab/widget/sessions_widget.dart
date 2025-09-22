import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/common/widgets/get_random_color.dart';

class SessionsWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final bool isBookmarked;
  final bool isOnlineSession;
  final VoidCallback? onTapBookMark;
  final VoidCallback? onTapButton;

  const SessionsWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    this.isBookmarked = false,
    this.isOnlineSession = false,
    this.onTapBookMark,
    this.onTapButton
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 220,
      margin: const EdgeInsets.only(bottom: 12),
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
                GestureDetector(
                  onTap: onTapBookMark,
                  child: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 36,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: getRandomDeepColor(),
                ),
                onPressed: onTapButton,
                child: Text(isOnlineSession ? 'Join Now' : 'View Details'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
