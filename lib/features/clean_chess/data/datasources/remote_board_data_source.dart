import 'package:cleanchess/core/errors/failure.dart';
import 'package:cleanchess/core/utilities/empty.dart';
import 'package:cleanchess/core/utilities/globals.dart';
import 'package:dartz/dartz.dart';
import 'package:lichess_client_dio/lichess_client_dio.dart';

abstract class RemoteBoardDataSource {
  /// APi to create a real time seek
  Future<Either<Failure, Keepalive>> createRealTimeSeek({
    required double time,
    required int increment,
    DaysPerTurn? days,
    bool rated = false,
    LichessVariantKey variant = LichessVariantKey.standard,
    LichessChallengeColor color = LichessChallengeColor.random,
    int? maxRating,
    int? minRating,
  });

  /// API to create a correspondence seek
  Future<Either<Failure, Keepalive>> createCorrespondenceSeek({
    required DaysPerTurn days,
    bool rated = false,
    LichessVariantKey variant = LichessVariantKey.standard,
    LichessChallengeColor color = LichessChallengeColor.random,
    double? time,
    int? increment,
    int? maxRating,
    int? minRating,
  });

  /// API to Abort a Game
  Future<Either<Failure, Empty>> abortGame(String gameId);
}
