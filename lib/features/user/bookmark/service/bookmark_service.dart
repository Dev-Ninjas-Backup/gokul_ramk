import 'package:gokul_ramk/features/user/bookmark/model/bookmark_model.dart';
import 'package:gokul_ramk/features/user/bookmark/repository/bookmark_repository.dart';

class BookmarkService {
  final BookmarkRepository _repository;

  BookmarkService(this._repository);

  Future<List<BookmarkModel>> fetchBookmarks() async {
    return await _repository.getBookmarks();
  }
}
