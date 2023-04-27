
part of 'detail_bloc.dart';

abstract class DetailState {
  const DetailState();
}

class DetailDataState extends DetailState {

  final bool editable;
  final bool deletable;
  final bool isInvite;
  final bool isCancellable;
  final bool active;
  final int actualIndex;
  final String eventName;
  final String ownerName;
  final String dateText;
  final String timeText;
  final List<Location> locations;

  const DetailDataState({
    required this.eventName,
    required this.ownerName,
    required this.locations,
    required this.dateText,
    required this.timeText,
    required this.isCancellable,
    this.editable = false,
    this.deletable = false,
    this.isInvite = false,
    this.active = false,
    this.actualIndex = 0
  });

}

class DetailErrorState extends DetailState {
  final String text;
  const DetailErrorState(this.text);
}

class DetailLoadingState extends DetailState {
  const DetailLoadingState();
}