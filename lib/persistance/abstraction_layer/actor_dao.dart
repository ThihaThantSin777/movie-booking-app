import '../../data/vos/cast_crew_vo/cast_crew_vo.dart';

abstract class ActorDAO{
  void saveActors(int movieID,CastCrewVO actorList);
  CastCrewVO? getActorListByID(int movieID);

  Stream<CastCrewVO?>getAllActorStream(int movieID);

  Stream<void>getActorStream();

}