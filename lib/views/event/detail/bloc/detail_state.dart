
part of 'detail_bloc.dart';

abstract class DetailState {
  const DetailState();
}

class DetailDataState extends DetailState {

  final bool editable;
  final bool deletable;
  final bool isInvite;
  final bool isCancellable;
  final int actualIndex;
  final String eventName;
  final String ownerName;
  final String dateText;
  final String timeText;
  final List<Location> locations;
  final List<EventInvite> people;
  final List<String>? pictures;

  const DetailDataState({
    required this.eventName,
    required this.ownerName,
    required this.people,
    required this.locations,
    required this.dateText,
    required this.timeText,
    required this.isCancellable,
    this.pictures,
    this.editable = false,
    this.deletable = false,
    this.isInvite = false,
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

// class DetailAcceptedState extends DetailDataState {
//   const DetailAcceptedState(super.data);
// }
//
// class DetailPendingState extends DetailDataState {
//   const DetailPendingState(super.data);
// }
//
// class DetailEditProgressState extends DetailDataState {
//   const DetailEditProgressState(super.data);
// }
//
// class DetailEditInactiveState extends DetailDataState {
//   const DetailEditInactiveState(super.data);
// }