import 'package:flutter/material.dart';

class LocationMap extends StatelessWidget {
  final double latitude;
  final double longitude;
  final int zoom;

  const LocationMap({
    super.key,
    this.latitude = -120.2655,
    this.longitude = 136.3468,
    this.zoom = 4,
  });

  @override
  Widget build(BuildContext context) {
    final String osmUrl =
        'https://static-maps.yandex.ru/1.x/?ll=$longitude,$latitude&size=600,300&z=$zoom&l=map&pt=$longitude,$latitude,pm2rdm';

    return SizedBox(
      height: 240,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          osmUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              child: Center(
                child: Icon(Icons.map_outlined, size: 40, color: Colors.grey),
              ),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
