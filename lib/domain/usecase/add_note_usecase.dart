import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:memoscape/common/extension/string.dart';
import 'package:memoscape/data/dto/note_dto.dart';
import 'package:memoscape/domain/model/error.dart';
import 'package:memoscape/domain/model/note.dart';
import 'package:memoscape/domain/repository/note_repository.dart';
import 'package:uuid/uuid.dart';

@injectable
class AddNoteUsecase {
  AddNoteUsecase(this._repository);
  final NoteRepository _repository;
  final _uuid = const Uuid();

  Future<Either<NoteError, Unit>> call(Note note) async {
    try {
      final validatedNote = note.copyWith(
        todos: note.todos.where((todo) => todo.title.isNotEmptyString).toList(),
      );

      final noteDto = NoteDto.fromNote(validatedNote);

      if (!noteDto.validNote) {
        return left(
          NoteError(message: 'Failed to add note, Title should not empty.'),
        );
      }

      await _repository.addUpdateNote(noteDto.copyWith(id: _uuid.v4()));
      return right(unit);
    } on Exception catch (_) {
      return left(NoteError(message: 'Failed to add note, please try again.'));
    }
  }
}
