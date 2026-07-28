extension IterableExtension<E> on Iterable<E> {
  void forEachIndexed(void Function(int index, E element) action) {
    var index = 0;
    for (var element in this) {
      action(index++, element);
    }
  }
}