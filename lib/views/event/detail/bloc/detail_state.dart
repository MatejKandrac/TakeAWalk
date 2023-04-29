
part of 'detail_bloc.dart';

abstract class DetailState {
  const DetailState();
}

class DetailDataState extends DetailState {

  final bool editable;
  final bool deletable;
  final bool isInvite;
  final bool isCancellable;
  final bool canGoNext;
  final bool active;
  final int actualIndex;
  final String eventName;
  final String ownerName;
  final String dateText;
  final String timeText;
  final bool? locationLive;
  final List<Location> locations;

  const DetailDataState({
    required this.locations,
    required this.eventName,
    required this.ownerName,
    required this.dateText,
    required this.timeText,
    required this.isCancellable,
    this.locationLive,
    this.canGoNext = false,
    this.editable = false,
    this.deletable = false,
    this.isInvite = false,
    this.active = false,
    this.actualIndex = 0
  });

  DetailDataState copyWith({
    bool? locationLive,
    int? actualIndex
  }) {
    return DetailDataState(
      editable: editable,
      deletable: deletable,
      isInvite: isInvite,
      isCancellable: isCancellable,
      active: active,
      actualIndex: actualIndex ?? this.actualIndex,
      eventName: eventName,
      ownerName: ownerName,
      dateText: dateText,
      timeText: timeText,
      locationLive: locationLive ?? this.locationLive,
      locations: locations,
    );
  }

}

class DetailErrorState extends DetailState {
  final String text;
  const DetailErrorState(this.text);
}

class DetailLoadingState extends DetailState {
  const DetailLoadingState();
}

class DetailInviteAcceptedState extends DetailState {
  const DetailInviteAcceptedState();
}

class DetailInviteDeclinedState extends DetailState {
  const DetailInviteDeclinedState();
}

class DetailInviteCancelledState extends DetailState {
  const DetailInviteCancelledState();
}

class DetailEventCancelled extends DetailState {
  const DetailEventCancelled();
}