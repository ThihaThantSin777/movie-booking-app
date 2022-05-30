
import 'package:hive/hive.dart';
import 'package:movie_booking_app/persistance/abstraction_layer/actor_dao.dart';
import 'package:movie_booking_app/persistance/hive_constant.dart';

import '../../data/vos/cast_crew_vo/cast_crew_vo.dart';

class ActorDAOImpl extends ActorDAO{
  ActorDAOImpl.internal();

  static final ActorDAOImpl _singleton=ActorDAOImpl.internal();

  factory ActorDAOImpl()=>_singleton;

  @override
  void saveActors(int movieID,CastCrewVO actorList){
    getActorBox().put(movieID,actorList);
  }

  @override
  CastCrewVO? getActorListByID(int movieID) {
   return getActorBox().get(movieID);
  }

  Box<CastCrewVO>getActorBox()=>Hive.box<CastCrewVO>(BOX_NAME_ACTOR_VO);

  @override
  Stream<void>getActorStream(){
    return getActorBox().watch();
  }
  @override
  Stream<CastCrewVO?>getAllActorStream(int movieID)=>Stream.value(getActorListByID(movieID));

}