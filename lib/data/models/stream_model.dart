import '../../domain/entities/stream_entity.dart';

/// Data-layer representation of a stream, ready to be built via
/// `fromJson` once a real API is wired up.
class StreamModel extends StreamEntity {
  const StreamModel({
    required super.id,
    required super.hostName,
    required super.viewerCount,
    required super.photoUrl,
    required super.thumbnailAsset,
    required super.regionFlagAsset,
    super.isFollowing,
  });

  factory StreamModel.fromJson(Map<String, dynamic> json) {
    return StreamModel(
      id: json['id'] as String,
      hostName: json['hostName'] as String,
      viewerCount: json['viewerCount'] as int,
      photoUrl: json['photoUrl'] as String,
      thumbnailAsset: json['thumbnailAsset'] as String,
      regionFlagAsset: json['regionFlagAsset'] as String,
      isFollowing: json['isFollowing'] as bool? ?? false,
    );
  }
}
