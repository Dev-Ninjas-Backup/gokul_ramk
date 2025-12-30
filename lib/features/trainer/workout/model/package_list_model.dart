class PackageListItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final int duration;
  final bool isActive;
  final String ownerId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<PackageProgram> programs;

  PackageListItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
    required this.isActive,
    required this.ownerId,
    required this.createdAt,
    required this.updatedAt,
    required this.programs,
  });

  factory PackageListItem.fromJson(Map<String, dynamic> json) {
    return PackageListItem(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : json['price'] as double,
      duration: json['duration'] as int,
      isActive: json['isActive'] as bool,
      ownerId: json['ownerId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      programs:
          (json['programs'] as List<dynamic>?)
              ?.map((p) => PackageProgram.fromJson(p as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'duration': duration,
      'isActive': isActive,
      'ownerId': ownerId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'programs': programs.map((p) => p.toJson()).toList(),
    };
  }
}

class PackageProgram {
  final String id;
  final String packageId;
  final String programId;

  PackageProgram({
    required this.id,
    required this.packageId,
    required this.programId,
  });

  factory PackageProgram.fromJson(Map<String, dynamic> json) {
    return PackageProgram(
      id: json['id'] as String,
      packageId: json['packageId'] as String,
      programId: json['programId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'packageId': packageId, 'programId': programId};
  }
}
