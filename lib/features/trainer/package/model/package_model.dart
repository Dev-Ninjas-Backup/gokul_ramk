class Package {
  final String? id;
  final String name;
  final String description;
  final double price;
  final int duration;
  final bool isActive;
  final List<String> programIds;
  final String? ownerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<PackageProgram>? programs;

  Package({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
    required this.isActive,
    required this.programIds,
    this.ownerId,
    this.createdAt,
    this.updatedAt,
    this.programs,
  });

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      id: json['id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : json['price'] as double,
      duration: json['duration'] as int,
      isActive: json['isActive'] as bool,
      programIds:
          (json['programIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      ownerId: json['ownerId'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      programs: (json['programs'] as List<dynamic>?)
          ?.map((e) => PackageProgram.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      'programIds': programIds,
      if (ownerId != null) 'ownerId': ownerId,
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
      if (programs != null)
        'programs': programs?.map((p) => p.toJson()).toList(),
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
