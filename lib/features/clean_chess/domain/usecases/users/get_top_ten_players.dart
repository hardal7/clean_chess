import 'package:cleanchess/core/clean_chess/errors/failure.dart';
import 'package:cleanchess/core/usecases/usecase.dart';
import 'package:cleanchess/features/clean_chess/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:lichess_client_dio/lichess_client_dio.dart';

class GetTop10Players extends UseCase<Map<String, List<User>>, NoParams> {
  final UserRepository userRepository;

  GetTop10Players(this.userRepository);

  @override
  Future<Either<Failure, Map<String, List<User>>>> call(NoParams params) =>
      userRepository.getTop10Players();
}
