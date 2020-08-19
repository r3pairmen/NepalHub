import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics();

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  Future setUser({@required String userId}) async {
    await _analytics.setUserId(userId);
  }

  Future logLogin({String method = 'google'}) async {
    return await _analytics.logLogin(loginMethod: method);
  }

  Future logSignUp({String method = 'google'}) async {
    return await _analytics.logSignUp(signUpMethod: method);
  }

  Future logLogout({String method = 'google'}) async {
    return await _analytics
        .logEvent(name: "logout", parameters: {'logout_method': method});
  }

  Future logFeedAdded({String userId, String feedId}) async {
    return await _analytics.logEvent(
      name: 'feed',
      parameters: {'user_id': userId, 'feed_id': feedId, 'action': 'added'},
    );
  }

  Future logFeedRemoved({String userId, String feedId}) async {
    return await _analytics.logEvent(
      name: 'feed',
      parameters: {'user_id': userId, 'feed_id': feedId, 'action': 'removed'},
    );
  }

  Future logPostMeta(
      {@required String postId, @required String metaName}) async {
    return await _analytics.logEvent(
      name: 'post_meta',
      parameters: {'post_id': postId, 'meta': metaName},
    );
  }

  Future logFeedBookmarkAdded({String feedId}) async {
    return await _analytics.logEvent(
      name: 'bookmarked_feed',
      parameters: {'feed_id': feedId, 'action': 'added'},
    );
  }

  Future logFeedBookmarkRemoved({String feedId}) async {
    return await _analytics.logEvent(
      name: 'bookmarked_feed',
      parameters: {'feed_id': feedId, 'action': 'removed'},
    );
  }

  Future logFeedBookmarkFetched({String page}) async =>
      await _analytics.logEvent(
        name: 'bookmarked_feed',
        parameters: {'feed_page': page, 'action': 'fetched'},
      );

  Future logCommentPosted({String postId}) async {
    await _analytics.logEvent(
      name: 'comment_posted',
      parameters: {'post_id': postId},
    );
  }

  Future logCommentFetched({String postId}) async {
    await _analytics.logEvent(
      name: 'comment_fetched',
      parameters: {'post_id': postId},
    );
  }

  Future logCommentLiked({String postId, String commentId}) async {
    await _analytics.logEvent(
      name: 'comment_liked',
      parameters: {'post_id': postId, 'comment_id': commentId},
    );
  }

  Future logCommentLikeRemoved({String postId, String commentId}) async {
    await _analytics.logEvent(
      name: 'comment_unlike',
      parameters: {'post_id': postId, 'comment_id': commentId},
    );
  }

  Future logForexFetched({String currency}) async {
    await _analytics.logEvent(
      name: 'forex_fetched',
      parameters: {'currency_code': currency},
    );
  }

  Future logHoroscopeFetched() async {
    await _analytics.logEvent(
      name: 'horoscope_fetched',
    );
  }

  Future logNewsSourceFollowed({String sourceCode}) async {
    await _analytics.logEvent(
      name: 'news_source_followed',
      parameters: {'source_code': sourceCode},
    );
  }

  Future logNewsSourceUnFollowed({String sourceCode}) async {
    await _analytics.logEvent(
      name: 'news_source_unfollowed',
      parameters: {'source_code': sourceCode},
    );
  }

  Future logNewsCategoryFollowed({String sourceCode}) async {
    await _analytics.logEvent(
      name: 'news_category_followed',
      parameters: {'category_code': sourceCode},
    );
  }

  Future logNewsCategoryUnFollowed({String categoryCode}) async {
    await _analytics.logEvent(
      name: 'news_category_unfollowed',
      parameters: {'category_code': categoryCode},
    );
  }

  Future logNewsTopicFollowed({String topic}) async {
    await _analytics.logEvent(
      name: 'news_topic_followed',
      parameters: {'topic': topic},
    );
  }

  Future logNewsTopicUnFollowed({String topic}) async {
    await _analytics.logEvent(
      name: 'news_topic_unfollowed',
      parameters: {'topic': topic},
    );
  }

  Future logShare(
      {String postId, String method, String contentType = 'feed'}) async {
    await _analytics.logShare(
      contentType: contentType,
      itemId: postId,
      method: method,
    );
  }
}
