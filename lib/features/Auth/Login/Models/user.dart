class UserModel {
  static const String collectionName = 'users';
  String? id;
  String? name;
  String? email;
  String? phone;

  UserModel({this.id, this.name, this.email, this.phone});

  UserModel.fromFireStore(Map<String, dynamic>? data)
      : this(
            id: data?['id'],
            name: data?['name'],
            phone: data!['phone'] ?? '00',
            email: data['email']);

  Map<String, dynamic> toFireStore() {
    return {'id': id, 'name': name, 'email': email, 'phone': phone};
  }
}
