class EventModel {
  final String timestamp;
  final String name;
  final String location;
  final String img;
  final String backdrop;

  EventModel(
      {this.timestamp = '',
      this.name = '',
      this.location = '',
      this.img = '',
      this.backdrop = ''});

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      name: json['name'],
      backdrop: 'assets/images/${json['backdrop']}.png',
      img: 'assets/images/${json['img']}.png',
      location: json['location'],
      timestamp: json['date'],
    );
  }
}
