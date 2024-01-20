import 'package:google_maps_flutter/google_maps_flutter.dart';

class DayLocation {
  final String id;
  final DateTime? date;
  final List<LatLng>? locations;
  DayLocation({
    this.id = '',
    this.date,
    this.locations,
  });

  DayLocation copyWith({
    String? id,
    DateTime? date,
    List<LatLng>? locations,
  }) {
    return DayLocation(
      id: id ?? this.id,
      date: date ?? this.date,
      locations: locations ?? this.locations,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date?.millisecondsSinceEpoch,
      'locations': locations?.map((x) => x.toJson()).toList(),
    };
  }

  factory DayLocation.fromMap(Map<String, dynamic> map) {
    return DayLocation(
      id: (map['id'] ?? '') as String,
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch((map['date'] ?? 0) as int)
          : null,
      locations: map['locations'] != null
          ? List<LatLng>.from(
              (map['locations'] as List<int>).map<LatLng?>(
                (x) => LatLng.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  @override
  String toString() =>
      'DayLocation(id: $id, date: $date, locations: $locations)';
}
