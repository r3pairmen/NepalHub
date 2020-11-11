import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_comment/domain/entities/thread_type.dart';
import 'package:samachar_hub/feature_comment/presentation/ui/widgets/comment_input_bar.dart';
import 'package:samachar_hub/feature_comment/presentation/ui/widgets/comment_list.dart';
import 'package:samachar_hub/feature_comment/presentation/ui/widgets/header.dart';
import 'package:samachar_hub/feature_comment/presentation/ui/widgets/like_comment_stats.dart';
import 'package:samachar_hub/feature_comment/utils/providers.dart';
import 'package:samachar_hub/feature_stats/presentation/blocs/thread_stats_cubit.dart';

class CommentScreen extends StatelessWidget {
  final String threadId;
  final CommentThreadType threadType;
  final String threadTitle;
  const CommentScreen(
      {Key key,
      @required this.threadId,
      @required this.threadType,
      @required this.threadTitle})
      : super(key: key);

  static Future navigate(BuildContext context, String threadId,
      CommentThreadType threadType, String threadTitle) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommentScreen(
          threadId: threadId,
          threadTitle: threadTitle,
          threadType: threadType,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            [
          SliverToBoxAdapter(
            child: Header(
              title: threadTitle,
            ),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<ThreadStatsCubit, ThreadStatsState>(
              builder: (context, state) {
                if (state is ThreadStatsLoadSuccess) {
                  return LikeAndCommentStats(
                    likeCount:
                        state.threadStatsUIModel.threadStatsEntity.likeCount,
                    commentCount:
                        state.threadStatsUIModel.threadStatsEntity.commentCount,
                  );
                }
                return LikeAndCommentStats(
                  likeCount: 0,
                  commentCount: 0,
                );
              },
            ),
          ),
        ],
        body: const CommentList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommentProvider.commentBlocProvider(
      threadId: threadId,
      threadType: threadType,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text('Comments'),
        ),
        body: SafeArea(
          child: Container(
            color: Theme.of(context).backgroundColor,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: _buildBody(context),
                ),
                const CommentInputBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
