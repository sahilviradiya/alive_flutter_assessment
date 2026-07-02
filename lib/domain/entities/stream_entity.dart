import 'package:equatable/equatable.dart';

/// A single live-stream card shown on the Home grid.
class StreamEntity extends Equatable {
  const StreamEntity({
    required this.id,
    required this.hostName,
    required this.viewerCount,
    required this.photoUrl,
    required this.thumbnailAsset,
    required this.regionFlagAsset,
    this.isFollowing = false,
  });

  final String id;
  final String hostName;
  final int viewerCount;

  /// Network photo of the streamer. [thumbnailAsset] is the local SVG
  /// fallback used if the network image fails to load.
  final String photoUrl;
  final String thumbnailAsset;
  final String regionFlagAsset;
  final bool isFollowing;

  String get formattedViewerCount {
    if (viewerCount >= 1000) {
      return '${(viewerCount / 1000).toStringAsFixed(1)}K';
    }
    return '$viewerCount';
  }

  @override
  List<Object?> get props =>
      [id, hostName, viewerCount, photoUrl, thumbnailAsset, regionFlagAsset, isFollowing];
}
