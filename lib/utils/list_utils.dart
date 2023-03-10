import 'dart:math';

class ListUtils {
  static List<List<T>> splitList<T>(List<T> list, int itemPerPart) {
    List<List<T>> result = [];
    for (var i = 0; i < list.length; i += itemPerPart) {
      result.add(list.sublist(i, min(list.length, i + itemPerPart)));
    }
    return result;
  }

  static List<T> join<T>(List<T> list, T Function(int) joinElementGenerator) {
    List<T> result = [];
    for (var i = 0; i < list.length - 1; i++) {
      result.add(list[i]);
      result.add(joinElementGenerator(i));
    }
    result.add(list.last);
    return result;
  }

}
