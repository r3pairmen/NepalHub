import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/constants/app_constants.dart';
import 'package:samachar_hub/core/utils/date_time_utils.dart';
import 'package:samachar_hub/feature_auth/presentation/blocs/auth_bloc.dart';
import 'package:samachar_hub/feature_main/presentation/models/home/home_model.dart';
import 'package:samachar_hub/feature_main/presentation/ui/home/widgets/corona_section.dart';
import 'package:samachar_hub/feature_main/presentation/ui/home/widgets/date_weather_section.dart';
import 'package:samachar_hub/feature_main/presentation/ui/home/widgets/daily_horoscope_section.dart';
import 'package:samachar_hub/feature_main/presentation/ui/home/widgets/latest_news_section.dart';
import 'package:samachar_hub/feature_main/presentation/ui/home/widgets/news_category_menu_section.dart';
import 'package:samachar_hub/feature_main/presentation/ui/home/widgets/news_source_menu_section.dart';
import 'package:samachar_hub/feature_main/presentation/ui/home/widgets/recent_news_section.dart';
import 'package:samachar_hub/feature_main/presentation/ui/home/widgets/trending_news_section.dart';

class HomeListBuilder extends StatelessWidget {
  final HomeUIModel data;
  final Future<void> Function() onRefresh;
  final ScrollController scrollController;

  const HomeListBuilder(
      {Key key,
      @required this.data,
      @required this.onRefresh,
      @required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.bloc<AuthBloc>().currentUser;
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            sliver: SliverAppBar(
              elevation: 0,
              forceElevated: false,
              backgroundColor: Theme.of(context).backgroundColor,
              title: RichText(
                  text: TextSpan(
                text: AppConstants.APP_NAME,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.w800),
                children: [
                  if (user != null && !user.isAnonymous)
                    TextSpan(
                        text:
                            '\nGood ${timeContextGreeting()} ${user.fullname}',
                        style: Theme.of(context).textTheme.caption),
                ],
              )),
              pinned: false,
              floating: true,
            ),
          ),
          SliverToBoxAdapter(child: DateWeatherSection()),
          if (data.hasCoronaData)
            SliverToBoxAdapter(
              child: CoronaSection(
                data: data.coronaUIModel,
              ),
            ),
          if (isEarlyMorning() && data.shouldShowDailyHoroscopeSection)
            SliverToBoxAdapter(child: DailyHoroscope()),
          if (data.hasTrendingNews)
            SliverToBoxAdapter(
                child: TrendingNewsSection(
              trendingNewsUIModel: data.trendingNewsUIModel,
            )),
          if (data.shouldShowNewsCategorySection)
            SliverToBoxAdapter(
                child: NewsCategoryMenuSection(
              homeUIModel: data,
            )),
          if (data.hasRecentNews)
            RecentNewsSection(
              recentNewsUIModel: data.recentNewsUIModel,
            ),
          if (data.shouldShowNewsSourceSection)
            SliverToBoxAdapter(
                child: NewsSourceMenuSection(
              homeUIModel: data,
            )),
          if (data.hasLatestNews)
            LatestNewsSection(
              latestNewsUIModel: data.latestNewsUIModel,
            ),
        ],
      ),
    );
  }
}
