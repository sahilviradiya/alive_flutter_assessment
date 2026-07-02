import 'package:firebase_auth/firebase_auth.dart' as fb;

import '../../domain/entities/user_entity.dart';

/// Maps Firebase's [fb.User] onto the domain [UserEntity].
class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.name,
    required super.email,
    super.photoUrl,
  });

  factory UserModel.fromFirebaseUser(fb.User user) {
    return UserModel(
      uid: user.uid,
      name: user.displayName ?? 'Alive User',
      email: user.email ?? '',
      photoUrl: user.photoURL,
    );
  }
}
