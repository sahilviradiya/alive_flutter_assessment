import '../entities/stream_entity.dart';

/// Contract for fetching live streams for the Home feed. Implemented
/// today by a local mock data source, but shaped so a REST-backed
/// implementation can be swapped in without touching the UI.
abstract class StreamRepository {
  Future<List<StreamEntity>> getStreams({required String region});
}
