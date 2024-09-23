
extension ListX<E> on List<E> {
  E? firstSatisfying(bool Function(E) test) {
    for (final element in this) {
      if (test(element)) {
        return element;
      }
    }

    return null;
  }

  int? firstIndexSatisfying(bool Function(E) test) {
    final index = indexWhere((element) => test(element));

    if (index != -1) {
      return index;
    } else {
      return null;
    }
  }

  E? at(int index) {
    if (isEmpty) {
      return null;
    }

    if (index >= length) {
      return null;
    }

    return this[index];
  }

  @Deprecated("Use getOrGenericNull<T>")
  dynamic getOrNull(int index) {
    if (length <= index) {
      return null;
    } else {
      return this[index];
    }
  }

  T? getOrGenericNull<T>(int index) {
    if (length <= index) {
      return null;
    } else {
      return this[index] as T;
    }
  }
}
