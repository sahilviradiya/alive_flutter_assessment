import 'package:equatable/equatable.dart';

/// Pure domain representation of an authenticated user, independent of
/// Firebase or any data-source-specific model.
class UserEntity extends Equatable {
  const UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    this.photoUrl,
  });

  final String uid;
  final String name;
  final String email;
  final String? photoUrl;

  @override
  List<Object?> get props => [uid, name, email, photoUrl];
}
