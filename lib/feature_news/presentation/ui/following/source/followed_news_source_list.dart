import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/widgets/empty_data_widget.dart';
import 'package:samachar_hub/core/widgets/error_data_widget.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/news_sources_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_menu_item.dart';
import 'package:samachar_hub/utils/extensions.dart';

class FollowedNewsSourceList extends StatefulWidget {
  const FollowedNewsSourceList({
    Key key,
  }) : super(key: key);

  @override
  _FollowedNewsSourceListState createState() => _FollowedNewsSourceListState();
}

class _FollowedNewsSourceListState extends State<FollowedNewsSourceList> {
  NewsSourceBloc _newsSourceBloc;

  @override
  void initState() {
    super.initState();
    _newsSourceBloc = context.bloc<NewsSourceBloc>();
    _newsSourceBloc.add(GetFollowedSourcesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsSourceBloc, NewsSourceState>(
      cubit: _newsSourceBloc,
      listener: (context, state) {
        if (state is ErrorState) {
          context.showMessage(state.message);
        }
      },
      builder: (context, state) {
        if (state is LoadSuccessState) {
          return FadeInUp(
            duration: Duration(milliseconds: 200),
            child: LimitedBox(
              maxHeight: 100,
              child: ListView.builder(
                primary: false,
                itemExtent: 120,
                scrollDirection: Axis.horizontal,
                itemCount: state.sources.length,
                itemBuilder: (_, index) {
                  var sourceModel = state.sources[index];
                  return NewsMenuItem(
                    title: sourceModel.source.title,
                    icon: sourceModel.source.icon,
                    onTap: () {
                      context
                          .repository<NavigationService>()
                          .toNewsSourceFeedScreen(
                              context: context, source: sourceModel.source);
                    },
                  );
                },
              ),
            ),
          );
        } else if (state is ErrorState) {
          return Center(
            child: ErrorDataView(
              message: state.message,
              onRetry: () {
                _newsSourceBloc.add(GetFollowedSourcesEvent());
              },
            ),
          );
        } else if (state is EmptyState) {
          return Center(
            child: EmptyDataView(
              text: state.message,
            ),
          );
        }
        return Center(child: ProgressView());
      },
    );
  }
}
