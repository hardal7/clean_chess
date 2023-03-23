import 'package:cleanchess/core/clean_chess/errors/failure.dart';
import 'package:cleanchess/core/usecases/usecase.dart';
import 'package:cleanchess/features/clean_chess/domain/repositories/social_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:lichess_client_dio/lichess_client_dio.dart';

class GetFollowingUsers extends UseCase<List<User>, NoParams> {
  final SocialRepository repository;

  GetFollowingUsers(this.repository);

  @override
  Future<Either<Failure, List<User>>> call(NoParams params) =>
      repository.getFollowingUsers();
}
