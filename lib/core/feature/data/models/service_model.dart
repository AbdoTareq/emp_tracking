// ignore_for_file: public_member_api_docs, sort_constructors_first
class Service {
  final String? id;
  final String? clientId;
  final String? employeeId;
  final String? name;
  final String? timesNumber;
  Service({
    this.id,
    this.clientId,
    this.employeeId,
    this.name,
    this.timesNumber,
  });

  Service copyWith({
    String? id,
    String? clientId,
    String? employeeId,
    String? name,
    String? timesNumber,
  }) {
    return Service(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      employeeId: employeeId ?? this.employeeId,
      name: name ?? this.name,
      timesNumber: timesNumber ?? this.timesNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'clientId': clientId,
      'employeeId': employeeId,
      'name': name,
      'timesNumber': timesNumber,
    };
  }

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      id: map['id'] != null ? map['id'] as String : null,
      clientId: map['clientId'] != null ? map['clientId'] as String : null,
      employeeId:
          map['employeeId'] != null ? map['employeeId'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      timesNumber:
          map['timesNumber'] != null ? map['timesNumber'] as String : null,
    );
  }

  @override
  String toString() {
    return 'Service(id: $id, clientId: $clientId, employeeId: $employeeId, name: $name, timesNumber: $timesNumber)';
  }
}
