import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samachar_hub/feature_comment/domain/entities/thread_type.dart';
import 'package:samachar_hub/feature_comment/presentation/ui/comment_screen.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_feed_more_option.dart';
import 'package:samachar_hub/core/extensions/view.dart';
import 'package:samachar_hub/core/extensions/number_extensions.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsFeedCardSourceCategory extends StatelessWidget {
  final String sourceIcon;
  final String source;
  final String publishedDate;
  final String category;

  const NewsFeedCardSourceCategory({
    @required this.sourceIcon,
    @required this.source,
    @required this.publishedDate,
    @required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(15),
          ),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: sourceIcon,
            placeholder: (context, _) => Icon(FontAwesomeIcons.image),
            errorWidget: (context, url, error) => Icon(FontAwesomeIcons.image),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        RichText(
          text: TextSpan(
            text: source,
            style: Theme.of(context).textTheme.subtitle2,
            children: <TextSpan>[
              TextSpan(
                  text: '\n$publishedDate',
                  style: Theme.of(context).textTheme.caption)
            ],
          ),
        ),
        Spacer(),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.circular(12)),
          child: Text(
            category,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ],
    );
  }
}

class NewsFeedCardTitleDescription extends StatelessWidget {
  final String title;
  final String description;
  final int descriptionMaxLines;

  const NewsFeedCardTitleDescription({
    @required this.title,
    @required this.description,
    this.descriptionMaxLines = 2,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          title ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          description ?? '',
          maxLines: descriptionMaxLines,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle1.copyWith(height: 1.3),
        ),
      ],
    );
  }
}

class NewsFeedOptions extends StatelessWidget {
  const NewsFeedOptions({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final feed =
        ScopedModel.of<NewsFeedUIModel>(context, rebuildOnChange: true);
    final iconColor = Theme.of(context).iconTheme.color.withOpacity(0.4);
    final textStyle = Theme.of(context)
        .textTheme
        .overline
        .copyWith(fontWeight: FontWeight.w300);
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        if (feed.entity.viewCount != 0)
          RichText(
            text: TextSpan(children: [
              WidgetSpan(
                child: Icon(
                  Icons.visibility,
                  size: 14,
                  color: iconColor,
                ),
              ),
              TextSpan(
                text: ' ${feed.entity.viewCount.compactFormat}',
                style: textStyle,
              ),
            ]),
          ),
        if (feed.entity.viewCount != 0) const SizedBox(width: 8),
        if (feed.entity.likeCount != 0)
          RichText(
            text: TextSpan(children: [
              WidgetSpan(
                child: Icon(
                  Icons.thumb_up,
                  size: 14,
                  color: iconColor,
                ),
              ),
              TextSpan(
                text: ' ${feed.entity.likeCount.compactFormat}',
                style: textStyle,
              ),
            ]),
          ),
        if (feed.entity.likeCount != 0) SizedBox(width: 8),
        if (feed.entity.commentCount != 0)
          RichText(
            text: TextSpan(children: [
              WidgetSpan(
                child: Icon(
                  FontAwesomeIcons.comment,
                  size: 14,
                  color: iconColor,
                ),
              ),
              TextSpan(
                text: ' ${feed.entity.commentCount.compactFormat}',
                style: textStyle,
              ),
            ]),
          ),
        if (feed.entity.commentCount != 0) SizedBox(width: 8),
        if (feed.entity.shareCount != 0)
          RichText(
            text: TextSpan(children: [
              WidgetSpan(
                child: Icon(
                  FontAwesomeIcons.shareAlt,
                  size: 14,
                  color: iconColor,
                ),
              ),
              TextSpan(
                text: ' ${feed.entity.shareCount.compactFormat}',
                style: textStyle,
              ),
            ]),
          ),
        if (feed.entity.shareCount != 0) SizedBox(width: 8),
        Spacer(),
        IconButton(
          visualDensity: VisualDensity.compact,
          icon: Icon(
            FontAwesomeIcons.comment,
            size: 16,
          ),
          onPressed: () => Navigator.pushNamed(
            context,
            CommentScreen.ROUTE_NAME,
            arguments: CommentScreenArgs(
                threadTitle: feed.entity.title,
                threadId: feed.entity.id,
                threadType: CommentThreadType.NEWS_FEED),
          ),
        ),
        IconButton(
          visualDensity: VisualDensity.compact,
          icon: Icon(
            Icons.more_vert,
          ),
          onPressed: () => context.showBottomSheet(
              child: NewsFeedMoreOption(
            context: context,
          )),
        ),
      ],
    );
  }
}
