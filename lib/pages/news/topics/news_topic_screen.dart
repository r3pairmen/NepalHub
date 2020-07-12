import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/news/topics/news_topic_store.dart';
import 'package:samachar_hub/pages/widgets/api_error_dialog.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/news_list_view.dart';
import 'package:samachar_hub/pages/widgets/news_tag_item.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/repository/repositories.dart';
import 'package:samachar_hub/stores/stores.dart';

class NewsTopicScreen extends StatefulWidget {
  final String topic;

  const NewsTopicScreen({Key key, this.topic}) : super(key: key);
  @override
  _NewsTopicScreenState createState() => _NewsTopicScreenState();
}

class _NewsTopicScreenState extends State<NewsTopicScreen> {
  // Reaction disposers
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    final store = Provider.of<NewsTopicStore>(context, listen: false);
    _setupObserver(store);
    store.selectedTopic = widget.topic;
    store.loadTopics();
    store.loadTopicNews();

    super.initState();
  }

  @override
  void dispose() {
    // Dispose reactions
    for (final d in _disposers) {
      d();
    }
    super.dispose();
  }

  _showMessage(String message) {
    if (null != message)
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
  }

  _showErrorDialog(APIException apiError) {
    if (null != apiError)
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return ApiErrorDialog(
            apiError: apiError,
          );
        },
      );
  }

  _setupObserver(store) {
    _disposers = [
      // Listens for error message
      autorun((_) {
        final String message = store.error;
        _showMessage(message);
      }),
      // Listens for API error
      autorun((_) {
        final APIException error = store.apiError;
        _showErrorDialog(error);
      })
    ];
  }

  Widget _buildTopicsSection(BuildContext context, NewsTopicStore store) {
    return StreamBuilder<NewsTopicModel>(
      stream: store.topicsDataStream,
      builder: (BuildContext context, AsyncSnapshot<NewsTopicModel> snapshot) {
        if (snapshot.hasData) {
          return Container(
            color: Theme.of(context).cardColor,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Wrap(
              spacing: 6.0,
              runSpacing: 6.0,
              children: List<Widget>.generate(
                  store.topicData.tags.length,
                  (index) => NewsTagItem(
                        title: store.topicData.tags[index],
                        onTap: (topic) {
                          store.setSelectedTopic(topic);
                        },
                      )),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget _buildTopicNewsSection(BuildContext context, NewsTopicStore store) {
    return Consumer2<PostMetaRepository, AuthenticationStore>(
      builder: (_, postMetaRepository, authenticationStore, __) {
        return StreamBuilder<List<NewsFeedModel>>(
          stream: store.newsDataStream,
          builder: (BuildContext context,
              AsyncSnapshot<List<NewsFeedModel>> snapshot) {
            if (snapshot.hasError) {
              return SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: ErrorDataView(
                    onRetry: () => store.retryTopicNews(),
                  ),
                ),
              );
            }
            if (snapshot.hasData) {
              if (snapshot.data.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: EmptyDataView(),
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return NewsListView(
                    feed: snapshot.data[index],
                    authenticationStore: authenticationStore,
                  );
                }, childCount: snapshot.data.length),
              );
            } else {
              return SliverFillRemaining(
                  hasScrollBody: false, child: Center(child: ProgressView()));
            }
          },
        );
      },
    );
  }

  Widget _buildList() {
    return Consumer<NewsTopicStore>(
      builder: (context, store, child) {
        return CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: _buildTopicsSection(context, store),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 8),
              sliver: SliverToBoxAdapter(
                child: _buildSearchbar(context, store),
              ),
            ),
            _buildTopicNewsSection(context, store),
          ],
        );
      },
    );
  }

  Widget _buildSearchbar(BuildContext context, NewsTopicStore store) {
    return Observer(
      builder: (BuildContext context) {
        return RichText(
          text: TextSpan(
              text: 'News for the topic: ',
              style: Theme.of(context).textTheme.bodyText1,
              children: <TextSpan>[
                TextSpan(
                    text: '#${store.selectedTopic}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontStyle: FontStyle.italic)),
              ]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Trending Topics'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildList(),
        ),
      ),
    );
  }
}
