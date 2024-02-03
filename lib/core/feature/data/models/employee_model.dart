// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:employee_management/core/feature/data/models/day_location_model.dart';

class EmployeeModel {
  final String? id;
  final String? companyId;
  final String? name;
  final String? type;
  final String? email;
  final String? phone;
  final String? jobTitle;
  final bool? isDeleted;
  final bool? isOnline;
  final DateTime? lastSeen;
  final DateTime? createdAt;
  final List<DayLocationModel>? trackingLocations;

  EmployeeModel({
    this.id = '',
    this.companyId,
    this.name = '',
    this.type,
    this.email = '',
    this.phone,
    this.jobTitle,
    this.isDeleted,
    this.isOnline,
    this.lastSeen,
    this.createdAt,
    this.trackingLocations = const [],
  });

  EmployeeModel copyWith({
    String? id,
    String? companyId,
    String? name,
    String? type,
    String? email,
    String? phone,
    String? jobTitle,
    bool? isDeleted,
    bool? isOnline,
    DateTime? lastSeen,
    DateTime? createdAt,
    List<DayLocationModel>? trackingLocations,
  }) {
    return EmployeeModel(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      name: name ?? this.name,
      type: type ?? this.type,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      jobTitle: jobTitle ?? this.jobTitle,
      isDeleted: isDeleted ?? this.isDeleted,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
      createdAt: createdAt ?? this.createdAt,
      trackingLocations: trackingLocations ?? this.trackingLocations,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'companyId': companyId,
      'name': name,
      'type': type,
      'email': email,
      'phone': phone,
      'jobTitle': jobTitle,
      'isDeleted': isDeleted,
      'isOnline': isOnline,
      'lastSeen': lastSeen?.millisecondsSinceEpoch,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'trackingLocations': trackingLocations?.map((x) => x.toMap()).toList(),
    };
  }

  factory EmployeeModel.fromMap(Map<String, dynamic> map) {
    return EmployeeModel(
      id: map['id'] != null ? map['id'] as String : null,
      companyId: map['companyId'] != null ? map['companyId'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      jobTitle: map['jobTitle'] != null ? map['jobTitle'] as String : null,
      isDeleted: map['isDeleted'] != null ? map['isDeleted'] as bool : null,
      isOnline: map['isOnline'] != null ? map['isOnline'] as bool : null,
      lastSeen: map['lastSeen'] != null
          ? DateTime.fromMillisecondsSinceEpoch((map['lastSeen'] ?? 0) as int)
          : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch((map['createdAt'] ?? 0) as int)
          : null,
      trackingLocations: map['trackingLocations'] != null
          ? List<DayLocationModel>.from(
              (map['trackingLocations'] as List<int>).map<DayLocationModel?>(
                (x) => DayLocationModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  @override
  String toString() {
    return 'EmployeeModel(id: $id, companyId: $companyId, name: $name, type: $type, email: $email, phone: $phone, jobTitle: $jobTitle, isDeleted: $isDeleted, isOnline: $isOnline, lastSeen: $lastSeen, createdAt: $createdAt, trackingLocations: $trackingLocations)';
  }

  EmployeeModel fromMap(Map<String, dynamic> map) {
    return EmployeeModel.fromMap(map);
  }
}
