// model/community_group.dart
class CommunityGroup {
  final String title;
  final String imagePath;
  final String members;
  final bool isJoined;

  CommunityGroup({
    required this.title,
    required this.imagePath,
    required this.members,
    this.isJoined = false,
  });

  CommunityGroup copyWith({bool? isJoined}) {
    return CommunityGroup(
      title: title,
      imagePath: imagePath,
      members: members,
      isJoined: isJoined ?? this.isJoined,
    );
  }
}
