import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_news/presentation/ui/following/category/followed_news_category_section.dart';
import 'package:samachar_hub/feature_news/presentation/ui/following/source/followed_news_source_section.dart';
import 'package:samachar_hub/feature_news/presentation/ui/following/topic/followed_news_topic_section.dart';
import 'package:samachar_hub/pages/widgets/page_heading_widget.dart';

class FollowingPage extends StatefulWidget {
  @override
  _FollowingPageState createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          PageHeading(
            title: 'Following',
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 8,
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: FollowedNewsSourceSection(),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: FollowedNewsCategorySection(),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: FollowedNewsTopicSection(),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
