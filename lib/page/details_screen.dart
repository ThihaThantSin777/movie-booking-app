import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_booking_app/bloc/details_bloc.dart';
import 'package:movie_booking_app/data/modle/movie_booking_model.dart';
import 'package:movie_booking_app/data/modle/movie_booking_model_impl.dart';
import 'package:movie_booking_app/data/vos/cast_crew_vo/cast_crew_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo/movie_vo.dart';
import 'package:movie_booking_app/network/api_constant/api_constant.dart';
import 'package:movie_booking_app/page/home_screen.dart';
import 'package:movie_booking_app/page/pick_time_and_cinema_screen.dart';
import 'package:movie_booking_app/resources/dimension.dart';
import 'package:movie_booking_app/resources/strings.dart';
import 'package:movie_booking_app/widgets/back_button_widget.dart';
import 'package:movie_booking_app/widgets/button_text_widget.dart';
import 'package:movie_booking_app/widgets/button_widget.dart';
import 'package:movie_booking_app/widgets/header_title.dart';
import 'package:provider/provider.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieID;

  MovieDetailsScreen({
    required this.movieID,
  });

  final String unKnownUrl =
      'https://cdn4.iconfinder.com/data/icons/political-elections/50/48-1024.png';

  _navigatorToSeatingChartView(context, movieVO) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return PickTimeAndCinema(
        movieVO: movieVO,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailsBloc(movieID),
      child: Selector<DetailsBloc, MovieVO?>(
          selector: (_, bloc) => bloc.getMovieVO,
          builder: (_, movieVO, child) => Scaffold(
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.only(bottom: medium_large_2x),
                  child: PinnedButtonView(
                    onClick: () =>
                        _navigatorToSeatingChartView(context, movieVO),
                  ),
                ),
                body: movieVO == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomScrollView(
                        slivers: [
                          SliverAppBar(
                            automaticallyImplyLeading: false,
                            backgroundColor: Colors.transparent,
                            expandedHeight: sliver_app_bar_height,
                            flexibleSpace: FlexibleSpaceBar(
                                collapseMode: CollapseMode.pin,
                                background: Stack(
                                  children: [
                                    Positioned.fill(
                                        child: SliverAppBarImageView(
                                            imageUrl: movieVO.posterPath == null
                                                ? unKnownUrl
                                                : '$BASE_IMAGE_URL${movieVO.posterPath}')),
                                    const Align(
                                      alignment: Alignment.bottomCenter,
                                      child: BorderOnlyView(),
                                    ),
                                    const Align(
                                      alignment: Alignment.center,
                                      child: PlayButtonView(),
                                    ),
                                    const Positioned(
                                        top: back_button_size,
                                        child: BackButtonView()),
                                  ],
                                )),
                          ),
                          Selector<DetailsBloc, List<CastCrewVO>?>(
                            selector: (_, bloc) => bloc.getCastCrewVO,
                            builder: (_, castCrewVO, child) => SliverList(
                                delegate: SliverChildListDelegate([
                              castCrewVO?.isEmpty ?? true
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : MovieDetailsBodyView(
                                      title:
                                          movieVO.originalTitle ?? "Un Known",
                                      runtime:
                                          '${movieVO.runtime.toString()} m',
                                      imd: movieVO.voteAverage.toString(),
                                      type: movieVO.getGenreListAsStringList(),
                                      moviePlotSummary:
                                          movieVO.overview ?? 'Default',
                                      castCrewVO: castCrewVO ?? [],
                                    )
                            ])),
                          )
                        ],
                      ),
              )),
    );
  }
}

class MovieDetailsBodyView extends StatelessWidget {
  final String title;
  final String runtime;
  final String imd;
  final List<String> type;
  final String moviePlotSummary;
  final List<CastCrewVO> castCrewVO;

  MovieDetailsBodyView({
    required this.title,
    required this.runtime,
    required this.imd,
    required this.type,
    required this.moviePlotSummary,
    required this.castCrewVO,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: MovieDetailsColumnView(
        title: title,
        runtime: runtime,
        imd: imd,
        type: type,
        moviePlotSummary: moviePlotSummary,
        castCrewVO: castCrewVO,
      ),
    );
  }
}

class MovieDetailsColumnView extends StatelessWidget {
  const MovieDetailsColumnView({
    Key? key,
    required this.title,
    required this.runtime,
    required this.imd,
    required this.type,
    required this.moviePlotSummary,
    required this.castCrewVO,
  }) : super(key: key);

  final String title;
  final String runtime;
  final String imd;
  final List<String> type;
  final String moviePlotSummary;
  final List<CastCrewVO> castCrewVO;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: margin_small_2x),
          child: MovieTitleView(title: title),
        ),
        const SizedBox(
          height: spacing_micro_1x,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: margin_small_2x),
          child: RatingAndRuntimeView(runtime: runtime, imd: imd),
        ),
        const SizedBox(
          height: spacing_micro_1x,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: margin_small_2x),
          child: MovieTypeView(type: type),
        ),
        const SizedBox(height: margin_medium),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: margin_small_2x),
          child: PlotSummaryBodyView(moviePlotSummary: moviePlotSummary),
        ),
        const SizedBox(height: margin_medium),
        ActorAndTitleView(
          castCrewVO: castCrewVO,
        ),
        const SizedBox(height: margin_medium),
      ],
    );
  }
}

class ActorAndTitleView extends StatelessWidget {
  ActorAndTitleView({required this.castCrewVO});

  final List<CastCrewVO> castCrewVO;
  final String unKnownUrl =
      'https://cdn4.iconfinder.com/data/icons/political-elections/50/48-1024.png';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: margin_small_2x),
          child: HeaderTitle(
              title: cast,
              fontSize: regular_text_2x,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: margin_medium),
        Container(
          height: MediaQuery.of(context).size.height / 8,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: castCrewVO.length,
              itemBuilder: (context, index) {
                return ActorsView(
                    imageUrl: castCrewVO[index].profilePath == null
                        ? unKnownUrl
                        : '$BASE_IMAGE_URL${castCrewVO[index].profilePath}',
                    actorName: castCrewVO[index].originalName ?? "");
              }),
        )
      ],
    );
  }
}

class ActorsView extends StatelessWidget {
  final String imageUrl;
  final String actorName;

  ActorsView({required this.imageUrl, required this.actorName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.only(right: margin_small_2x, left: margin_small_1x),
      child: Column(
        children: [
          CircleImageActorView(imageUrl: imageUrl),
          const SizedBox(height: spacing_micro_1x),
          ActorNameView(actorName: actorName),
        ],
      ),
    );
  }
}

class ActorNameView extends StatelessWidget {
  const ActorNameView({
    Key? key,
    required this.actorName,
  }) : super(key: key);

  final String actorName;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        actorName,
        textAlign: TextAlign.center,
        style:
            const TextStyle(fontSize: text_medium, fontWeight: FontWeight.w800),
      ),
    );
  }
}

class CircleImageActorView extends StatelessWidget {
  const CircleImageActorView({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CircleImageView(
      urlImage: imageUrl,
      isNetworkImage: true,
      size: image_circle_container_size_1x,
    );
  }
}

class PlotSummaryBodyView extends StatelessWidget {
  const PlotSummaryBodyView({
    Key? key,
    required this.moviePlotSummary,
  }) : super(key: key);

  final String moviePlotSummary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PlotSummaryTitleView(),
        const SizedBox(
          height: spacing_micro_1x,
        ),
        PlotSummaryDescView(moviePlotSummary: moviePlotSummary),
      ],
    );
  }
}

class PlotSummaryDescView extends StatelessWidget {
  const PlotSummaryDescView({
    Key? key,
    required this.moviePlotSummary,
  }) : super(key: key);

  final String moviePlotSummary;

  @override
  Widget build(BuildContext context) {
    return Text(
      moviePlotSummary,
      style: const TextStyle(fontSize: text_medium_1x),
    );
  }
}

class PlotSummaryTitleView extends StatelessWidget {
  const PlotSummaryTitleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PlotSummaryTextView();
  }
}

class PlotSummaryTextView extends StatelessWidget {
  const PlotSummaryTextView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HeaderTitle(
        title: plot_summary,
        fontSize: text_large_1x,
        fontWeight: FontWeight.w500);
  }
}

class MovieTypeView extends StatelessWidget {
  const MovieTypeView({
    Key? key,
    required this.type,
  }) : super(key: key);

  final List<String> type;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: type
          .map((chipText) => Container(
                margin: const EdgeInsets.only(
                    right: border_radius_size, top: spacing_micro_1x),
                child: MovieTypeChipView(chipText),
              ))
          .toList(),
    );
  }
}

class MovieTypeChipView extends StatelessWidget {
  final String chipText;

  MovieTypeChipView(this.chipText);

  @override
  Widget build(BuildContext context) {
    return Chip(
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.black12),
            borderRadius:
                BorderRadius.all(Radius.circular(chip_border_radius_size))),
        padding: const EdgeInsets.all(margin_small_2x),
        backgroundColor: Colors.white,
        label: ChipLabelTextView(chipText: chipText));
  }
}

class ChipLabelTextView extends StatelessWidget {
  const ChipLabelTextView({
    Key? key,
    required this.chipText,
  }) : super(key: key);

  final String chipText;

  @override
  Widget build(BuildContext context) {
    return Text(
      chipText,
      style: const TextStyle(fontSize: text_medium),
    );
  }
}

class RatingAndRuntimeView extends StatelessWidget {
  const RatingAndRuntimeView({
    Key? key,
    required this.runtime,
    required this.imd,
  }) : super(key: key);

  final String runtime;
  final String imd;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RunTimeView(runtime: runtime),
        const SizedBox(
          width: spacing_micro_1x,
        ),
        const RatingLevel(),
        const SizedBox(
          width: spacing_micro_1x,
        ),
        IMDBView(imd: imd),
      ],
    );
  }
}

class IMDBView extends StatelessWidget {
  const IMDBView({
    Key? key,
    required this.imd,
  }) : super(key: key);

  final String imd;

  @override
  Widget build(BuildContext context) {
    return Text(
      imd,
      style: const TextStyle(fontSize: regular_text),
    );
  }
}

class RunTimeView extends StatelessWidget {
  const RunTimeView({
    Key? key,
    required this.runtime,
  }) : super(key: key);

  final String runtime;

  @override
  Widget build(BuildContext context) {
    return Text(
      runtime,
      style: const TextStyle(fontSize: regular_text),
    );
  }
}

class RatingLevel extends StatelessWidget {
  const RatingLevel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: 5,
      direction: Axis.horizontal,
      itemSize: rating_star_size,
      itemBuilder: (BuildContext context, int index) {
        if (index >= 3) {
          return const Icon(
            Icons.star_half,
            color: Colors.amber,
          );
        } else {
          return const Icon(
            Icons.star,
            color: Colors.amber,
          );
        }
      },
      onRatingUpdate: (rating) {

      },
    );
  }
}

class MovieTitleView extends StatelessWidget {
  const MovieTitleView({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return HeaderTitle(
        title: title, fontSize: regular_text, fontWeight: FontWeight.bold);
  }
}

class PinnedButtonView extends StatelessWidget {
  final Function onClick;

  PinnedButtonView({required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: margin_small_2x),
        child: ButtonWidget(
            onClick: () => onClick(), child: ButtonTextView(get_your_ticket)));
  }
}

class PlayButtonView extends StatelessWidget {
  const PlayButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.play_circle_outline,
      color: Colors.white70,
      size: play_button_size,
    );
  }
}

class BorderOnlyView extends StatelessWidget {
  const BorderOnlyView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: border_only_view_height,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(border_top_left_and_top_right),
            topRight: Radius.circular(border_top_left_and_top_right),
          )),
    );
  }
}

class SliverAppBarImageView extends StatelessWidget {
  const SliverAppBarImageView({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
    );
  }
}
