// ignore_for_file: public_member_api_docs, sort_constructors_first

class MaterialModel {
  final String? id;
  final String? companyId;
  final String? employeeId;
  final String? name;
  final String? description;
  final int? stock;
  final int? used;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  MaterialModel({
    this.id = '',
    this.companyId,
    this.employeeId,
    this.name = '',
    this.description,
    this.stock,
    this.used,
    this.createdAt,
    this.updatedAt,
  });

  MaterialModel copyWith({
    String? id,
    String? companyId,
    String? employeeId,
    String? name,
    String? description,
    int? stock,
    int? used,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MaterialModel(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      employeeId: employeeId ?? this.employeeId,
      name: name ?? this.name,
      description: description ?? this.description,
      stock: stock ?? this.stock,
      used: used ?? this.used,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'companyId': companyId,
      'employeeId': employeeId,
      'name': name,
      'description': description,
      'stock': stock,
      'used': used,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory MaterialModel.fromMap(Map<dynamic, dynamic> map) {
    return MaterialModel(
      id: map['id'] != null ? map['id'] as String : null,
      companyId: map['companyId'] != null ? map['companyId'] as String : null,
      employeeId:
          map['employeeId'] != null ? map['employeeId'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      stock: map['stock'] != null ? map['stock'] as int : null,
      used: map['used'] != null ? map['used'] as int : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch((map['createdAt'] ?? 0) as int)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch((map['updatedAt'] ?? 0) as int)
          : null,
    );
  }

  @override
  String toString() {
    return 'MaterialModel(id: $id, companyId: $companyId, employeeId: $employeeId, name: $name, description: $description, stock: $stock, used: $used, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  MaterialModel fromMap(Map<String, dynamic> map) {
    return MaterialModel.fromMap(map);
  }
}
