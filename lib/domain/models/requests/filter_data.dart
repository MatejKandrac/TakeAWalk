class FilterData {
  final DateTime? date;
  final int places;
  final int peopleGoing;
  final String order;
  final bool showHistory;


  const FilterData({
    this.date,
    required this.places,
    required this.peopleGoing,
    required this.order,
    required this.showHistory
  });

  Map<String, dynamic> toMap() {
    return {
      'date': this.date?.toIso8601String(),
      'places': this.places,
      'peopleGoing': this.peopleGoing,
      'order': this.order,
      'showHistory': this.showHistory,
    };
  }

  factory FilterData.fromMap(Map<String, dynamic> map) {
    return FilterData(
        date: DateTime.parse(map['date'] as String),
        places: map['places'] as int,
        peopleGoing: map['peopleGoing'] as int,
        order: map['order'] as String,
        showHistory: map['showHistory'] as bool);
  }

}
