class PackageDetails {
  final String id;
  final String name;
  final String description;
  final double price;
  final int duration;
  final bool isActive;
  final String ownerId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PackageOwner owner;
  final List<PackageProgramItem> programs;

  PackageDetails({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
    required this.isActive,
    required this.ownerId,
    required this.createdAt,
    required this.updatedAt,
    required this.owner,
    required this.programs,
  });

  factory PackageDetails.fromJson(Map<String, dynamic> json) {
    return PackageDetails(
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
      owner: PackageOwner.fromJson(json['owner'] as Map<String, dynamic>),
      programs:
          (json['programs'] as List<dynamic>?)
              ?.map(
                (e) => PackageProgramItem.fromJson(e as Map<String, dynamic>),
              )
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
      'owner': owner.toJson(),
      'programs': programs.map((p) => p.toJson()).toList(),
    };
  }
}

class PackageOwner {
  final String id;
  final String fullname;
  final String email;

  PackageOwner({required this.id, required this.fullname, required this.email});

  factory PackageOwner.fromJson(Map<String, dynamic> json) {
    return PackageOwner(
      id: json['id'] as String,
      fullname: json['fullname'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'fullname': fullname, 'email': email};
  }
}

class PackageProgramItem {
  final PackageProgramData program;

  PackageProgramItem({required this.program});

  factory PackageProgramItem.fromJson(Map<String, dynamic> json) {
    return PackageProgramItem(
      program: PackageProgramData.fromJson(
        json['program'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {'program': program.toJson()};
  }
}

class PackageProgramData {
  final String name;

  PackageProgramData({required this.name});

  factory PackageProgramData.fromJson(Map<String, dynamic> json) {
    return PackageProgramData(name: json['name'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}
