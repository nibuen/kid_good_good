library hive_object_internal;

import 'package:hive/hive.dart';

/// Extend `HiveObject` to add useful methods to the objects you want to store
/// in Hive
class HiveObjectWrapper<T> {
  HiveObjectWrapper({
    required this.box,
    required this.key,
    required this.classToSave,
  });

  BoxBase<T> box;

  T classToSave;

  dynamic key;

  /// Persists this object.
  Future<void> save() {
    return box.put(key, classToSave);
  }

  /// Deletes this object from the box it is stored in.
  Future<void> delete() {
    return box.delete(key);
  }

  /// Returns whether this object is currently stored in a box.
  ///
  /// For lazy boxes this only checks if the key exists in the box and NOT
  /// whether this instance is actually stored in the box.
  bool get isInBox {
    if (box.lazy) {
      return box.containsKey(key);
    } else {
      return true;
    }
  }
}
