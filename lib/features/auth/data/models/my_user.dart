class MyUser {
  final String? id;
  final String? name;
  final String? email;
  final String? jobTitle;
  final bool? isAdmin;
  final bool? isDeleted;
  final bool? isOnline;
  DateTime? lastSeen;

  MyUser({
    this.id = '',
    this.name = '',
    this.email = '',
    this.jobTitle,
    this.isAdmin,
    this.isDeleted,
    this.isOnline,
    this.lastSeen,
  });

  MyUser copyWith({
    String? id,
    String? name,
    String? email,
    String? jobTitle,
    bool? isAdmin,
    bool? isDeleted,
    bool? isOnline,
    DateTime? lastSeen,
  }) {
    return MyUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      jobTitle: jobTitle ?? this.jobTitle,
      isAdmin: isAdmin ?? this.isAdmin,
      isDeleted: isDeleted ?? this.isDeleted,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'jobTitle': jobTitle,
      'isAdmin': isAdmin,
      'isDeleted': isDeleted,
      'isOnline': isOnline,
      'lastSeen': lastSeen?.millisecondsSinceEpoch,
    };
  }

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      jobTitle: map['jobTitle'] != null ? map['jobTitle'] as String : null,
      isAdmin: map['isAdmin'] != null ? map['isAdmin'] as bool : null,
      isDeleted: map['isDeleted'] != null ? map['isDeleted'] as bool : null,
      isOnline: map['isOnline'] != null ? map['isOnline'] as bool : null,
      lastSeen: map['lastSeen'] != null
          ? DateTime.fromMillisecondsSinceEpoch((map['lastSeen'] ?? 0) as int)
          : null,
    );
  }

  @override
  String toString() {
    return 'MyUser(id: $id, name: $name, email: $email, jobTitle: $jobTitle, isAdmin: $isAdmin, isDeleted: $isDeleted, isOnline: $isOnline, lastSeen: $lastSeen)';
  }
}
