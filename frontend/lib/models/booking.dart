class Booking {
  final int? id;
  final int facilityId;
  final int userId;
  final String date;
  final String startTime;
  final String endTime;
  final String status;
  final String? facilityName;
  final String? userName;

  Booking({
    this.id,
    required this.facilityId,
    required this.userId,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.status = 'confirmed',
    this.facilityName,
    this.userName,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      facilityId: json['facilityId'],
      userId: json['userId'],
      date: json['date'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      status: json['status'],
      facilityName: json['facility']?['name'],
      userName: json['user']?['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'facilityId': facilityId,
      'userId': userId,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'status': status,
    };
  }
}
