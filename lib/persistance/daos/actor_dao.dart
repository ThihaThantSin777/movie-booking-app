
import 'package:hive/hive.dart';
import 'package:movie_booking_app/persistance/hive_constant.dart';

import '../../data/vos/cast_crew_vo/cast_crew_vo.dart';

class ActorDAO{
  ActorDAO.internal();

  static final ActorDAO _singleton=ActorDAO.internal();

  factory ActorDAO()=>_singleton;

  void saveActors(int movieID,CastCrewVO actorList){
    getActorBox().put(movieID,actorList);

    print('Saved actors');
    print('');
  }

  CastCrewVO? getActorListByID(int movieID) {
   return getActorBox().get(movieID);
  }

  Box<CastCrewVO>getActorBox()=>Hive.box<CastCrewVO>(BOX_NAME_ACTOR_VO);

  Stream<void>getActorStream(){
    print('Watch Actor Stream');
    print('');
    return getActorBox().watch();
  }

  Stream<CastCrewVO?>getAllActorStream(int movieID)=>Stream.value(getActorListByID(movieID));

}