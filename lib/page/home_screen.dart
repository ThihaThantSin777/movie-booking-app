import 'package:flutter/material.dart';
import 'package:movie_booking_app/bloc/home_bloc.dart';
import 'package:movie_booking_app/config/config_values.dart';
import 'package:movie_booking_app/config/environment_config.dart';
import 'package:movie_booking_app/data/vos/movie_vo/movie_vo.dart';
import 'package:movie_booking_app/data/vos/user_vo/user_vo.dart';
import 'package:movie_booking_app/network/api_constant/api_constant.dart';
import 'package:movie_booking_app/page/details_screen.dart';
import 'package:movie_booking_app/page/login_sigin_screen.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimension.dart';
import 'package:movie_booking_app/resources/strings.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final List<String> menuItems = [
    'Promotion code',
    'Select a language',
    'Terms of abstraction_layer',
    'Help',
    'Rate us'
  ];
  final List<Tab> tabsItems = [
    const Tab(
      text: now_showing,
    ),
    const Tab(
      text: coming_soon,
    ),
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  _showResult(message, subMessage, context) {
    _showALertBox(context, message, subMessage);
  }

  _showALertBox(context, String message, String subMessage) async {
    bool status = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message),
            content: Text(subMessage),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(message == 'Error' ? false : true);
                  },
                  child: const Text('OK'))
            ],
          );
        });

    if (status) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return const LoginSiginScreen();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool? cond = IS_GLAXY_MOVIE_DESIGN_VIEW[
        EnvironmentConfig.CONFIG_IS_GALAXY_APP_DESIGN];
    return ChangeNotifierProvider(
      create: (_) => HomeBloc(),
      child: Selector<HomeBloc, UserVO?>(
        selector: (_, bloc) => bloc.getUser,
        builder: (_, user, child) => Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            child: DrawerSessionView(
              onTapBack: () {
                Navigator.of(context).pop();
              },
              menuItems: menuItems,
              userVO: user ?? UserVO.normal(),
              onTap: () {
                HomeBloc homeBloc = Provider.of(_, listen: false);
                homeBloc.logout().then((value) {
                  homeBloc.deleteUserData();
                  _showResult('Success', value?.message, context);
                }).catchError((error) {
                  _showResult('Error', 'Logout Fail', context);
                });
              },
            ),
          ),
          backgroundColor: white_color,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: GestureDetector(
                key: const Key('Open Drawer Key'),
                onTap: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                child: Image.asset('images/menu.png')),
            actions: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: margin_small_2x),
                child: Icon(
                  Icons.search,
                  color: black_color,
                  size: search_icon_size,
                ),
              )
            ],
          ),
          body: ListView(
            children: [
              const SizedBox(
                height: spacing_micro_1x,
              ),
              HomeScreenTitleSession(
                userVO: user ?? UserVO.normal(),
              ),
              const SizedBox(
                height: margin_medium,
              ),
              cond ?? false
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Selector<HomeBloc, List<MovieVO>?>(
                          selector: (_, bloc) => bloc.getNowPlayingVO,
                          builder: (_, getNowPlayingVO, child) =>
                              getNowPlayingVO == null
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : MovieBodyView(
                                      movieList: getNowPlayingVO,
                                      onClick: (id) =>
                                          _navigateToMovieDetailsScreen(
                                              context, id ?? 0),
                                      title: now_showing,
                                    ),
                        ),
                        Selector<HomeBloc, List<MovieVO>?>(
                          selector: (_, bloc) => bloc.getComingSoonVO,
                          builder: (_, getComingSoonVO, child) =>
                              getComingSoonVO == null
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : MovieBodyView(
                                      movieList: getComingSoonVO,
                                      onClick: (id) =>
                                          _navigateToMovieDetailsScreen(
                                              context, id ?? 0),
                                      title: coming_soon,
                                    ),
                        ),
                      ],
                    )
                  : DefaultTabController(
                      length: tabsItems.length,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TabBar(
                            tabs: tabsItems,
                            unselectedLabelColor: Colors.grey,
                            labelColor: Colors.black,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.9,
                            child: TabBarView(
                              children: [
                                Selector<HomeBloc, List<MovieVO>?>(
                                  selector: (_, bloc) => bloc.getNowPlayingVO,
                                  builder: (_, getNowPlayingVO, child) =>
                                      getNowPlayingVO == null
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : MovieBodyView(
                                              movieList: getNowPlayingVO,
                                              onClick: (id) =>
                                                  _navigateToMovieDetailsScreen(
                                                      context, id ?? 0),
                                              title: now_showing,
                                            ),
                                ),
                                Selector<HomeBloc, List<MovieVO>?>(
                                  selector: (_, bloc) => bloc.getComingSoonVO,
                                  builder: (_, getComingSoonVO, child) =>
                                      getComingSoonVO == null
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : MovieBodyView(
                                              movieList: getComingSoonVO,
                                              onClick: (id) =>
                                                  _navigateToMovieDetailsScreen(
                                                      context, id ?? 0),
                                              title: coming_soon,
                                            ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))
            ],
          ),
        ),
      ),
    );
  }

  _navigateToMovieDetailsScreen(context, int movieID) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return MovieDetailsScreen(
        movieID: movieID,
      );
    }));
  }
}

class HomeScreenTitleSession extends StatelessWidget {
  HomeScreenTitleSession({
    Key? key,
    required this.userVO,
  }) : super(key: key);
  final UserVO userVO;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: margin_small_2x),
      child: Row(
        children: [
          CircleImageView(
            urlImage: 'images/people.jpg',
          ),
          const SizedBox(
            width: margin_medium,
          ),
          TextView(userVO)
        ],
      ),
    );
  }
}

class TextView extends StatelessWidget {
  final UserVO userVO;

  TextView(this.userVO);

  @override
  Widget build(BuildContext context) {
    return Text('Hi ${userVO.name}!',
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: regular_text_1x));
  }
}

class CircleImageView extends StatelessWidget {
  final double size;
  final bool isNetworkImage;
  final String urlImage;

  CircleImageView({
    this.size = image_circle_container_size,
    this.isNetworkImage = false,
    required this.urlImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: isNetworkImage
              ? DecorationImage(
                  image: NetworkImage(urlImage), fit: BoxFit.cover)
              : DecorationImage(image: AssetImage(urlImage), fit: BoxFit.cover),
        ));
  }
}

class MovieBodyView extends StatelessWidget {
  final List<MovieVO> movieList;
  final Function(int?) onClick;
  final String title;

  MovieBodyView(
      {required this.movieList, required this.onClick, required this.title});

  @override
  Widget build(BuildContext context) {
    bool? cond = IS_GLAXY_MOVIE_DESIGN_VIEW[
        EnvironmentConfig.CONFIG_IS_GALAXY_APP_DESIGN];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(visible: (cond ?? false), child: MovieBodyTitleView(title)),
        const SizedBox(
          height: margin_medium,
        ),
        NowShowingAndCommingSoonView(
            movieVO: movieList, onClick: (id) => onClick(id)),
      ],
    );
  }
}

class MovieBodyTitleView extends StatelessWidget {
  final String title;

  MovieBodyTitleView(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: margin_small_2x),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: regular_text_1x, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class NowShowingAndCommingSoonView extends StatelessWidget {
  final List<MovieVO> movieVO;
  final Function(int?) onClick;

  NowShowingAndCommingSoonView({required this.movieVO, required this.onClick});

  @override
  Widget build(BuildContext context) {
    bool? cond = IS_GLAXY_MOVIE_DESIGN_VIEW[
        EnvironmentConfig.CONFIG_IS_GALAXY_APP_DESIGN];
    return (cond ?? false)
        ? SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2.9,
            child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: margin_small_2x),
                scrollDirection: Axis.horizontal,
                itemCount: movieVO.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () => onClick(movieVO[index].id),
                      child: MoviesView(movieVO[index]));
                }))
        : SizedBox(
      height: MediaQuery.of(context).size.height *0.9,
          child: GridView.builder(

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3/4.5
              ),
              itemCount: movieVO.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () => onClick(movieVO[index].id),
                    child: MoviesView(movieVO[index]));
              }),
        );
  }
}

class MoviesView extends StatelessWidget {
  final MovieVO movieVO;
  final String unKnownUrl =
      'https://cdn4.iconfinder.com/data/icons/political-elections/50/48-1024.png';

  MoviesView(this.movieVO);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MovieLayoutView(movieVO.posterPath == null
            ? unKnownUrl
            : '$BASE_IMAGE_URL${movieVO.posterPath}'),
        const SizedBox(
          height: margin_small_3x,
        ),
        MovieNameView(movieVO.originalTitle ?? 'Un Known'),
        MovieRuntimeAndCategory('Action, Scific, 69m')
      ],
    );
  }
}

class MovieRuntimeAndCategory extends StatelessWidget {
  final String movieRuntimeAndCategory;

  MovieRuntimeAndCategory(this.movieRuntimeAndCategory);

  @override
  Widget build(BuildContext context) {
    return Text(
      movieRuntimeAndCategory,
      style: const TextStyle(color: Colors.black45),
    );
  }
}

class MovieNameView extends StatelessWidget {
  final String movieName;

  MovieNameView(this.movieName);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: movie_text_size_width,
      height: movie_text_size_height,
      child: Text(
        movieName,
        style:
            const TextStyle(fontSize: text_small, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class MovieLayoutView extends StatelessWidget {
  final String movieImageUrl;

  MovieLayoutView(this.movieImageUrl);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(border_radius_size),
      ),
      elevation: card_elevation,
      child: Container(
          width: movie_details_width,
          height: movie_details_height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(border_radius_size),
          ),
          child: MovieImageView(movieImageUrl)),
    );
  }
}

class MovieImageView extends StatelessWidget {
  final String movieImageUrl;

  MovieImageView(this.movieImageUrl);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      movieImageUrl,
      fit: BoxFit.cover,
    );
  }
}

class DrawerSessionView extends StatelessWidget {
  const DrawerSessionView({
    Key? key,
    required this.menuItems,
    required this.userVO,
    required this.onTap,
    required this.onTapBack,
  }) : super(key: key);

  final List<String> menuItems;
  final UserVO userVO;
  final Function onTap;
  final Function onTapBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: spacing_micro_1x),
      color: main_screen_color,
      child: Column(
        children: [
          const SizedBox(height: profile_spacing),
          DrawerHeaderSessionView(
            userVO: userVO,
          ),
          const SizedBox(height: margin_medium_3x),
          DrawerMenuListView(
            menuItems: menuItems,
            onTap: () => onTapBack(),
          ),
          const Spacer(),
          LogOutView(
            onTap: () => onTap(),
          ),
          const SizedBox(
            height: margin_medium_2x,
          ),
        ],
      ),
    );
  }
}

class LogOutView extends StatelessWidget {
  const LogOutView({Key? key, required this.onTap}) : super(key: key);
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap(),
      leading: const Icon(
        Icons.logout,
        color: Colors.white,
        size: text_large_1x,
      ),
      title: const Text(
        'Log out',
        style: TextStyle(color: Colors.white, fontSize: regular_text),
      ),
    );
  }
}

class DrawerMenuListView extends StatelessWidget {
  const DrawerMenuListView({
    Key? key,
    required this.menuItems,
    required this.onTap,
  }) : super(key: key);

  final List<String> menuItems;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: menuItems
            .map((menuText) => Container(
                  margin: const EdgeInsets.only(top: margin_small_3x),
                  child: ListTile(
                    onTap: () => onTap(),
                    leading: const Icon(
                      Icons.help,
                      color: Colors.white,
                      size: text_large_1x,
                    ),
                    title: Text(
                      menuText,
                      style: const TextStyle(
                          color: Colors.white, fontSize: text_medium_2x),
                    ),
                  ),
                ))
            .toList());
  }
}

class DrawerHeaderSessionView extends StatelessWidget {
  DrawerHeaderSessionView({Key? key, required this.userVO}) : super(key: key);
  final UserVO userVO;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleImageView(urlImage: 'images/people.jpg'),
        const SizedBox(
          width: spacing_micro_1x,
        ),
        NameAndEmailEditSessionView(userVO)
      ],
    );
  }
}

class NameAndEmailEditSessionView extends StatelessWidget {
  final UserVO userVO;

  NameAndEmailEditSessionView(this.userVO);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userVO.name.toString(),
            style: const TextStyle(
                fontSize: text_medium_2x,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: spacing_micro_1x,
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  userVO.email.toString(),
                  style: const TextStyle(
                      fontSize: text_medium, color: Colors.white),
                ),
              ),
              const SizedBox(
                width: medium_large_4x,
              ),
              const Text(
                'Edit',
                style: TextStyle(fontSize: text_medium, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
