import '../../core/constants/app_assets.dart';
import '../models/stream_model.dart';

/// Stands in for a real REST call (see [ApiEndpoints.streams]). The
/// assignment only requires the UI/navigation flow, so this returns
/// mock data shaped exactly like a future API response would be.
class StreamRemoteDataSource {
  static const Map<String, String> _regionFlags = {
    'Global': AppAssets.flagGlobal,
    'India': AppAssets.flagIndia,
    'Philippines': AppAssets.flagPhilippines,
    'Brazil': AppAssets.flagBrazil,
  };

  Future<List<StreamModel>> fetchStreams({required String region}) async {
    await Future.delayed(const Duration(milliseconds: 400));

    final thumbnails = AppAssets.streamPlaceholders;
    final flagAsset = _regionFlags[region] ?? AppAssets.flagGlobal;

    return List.generate(8, (index) {
      final photoIndex = (index % 8) + 1;
      return StreamModel(
        id: '$region-$index',
        hostName: 'Sofia Chen',
        viewerCount: 8200,
        photoUrl: 'https://randomuser.me/api/portraits/women/$photoIndex.jpg',
        thumbnailAsset: thumbnails[index % thumbnails.length],
        regionFlagAsset: flagAsset,
        isFollowing: false,
      );
    });
  }
}
