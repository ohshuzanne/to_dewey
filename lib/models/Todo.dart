class Todo{
  late String id;
  late String title;
  late String description;
  late bool isCompleted;
  late bool isDescDisplayed;
  late String timestamp;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.isDescDisplayed,
    required this.timestamp,
});
}