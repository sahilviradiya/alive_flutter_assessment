import '../entities/stream_entity.dart';
import '../repositories/stream_repository.dart';

/// Encapsulates fetching the stream feed for a given region.
class GetStreamsUseCase {
  const GetStreamsUseCase(this._repository);

  final StreamRepository _repository;

  Future<List<StreamEntity>> call({required String region}) {
    return _repository.getStreams(region: region);
  }
}
