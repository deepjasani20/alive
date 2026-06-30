/// Domain model representing an authenticated user.
///
/// It is deliberately decoupled from Firebase's `User` type so the rest of the
/// app never depends on the auth provider — swapping Firebase for a REST
/// backend later only touches the data layer.
class UserModel {
  const UserModel({
    required this.uid,
    this.name,
    this.email,
    this.photoUrl,
  });

  final String uid;
  final String? name;
  final String? email;
  final String? photoUrl;

  /// Build a model from a generic JSON map (REST-API ready).
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String? ?? '',
      name: json['name'] as String?,
      email: json['email'] as String?,
      photoUrl: json['photoUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'uid': uid,
        'name': name,
        'email': email,
        'photoUrl': photoUrl,
      };
}
