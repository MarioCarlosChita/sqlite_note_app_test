typedef DataMap = Map<String, dynamic>;

class Note {
  final int? id;
  final String name;
  Note({required this.id, required this.name});

  Note.create({required this.name}) : id = null;

  factory Note.fromJson(DataMap json) {
    return Note(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
    );
  }
  DataMap toMap() {
    DataMap data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
