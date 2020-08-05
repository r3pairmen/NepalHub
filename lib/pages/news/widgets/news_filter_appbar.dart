import 'package:flutter/material.dart';
import 'package:samachar_hub/data/models/news_model.dart';
import 'package:samachar_hub/data/models/sort.dart';
import 'package:samachar_hub/pages/news/widgets/news_filter_widget.dart';
import 'package:samachar_hub/pages/news/widgets/news_filter_header.dart';

class NewsFilteringAppBar extends StatelessWidget {
  const NewsFilteringAppBar({
    Key key,
    @required this.child,
    @required this.title,
    @required this.icon,
    @required this.sources,
    @required this.followUnFollowButton,
    @required this.onSourceChanged,
    @required this.onSortByChanged,
    this.initialSortBy,
    this.initialSource,
  }) : super(key: key);

  final Widget child;
  final String title;
  final DecorationImage icon;
  final List<NewsSource> sources;
  final Widget followUnFollowButton;
  final Function(NewsSource) onSourceChanged;
  final Function(SortBy) onSortByChanged;
  final SortBy initialSortBy;
  final NewsSource initialSource;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
            leading: BackButton(
              color: Theme.of(context).textTheme.button.color,
            ),
            expandedHeight: 210,
            pinned: true,
            floating: true,
            snap: true,
            forceElevated: true,
            backgroundColor: Theme.of(context).backgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: NewsFilterHeader(
                icon: icon,
                followUnFollowButton: followUnFollowButton,
                title: title,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: NewsFilterView(
                onSortChanged: onSortByChanged,
                onSourceChanged: onSourceChanged,
                sources: sources,
                initialSortBy: initialSortBy,
                initialSource: initialSource,
              ),
            )),
      ],
      body: child,
    );
  }
}
