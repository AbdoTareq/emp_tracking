// ignore_for_file: public_member_api_docs, sort_constructors_first
enum RequestStatus { pending, approved, rejected }

enum RequestType { sick, emergency, annual, other }

class RequestModel {
  final String? id;
  final String? employeeId;
  final String? managerDeciderId;
  final RequestType? type;
  final RequestStatus? status;
  final String? note;
  RequestModel({
    this.id,
    this.employeeId,
    this.managerDeciderId,
    this.type,
    this.status,
    this.note,
  });

  RequestModel copyWith({
    String? id,
    String? employeeId,
    String? managerDeciderId,
    RequestType? type,
    RequestStatus? status,
    String? note,
  }) {
    return RequestModel(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      managerDeciderId: managerDeciderId ?? this.managerDeciderId,
      type: type ?? this.type,
      status: status ?? this.status,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'employeeId': employeeId,
      'managerDeciderId': managerDeciderId,
      'type': type?.name,
      'status': status?.name,
      'note': note,
    };
  }

  factory RequestModel.fromMap(Map<String, dynamic> map) {
    return RequestModel(
      id: map['id'] != null ? map['id'] as String : null,
      employeeId:
          map['employeeId'] != null ? map['employeeId'] as String : null,
      managerDeciderId: map['managerDeciderId'] != null
          ? map['managerDeciderId'] as String
          : null,
      type: map['type'] != null
          ? RequestType.values
              .firstWhere((element) => element.name == map['type'] as String)
          : null,
      status: map['status'] != null
          ? RequestStatus.values
              .firstWhere((element) => element.name == map['status'] as String)
          : null,
      note: map['note'] != null ? map['note'] as String : null,
    );
  }

  @override
  String toString() {
    return 'RequestModel(id: $id, employeeId: $employeeId, managerDeciderId: $managerDeciderId, type: $type, status: $status, note: $note)';
  }
}
