
class UserCommunityGroup {
  final String title;
  final String imagePath;
  final String members;
  final bool isJoined;

  UserCommunityGroup({
    required this.title,
    required this.imagePath,
    required this.members,
    this.isJoined = false,
  });

  UserCommunityGroup copyWith({bool? isJoined}) {
    return UserCommunityGroup(
      title: title,
      imagePath: imagePath,
      members: members,
      isJoined: isJoined ?? this.isJoined,
    );
  }
}
