import 'package:flutter/material.dart';
import 'package:samachar_hub/core/widgets/sortby_selector.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_source_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/sort.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_filter/news_filter_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_sources_selector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsFilterView extends StatelessWidget {
  NewsFilterView(
      {Key key,
      @required this.sources,
      @required this.selectedSource,
      @required this.selectedSortby})
      : super(key: key);

  final List<NewsSourceEntity> sources;
  final NewsSourceEntity selectedSource;
  final SortBy selectedSortby;

  Map<String, String> _getSourceSelectors() {
    Map<String, String> sourceOptions = {};
    sourceOptions['all'] = 'All Sources';
    sources?.forEach(
      (element) => sourceOptions[element.code] = element.title,
    );
    return sourceOptions;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.5, color: Theme.of(context).dividerColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                      width: 0.5, color: Theme.of(context).dividerColor),
                ),
              ),
              child: NewsSourcesSelector(
                onChanged: (value) {
                  final changedSourceModel = sources?.firstWhere(
                    (element) => element.code == value,
                    orElse: () => null,
                  );
                  context.read<NewsFilterBloc>().add(
                      NewsFilterSourceChangedEvent(source: changedSourceModel));
                },
                selections: this._getSourceSelectors(),
                selectedValue: selectedSource?.code ?? 'all',
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SortBySelector(
                selectedValue: selectedSortby,
                onChanged: (SortBy sortBy) => context
                    .read<NewsFilterBloc>()
                    .add(NewsFilterSortByChangedEvent(sortBy: sortBy)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
