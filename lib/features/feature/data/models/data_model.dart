// ignore_for_file: public_member_api_docs, sort_constructors_first
class DataModel {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DataModel({
    this.id = '',
    this.createdAt,
    this.updatedAt,
  });

  DataModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DataModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory DataModel.fromMap(Map<String, dynamic> map) {
    return DataModel(
      id: map['id'] != null ? map['id'] as String : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch((map['createdAt'] ?? 0) as int)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch((map['updatedAt'] ?? 0) as int)
          : null,
    );
  }

  @override
  String toString() =>
      'DataModel(id: $id, createdAt: $createdAt, updatedAt: $updatedAt)';

  DataModel fromMap(Map<String, dynamic> map) {
    return DataModel.fromMap(map);
  }
}
