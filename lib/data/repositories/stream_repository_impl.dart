import '../../domain/entities/stream_entity.dart';
import '../../domain/repositories/stream_repository.dart';
import '../datasources/stream_remote_data_source.dart';

class StreamRepositoryImpl implements StreamRepository {
  StreamRepositoryImpl(this._remoteDataSource);

  final StreamRemoteDataSource _remoteDataSource;

  @override
  Future<List<StreamEntity>> getStreams({required String region}) {
    return _remoteDataSource.fetchStreams(region: region);
  }
}
