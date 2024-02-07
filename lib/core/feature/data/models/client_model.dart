// ignore_for_file: public_member_api_docs, sort_constructors_first

class ClientModel {
  final String? id;
  final String? name;
  final String? phone;
  final bool? isDeleted;
  final DateTime? createdAt;

  ClientModel({
    this.id = '',
    this.name = '',
    this.phone,
    this.isDeleted,
    this.createdAt,
  });

  ClientModel copyWith({
    String? id,
    String? name,
    String? phone,
    bool? isDeleted,
    DateTime? createdAt,
  }) {
    return ClientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      'isDeleted': isDeleted,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      isDeleted: map['isDeleted'] != null ? map['isDeleted'] as bool : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch((map['createdAt'] ?? 0) as int)
          : null,
    );
  }

  @override
  String toString() {
    return 'ClientModel(id: $id, name: $name, phone: $phone, isDeleted: $isDeleted, createdAt: $createdAt)';
  }

  ClientModel fromMap(Map<String, dynamic> map) {
    return ClientModel.fromMap(map);
  }
}
