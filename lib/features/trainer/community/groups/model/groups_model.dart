class GroupModel {
  final String id;
  final String name;
  final String description;
  final String thumbnail;
  final String createdBy;
  final String createdAt;
  final String updatedAt;
  final List<GroupMember> members;
  final int memberCount;

  GroupModel({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.members,
    required this.memberCount,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    final membersList = json['members'] as List<dynamic>? ?? [];
    final members = membersList
        .whereType<Map<String, dynamic>>()
        .map((m) => GroupMember.fromJson(m))
        .toList();

    final count = json['_count']?['members'] as int? ?? members.length;

    return GroupModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      createdBy: json['createdBy'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      members: members,
      memberCount: count,
    );
  }

  GroupModel copyWith({
    bool? isJoined,
    List<GroupMember>? members,
    int? memberCount,
  }) {
    return GroupModel(
      id: id,
      name: name,
      description: description,
      thumbnail: thumbnail,
      createdBy: createdBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
      members: members ?? this.members,
      memberCount: memberCount ?? this.memberCount,
    );
  }

  bool get isJoined => members.any((m) => m.id == _currentUserId);

  static String? _currentUserId;

  static void setCurrentUserId(String userId) {
    _currentUserId = userId;
  }
}

class GroupMember {
  final String id;
  final String fullname;
  final String email;
  final String? phone;

  GroupMember({
    required this.id,
    required this.fullname,
    required this.email,
    this.phone,
  });

  factory GroupMember.fromJson(Map<String, dynamic> json) {
    return GroupMember(
      id: json['id'] ?? '',
      fullname: json['fullname'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
    );
  }
}
