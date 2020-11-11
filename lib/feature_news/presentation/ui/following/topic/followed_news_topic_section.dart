import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_topic/news_topic_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/following/topic/followed_news_topic_list.dart';
import 'package:samachar_hub/feature_news/presentation/ui/following/widgets/section_title.dart';
import 'package:samachar_hub/feature_news/presentation/ui/following/widgets/view_all_button.dart';
import 'package:samachar_hub/feature_news/presentation/ui/topics/topics/topics_screen.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';

class FollowedNewsTopicSection extends StatelessWidget {
  const FollowedNewsTopicSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NewsProvider.topicBlocProvider(
      child: Builder(
        builder: (context) => FadeInUp(
          duration: Duration(milliseconds: 200),
          child: Card(
            color: Theme.of(context).cardColor,
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SectionTitle(
                    context: context,
                    title: 'News Topics',
                    onRefreshTap: () {
                      context
                          .read<NewsTopicBloc>()
                          .add(GetFollowedTopicsEvent());
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: FollowedNewsTopicList(),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  // Divider(),
                  ViewAllButton(
                      context: context,
                      onTap: () {
                        Navigator.pushNamed(
                            context, NewsTopicsScreen.ROUTE_NAME);
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
