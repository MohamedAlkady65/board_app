class Node {
  Node({required this.index}) {
    state = true;
  }
  int index;
  Node? left;
  Node? right;
  Node? up;
  Node? down;
  late bool state;

  @override
  String toString() {
    return "node ${index+1}";
  }
}
