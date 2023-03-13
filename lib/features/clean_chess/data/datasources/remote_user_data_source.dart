import 'package:cleanchess/chess/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:lichess_client_dio/lichess_client_dio.dart';

abstract class RemoteUserDataSource {
  /// Api to get a list of users by a search term
  /// [term] is the search term
  /// [friend] is a boolean to search for friends only
  Future<Either<Failure, List<User>>> getUsersByTerm(
    String term,
    bool friend,
  );

  /// Api to get a list of usernames by a search term
  /// [term] is the search term
  /// [friend] is a boolean to search for friends only
  Future<Either<Failure, List<String>>> getUsernamesByTerm(
    String term,
    bool friend,
  );

  /// Api to get a list of the Realtime User Stats
  Future<Either<Failure, List<RealTimeUserStatus>>> getRealtimeStatus(
    List<String> ids,
    bool withGameIds,
  );

  /// Api to get the top 10 players for each speed and variant
  Future<Either<Failure, Map<String, List<User>>>> getTop10Players();

  /// Api to get the leaderboard for a single speed or variant (a.k.a. perfType)
  /// There is no leaderboard for correspondence or puzzles.
  /// [perfType] is the speed or variant to get the leaderboard for
  /// [nb] is the number of players to get
  Future<Either<Failure, List<User>>> getChessVariantLeaderboard(
    PerfType perfType,
    int nb,
  );

  /// Api to read public data of a user.
  /// If the request is authenticated with OAuth2, then
  /// extra fields might be present in the response:
  /// followable, following, blocking, followsYou
  Future<Either<Failure, User>> getPublicData({
    required String username,
    bool trophies = false,
  });
}
