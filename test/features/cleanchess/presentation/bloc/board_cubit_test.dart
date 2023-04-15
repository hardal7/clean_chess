import 'package:cleanchess/core/errors/failure.dart';
import 'package:cleanchess/core/utilities/globals.dart';
import 'package:cleanchess/features/clean_chess/presentation/blocs/board_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:lichess_client_dio/lichess_client_dio.dart';
import 'package:mockito/mockito.dart';
import 'lichess_bloc_mocks.mocks.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockMCreateRealTimeSeek mockCreateRealTimeSeek;
  late MockMCreateCorrespondenceSeek mockCreateCorrespondenceSeek;

  late BoardCubit bloc;

  late Keepalive keepalive;

  setUp(() {
    mockCreateRealTimeSeek = MockMCreateRealTimeSeek();
    mockCreateCorrespondenceSeek = MockMCreateCorrespondenceSeek();
    keepalive = () async {};

    bloc = BoardCubit(
      createRealTimeSeek: mockCreateRealTimeSeek,
      createCorrespondenceSeek: mockCreateCorrespondenceSeek,
    );
  });

  group('Board', () {
    group('Create RealTime Seek', () {
      blocTest<BoardCubit, BoardState>(
        'Success',
        build: () {
          when(mockCreateRealTimeSeek.call(any)).thenAnswer(
            (_) async => Right(keepalive),
          );

          return bloc;
        },
        act: (bloc) => bloc.createRealTimeSeek(time: 0, increment: 0),
        expect: () => [
          const BoardState.loading(),
          BoardState.realTimeSeek(keepalive),
        ],
        verify: (bloc) {
          verify(mockCreateRealTimeSeek.call(any)).called(1);
        },
      );

      blocTest<BoardCubit, BoardState>(
        'Failure',
        build: () {
          when(mockCreateRealTimeSeek.call(any)).thenAnswer(
            (_) async => const Left(LichessOAuthFailure('OAtuh error')),
          );

          return bloc;
        },
        act: (bloc) => bloc.createRealTimeSeek(time: 0, increment: 0),
        expect: () => [
          const BoardState.loading(),
          const BoardState.failure(LichessOAuthFailure('OAtuh error')),
        ],
        verify: (bloc) {
          verify(mockCreateRealTimeSeek.call(any)).called(1);
        },
      );
    });

    group('Create Correspondence Seek', () {
      blocTest<BoardCubit, BoardState>(
        'Success',
        build: () {
          when(mockCreateCorrespondenceSeek.call(any)).thenAnswer(
            (_) async => Right(keepalive),
          );

          return bloc;
        },
        act: (bloc) => bloc.createCorrespondenceSeek(days: DaysPerTurn.one),
        expect: () => [
          const BoardState.loading(),
          BoardState.correspondenceSeek(keepalive),
        ],
        verify: (bloc) {
          verify(mockCreateCorrespondenceSeek.call(any)).called(1);
        },
      );

      blocTest<BoardCubit, BoardState>(
        'Failure',
        build: () {
          when(mockCreateCorrespondenceSeek.call(any)).thenAnswer(
            (_) async => const Left(LichessOAuthFailure('OAtuh error')),
          );

          return bloc;
        },
        act: (bloc) => bloc.createCorrespondenceSeek(days: DaysPerTurn.one),
        expect: () => [
          const BoardState.loading(),
          const BoardState.failure(LichessOAuthFailure('OAtuh error')),
        ],
        verify: (bloc) {
          verify(mockCreateCorrespondenceSeek.call(any)).called(1);
        },
      );
    });
  });
}
