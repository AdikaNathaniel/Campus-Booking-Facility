class Facility {
  final int? id;
  final String name;
  final String location;
  final int capacity;

  Facility({
    this.id,
    required this.name,
    required this.location,
    required this.capacity,
  });

  factory Facility.fromJson(Map<String, dynamic> json) {
    return Facility(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      capacity: json['capacity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
      'capacity': capacity,
    };
  }
}
