

import 'package:movie_booking_app/data/vos/cast_crew_vo/cast_crew_vo.dart';
import 'package:movie_booking_app/persistance/abstraction_layer/actor_dao.dart';

import '../mock_data/mock_data.dart';

class ActorDaoImplMock extends ActorDAO{
   Map<int,CastCrewVO> getActorDatabaseMock = {};
  @override
  CastCrewVO? getActorListByID(int movieID) {
    return actorsMockForTest().first;
  }

  @override
  Stream<void> getActorStream() {
    return Stream<void>.value(null);
  }

  @override
  Stream<CastCrewVO?> getAllActorStream(int movieID) {

    return Stream.value(actorsMockForTest().first);
  }

  @override
  void saveActors(int movieID, CastCrewVO actorList) {
    getActorDatabaseMock[movieID] = actorList;
  }




}