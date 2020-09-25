import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/bookmarks/bookmark_unbookmark/bookmark_un_bookmark_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/dislike/dislike_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/share/share_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/report_article.dart';
import 'package:samachar_hub/utils/extensions.dart';

class NewsFeedMoreOption extends StatelessWidget {
  final NewsFeedUIModel feed;

  const NewsFeedMoreOption({
    Key key,
    @required this.feed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            visualDensity: VisualDensity.compact,
            title: Text(
              '${feed.feed.source.title}',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            trailing: BlocBuilder<FollowUnFollowBloc, FollowUnFollowState>(
                builder: (context, state) {
              if (state is FollowedState) {
                feed.followSource();
              } else if (state is UnFollowedState) {
                feed.unfollowSource();
              }
              return OutlineButton.icon(
                icon: state is InProgressState
                    ? Icon(
                        Icons.donut_large,
                        color: Theme.of(context).accentColor,
                        size: 16,
                      )
                    : Icon(
                        feed.feed.source.isFollowed ? Icons.check : Icons.add,
                        size: 16,
                      ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(12),
                  right: Radius.circular(12),
                )),
                visualDensity: VisualDensity.compact,
                onPressed: () {
                  final value = feed.feed.source.isFollowed;
                  if (value)
                    context
                        .bloc<FollowUnFollowBloc>()
                        .add(UnFollowEvent(sourceModel: feed.feed.source));
                  else
                    context
                        .bloc<FollowUnFollowBloc>()
                        .add(FollowEvent(sourceModel: feed.feed.source));
                  Navigator.pop(context);
                },
                label:
                    Text(feed.feed.source.isFollowed ? 'Following' : 'Follow'),
              );
            }),
          ),
          Divider(),
          BlocBuilder<BookmarkUnBookmarkBloc, BookmarkUnBookmarkState>(
              builder: (context, state) {
            if (state is BookmarkSuccess) {
              feed.bookmark();
            } else if (state is UnbookmarkSuccess) {
              feed.unbookmark();
            }
            return ListTile(
              visualDensity: VisualDensity.compact,
              leading: Icon(
                Icons.save_alt,
                size: 18,
              ),
              title: Text(
                feed.feed.isBookmarked ? 'Remove bookmark' : 'Bookmark',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              trailing: state is BookmarkInProgress
                  ? Icon(
                      Icons.donut_large,
                      color: Theme.of(context).accentColor,
                      size: 16,
                    )
                  : null,
              onTap: () {
                final value = feed.feed.isBookmarked;
                if (value)
                  context
                      .bloc<BookmarkUnBookmarkBloc>()
                      .add(UnBookmarkNews(feedModel: feed));
                else
                  context
                      .bloc<BookmarkUnBookmarkBloc>()
                      .add(BookmarkNews(feedModel: feed));
                Navigator.pop(context);
              },
            );
          }),
          ListTile(
            visualDensity: VisualDensity.compact,
            leading: Icon(
              Icons.share,
              size: 18,
            ),
            title: Text(
              'Share',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            onTap: () {
              context.bloc<ShareBloc>().add(Share(feedModel: feed));
              Navigator.pop(context);
            },
          ),
          ListTile(
            visualDensity: VisualDensity.compact,
            leading: Icon(
              Icons.open_in_browser,
              size: 18,
            ),
            title: Text(
              'Browse ${feed.feed.source.title}',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            onTap: () {
              Navigator.pop(context);
              context.repository<NavigationService>().toNewsSourceFeedScreen(
                  source: feed.feed.source, context: context);
            },
          ),
          ListTile(
            visualDensity: VisualDensity.compact,
            leading: Icon(
              Icons.remove_circle_outline,
              size: 18,
            ),
            title: Text(
              'Block ${feed.feed.source.title}',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            visualDensity: VisualDensity.compact,
            leading: Icon(
              Icons.thumb_down,
              size: 18,
            ),
            title: Text(
              'Show less of such content',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            onTap: () {
              context.bloc<DislikeBloc>().add(DislikeEvent(feedModel: feed));
              Navigator.pop(context);
            },
          ),
          ListTile(
            visualDensity: VisualDensity.compact,
            leading: Icon(
              Icons.report,
              size: 18,
            ),
            title: Text(
              'Report',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            onTap: () {
              // Navigator.pop(context);
              context.showBottomSheet(
                child: ReportArticle(
                  articleId: feed.feed.id,
                  articleType: 'news',
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
