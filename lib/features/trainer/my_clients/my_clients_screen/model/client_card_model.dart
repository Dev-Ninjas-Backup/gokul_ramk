class ClientCardModel {
  final String name;
  final String goal;
  final String nextSession;
  final String imageUrl;
  final String status;
  ClientCardModel({
    required this.name,
    required this.goal,
    required this.nextSession,
    required this.imageUrl,
    this.status = "",
  });
}
