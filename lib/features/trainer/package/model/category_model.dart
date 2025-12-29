class CategoryResponse {
  bool? success;
  String? message;
  CategoryData? data;

  CategoryResponse({this.success, this.message, this.data});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? CategoryData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CategoryData {
  List<CategoryItem>? data;
  int? totalCount;
  int? page;
  int? pageSize;
  int? totalPages;

  CategoryData({
    this.data,
    this.totalCount,
    this.page,
    this.pageSize,
    this.totalPages,
  });

  CategoryData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CategoryItem>[];
      json['data'].forEach((v) {
        data!.add(CategoryItem.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    page = json['page'];
    pageSize = json['pageSize'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = totalCount;
    data['page'] = page;
    data['pageSize'] = pageSize;
    data['totalPages'] = totalPages;
    return data;
  }
}

class CategoryItem {
  String? id;
  String? name;
  String? type;
  String? color;
  String? desc;
  String? createdAt;
  String? updatedAt;
  String? userId;

  CategoryItem({
    this.id,
    this.name,
    this.type,
    this.color,
    this.desc,
    this.createdAt,
    this.updatedAt,
    this.userId,
  });

  CategoryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    color = json['color'];
    desc = json['desc'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['color'] = color;
    data['desc'] = desc;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['userId'] = userId;
    return data;
  }
}
