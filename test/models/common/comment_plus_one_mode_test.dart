import 'package:ex_piliplus/models/common/comment_plus_one_mode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('missing or invalid legacy value defaults to disabled', () {
    expect(CommentPlusOneMode.fromStorage(null), CommentPlusOneMode.disabled);
    expect(CommentPlusOneMode.fromStorage(-1), CommentPlusOneMode.disabled);
    expect(CommentPlusOneMode.fromStorage(99), CommentPlusOneMode.disabled);
  });

  test('all mode ignores uploader list, selected mode uses video owner UID', () {
    final selected = {1001};

    expect(
      CommentPlusOneMode.allVideos.isEnabledForOwner(
        ownerMid: 2002,
        selectedOwnerMids: selected,
      ),
      isTrue,
    );
    expect(
      CommentPlusOneMode.selectedUploaders.isEnabledForOwner(
        ownerMid: 1001,
        selectedOwnerMids: selected,
      ),
      isTrue,
    );
    expect(
      CommentPlusOneMode.selectedUploaders.isEnabledForOwner(
        ownerMid: 2002,
        selectedOwnerMids: selected,
      ),
      isFalse,
    );
    expect(
      CommentPlusOneMode.selectedUploaders.isEnabledForOwner(
        ownerMid: null,
        selectedOwnerMids: selected,
      ),
      isFalse,
    );
    expect(
      CommentPlusOneMode.disabled.isEnabledForOwner(
        ownerMid: 1001,
        selectedOwnerMids: selected,
      ),
      isFalse,
    );
  });
}
