import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/colors.dart';

Map<String,dynamic> THEME_COLORS = {
  "COLOR_MOVIE_BOOKING_APP_PRIMARY": main_screen_color,
  "COLOR_MOVIE_BOOKING_APP_BLACK": const Color.fromRGBO(22,28,36,1.0),
};
Map<String,bool> IS_GLAXY_MOVIE_APP = {
  "IS_GALAXY_MOVIE_BOOKING_APP": true,
  "IS_MOVIE_BOOKING_APP_BLACK": false,
};
Map<String,bool> IS_GLAXY_MOVIE_DESIGN_VIEW = {
  "IS_GALAXY_MOVIE_DESIGN_VIEW": true,
  "IS_MOVIE_BOOKING_APP_DESIGN_VIEW": false,
};

Map<String,bool> IS_ACTOR_ROW_VIEW = {
  "IS_GALAXY_MOVIE_ACTOR_VIEW": true,
  "IS_MOVIE_BOOKING_APP_ACTOR_VIEW": false,
};

Map<String,dynamic> SEAT_COLOR = {
  "GALAXY_MOVIE_SEAT_COLOR": main_screen_color,
  "MOVIE_BOOKING_APP_ACTOR_VIEW": const Color.fromRGBO(22,28,36,1.0),
};
Map<String,bool> IS_CARD_CAROUSAL_VIEW= {
  "IS_GALAXY_MOVIE_CARD_CAROUSAL_VIEW": true,
  "IS_MOVIE_BOOKING_APP_CARD_CAROUSAL_VIEW": false,
};