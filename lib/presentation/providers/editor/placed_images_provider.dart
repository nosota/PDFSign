import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'package:pdfsign/core/utils/page_rotation_transform.dart';
import 'package:pdfsign/domain/entities/placed_image.dart';

part 'placed_images_provider.g.dart';

/// Provider for managing images placed on PDF pages.
///
/// Uses keepAlive to persist state during zoom/scroll operations
/// when pages may temporarily become invisible.
@Riverpod(keepAlive: true)
class PlacedImages extends _$PlacedImages {
  final _uuid = const Uuid();

  @override
  List<PlacedImage> build() {
    return [];
  }

  /// Adds a new image to the PDF at the specified position.
  ///
  /// Returns the created object so the caller can select it without having to
  /// guess which entry of [state] is the new one.
  PlacedImage addImage({
    required String imagePath,
    String? sourceImageId,
    required int pageIndex,
    required Offset position,
    required Size size,
    double rotation = 0,
  }) {
    final image = PlacedImage(
      id: _uuid.v4(),
      sourceImageId: sourceImageId,
      imagePath: imagePath,
      pageIndex: pageIndex,
      position: position,
      size: size,
      rotation: rotation,
    );

    state = [...state, image];
    return image;
  }

  /// Removes an image by its ID.
  void removeImage(String id) {
    state = state.where((img) => img.id != id).toList();
  }

  /// Updates an existing image.
  void updateImage(PlacedImage updated) {
    state = state.map((img) => img.id == updated.id ? updated : img).toList();
  }

  /// Moves an image to a new position.
  void moveImage(String id, Offset newPosition) {
    state = state.map((img) {
      if (img.id == id) {
        return img.copyWith(position: newPosition);
      }
      return img;
    }).toList();
  }

  /// Resizes an image.
  void resizeImage(String id, Size newSize) {
    state = state.map((img) {
      if (img.id == id) {
        return img.copyWith(size: newSize);
      }
      return img;
    }).toList();
  }

  /// Rotates an image.
  void rotateImage(String id, double newRotation) {
    state = state.map((img) {
      if (img.id == id) {
        return img.copyWith(rotation: newRotation);
      }
      return img;
    }).toList();
  }

  /// Updates image position, size, and rotation together (for smooth manipulation).
  void transformImage(
    String id, {
    Offset? position,
    Size? size,
    double? rotation,
    int? pageIndex,
  }) {
    state = state.map((img) {
      if (img.id == id) {
        return img.copyWith(
          position: position,
          size: size,
          rotation: rotation,
          pageIndex: pageIndex,
        );
      }
      return img;
    }).toList();
  }

  /// Turns every object on [pageIndex] along with the page.
  ///
  /// [pageSize] is the page as displayed *before* the turn. An object stays
  /// where it visually was relative to the page content, which is the only
  /// behaviour that does not feel like the objects were thrown off.
  void turnPage(int pageIndex, int quarterTurns, Size pageSize) {
    if (quarterTurns % 4 == 0) {
      return;
    }
    state = [
      for (final image in state)
        if (image.pageIndex == pageIndex)
          _turned(image, quarterTurns, pageSize)
        else
          image,
    ];
  }

  static PlacedImage _turned(PlacedImage image, int quarterTurns, Size page) {
    final turned = PageRotationTransform.turned(
      image.position & image.size,
      page,
      quarterTurns,
    );
    return image.copyWith(
      position: turned.topLeft,
      size: turned.size,
      rotation: PageRotationTransform.angleTurned(image.rotation, quarterTurns),
    );
  }

  /// Brings [id] in front of everything else on its page.
  void bringToFront(String id) => _restack(id, (at, count) => count - 1);

  /// Moves [id] one place towards the front of its page.
  void bringForward(String id) => _restack(id, (at, count) => at + 1);

  /// Moves [id] one place towards the back of its page.
  void sendBackward(String id) => _restack(id, (at, count) => at - 1);

  /// Sends [id] behind everything else on its page.
  void sendToBack(String id) => _restack(id, (at, count) => 0);

  /// Moves [id] to the place [destination] picks among its page's objects.
  ///
  /// There is no depth stored on an object: the order objects are drawn in is
  /// the order they sit in this list, on the screen and in the saved file
  /// alike. Restacking is therefore a move within the list, and the two agree
  /// without anything having to keep them in step.
  ///
  /// Only the places already occupied by this page's objects are written to,
  /// so objects on other pages cannot be disturbed however the list is
  /// interleaved. Asking for a move that changes nothing — to the front of
  /// something already at the front — leaves the state identical, which is
  /// what keeps an empty step out of the undo history.
  void _restack(String id, int Function(int at, int count) destination) {
    final places = [
      for (var i = 0; i < state.length; i++)
        if (state[i].pageIndex == _pageOf(id)) i,
    ];
    final at = places.indexWhere((place) => state[place].id == id);
    if (at < 0) return;

    final to = destination(at, places.length);
    if (to == at || to < 0 || to >= places.length) return;

    final onPage = [for (final place in places) state[place]];
    onPage.insert(to, onPage.removeAt(at));

    final next = [...state];
    for (var k = 0; k < places.length; k++) {
      next[places[k]] = onPage[k];
    }
    state = next;
  }

  /// The page [id] sits on, or -1 when nothing has that id.
  int _pageOf(String id) {
    for (final image in state) {
      if (image.id == id) return image.pageIndex;
    }
    return -1;
  }

  /// Gets images for a specific page.
  List<PlacedImage> getImagesForPage(int pageIndex) {
    return state.where((img) => img.pageIndex == pageIndex).toList();
  }

  /// Creates a duplicate of an image at an offset position.
  PlacedImage? duplicateImage(String id, {Offset offset = const Offset(20, 20)}) {
    final original = state.firstWhere(
      (img) => img.id == id,
      orElse: () => throw StateError('Image not found'),
    );

    final duplicate = PlacedImage(
      id: _uuid.v4(),
      sourceImageId: original.sourceImageId,
      imagePath: original.imagePath,
      pageIndex: original.pageIndex,
      position: original.position + offset,
      size: original.size,
      rotation: original.rotation,
    );

    state = [...state, duplicate];
    return duplicate;
  }

  /// Clears all placed images.
  void clear() {
    state = [];
  }

  /// Checks if there are any placed images.
  bool get hasImages => state.isNotEmpty;
}
