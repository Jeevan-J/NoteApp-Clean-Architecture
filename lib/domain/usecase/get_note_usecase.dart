import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:memoscape/common/exception.dart';
import 'package:memoscape/domain/model/error.dart';
import 'package:memoscape/domain/model/note.dart';
import 'package:memoscape/domain/repository/note_repository.dart';

@injectable
class GetNoteUsecase {
  const GetNoteUsecase(this._repository);
  final NoteRepository _repository;

  Future<Either<NoteError, Note>> call(String id) async {
    try {
      final noteDto = await _repository.getNote(id);
      final note = noteDto.toDomain();

      return right(note);
    } on Exception catch (e) {
      if (e is NoRecordsException) {
        return left(NoteError(message: 'No matched note found.'));
      }
      return left(
        NoteError(message: 'Failed to load note, please try again.'),
      );
    }
  }
}
