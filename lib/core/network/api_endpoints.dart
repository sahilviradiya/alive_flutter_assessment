/// REST endpoint registry. No live API is required for this assessment,
/// but the structure is kept ready so real endpoints can be dropped in.
class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'https://api.alive.example.com/v1';

  static const String streams = '/streams';
  static const String profile = '/profile';
}
