part of 'follow_un_follow_bloc.dart';

abstract class TopicFollowUnFollowEvent extends Equatable {
  const TopicFollowUnFollowEvent();
  @override
  List<Object> get props => [];
}

class TopicFollowEvent extends TopicFollowUnFollowEvent {
  final NewsTopicEntity topic;

  TopicFollowEvent({@required this.topic});

  @override
  List<Object> get props => [topic];
}

class TopicUnFollowEvent extends TopicFollowUnFollowEvent {
  final NewsTopicEntity topic;

  TopicUnFollowEvent({@required this.topic});

  @override
  List<Object> get props => [topic];
}
