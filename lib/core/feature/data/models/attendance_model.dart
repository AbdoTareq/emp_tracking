// ignore_for_file: public_member_api_docs, sort_constructors_first

class AttendanceModel {
  final String? id;
  final String? companyId;
  final String? name;
  final DateTime? date;
  final List<String>? employeesIds;

  AttendanceModel({
    this.id = '',
    this.companyId,
    this.name = '',
    this.date,
    this.employeesIds,
  });

  AttendanceModel copyWith({
    String? id,
    String? companyId,
    String? name,
    DateTime? date,
    List<String>? employeesIds,
  }) {
    return AttendanceModel(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      name: name ?? this.name,
      date: date ?? this.date,
      employeesIds: employeesIds ?? this.employeesIds,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'companyId': companyId,
      'name': name,
      'date': date?.millisecondsSinceEpoch,
      'employeesIds': employeesIds,
    };
  }

  factory AttendanceModel.fromMap(Map<String, dynamic> map) {
    return AttendanceModel(
      id: map['id'] != null ? map['id'] as String : null,
      companyId: map['companyId'] != null ? map['companyId'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch((map['date'] ?? 0) as int)
          : null,
      employeesIds: map['employeesIds'] == null
          ? null
          : map['employeesIds'] as List<String>,
    );
  }

  @override
  String toString() {
    return 'AttendanceModel(id: $id, companyId: $companyId, name: $name, date: $date, employeesIds: $employeesIds)';
  }

  AttendanceModel fromMap(Map<String, dynamic> map) {
    return AttendanceModel.fromMap(map);
  }
}
