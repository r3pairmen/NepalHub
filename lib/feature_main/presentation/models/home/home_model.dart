import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_forex/presentation/models/forex_model.dart';
import 'package:samachar_hub/feature_gold/presentation/models/gold_silver_model.dart';
import 'package:samachar_hub/feature_horoscope/presentation/models/horoscope_model.dart';
import 'package:samachar_hub/feature_main/domain/entities/home_entity.dart';
import 'package:samachar_hub/feature_main/presentation/models/home/corona_model.dart';
import 'package:samachar_hub/feature_main/presentation/models/home/latest_news_model.dart';
import 'package:samachar_hub/feature_main/presentation/models/home/trending_news_model.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_category.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_source.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_topic.dart';

class HomeUIModel {
  CoronaUIModel coronaUIModel;
  LatestNewsUIModel latestNewsUIModel;
  TrendingNewsUIModel trendingNewsUIModel;
  ForexUIModel forexUIModel;
  GoldSilverUIModel goldSilverUIModel;
  List<NewsTopicUIModel> newsTopicUIModels;
  List<NewsCategoryUIModel> newsCategoryUIModels;
  List<NewsSourceUIModel> newsSourceUIModels;
  HoroscopeUIModel horoscopeUIModel;

  HomeUIModel({
    @required this.coronaUIModel,
    @required this.latestNewsUIModel,
    @required this.trendingNewsUIModel,
    @required this.newsTopicUIModels,
    @required this.newsCategoryUIModels,
    @required this.newsSourceUIModels,
    @required this.forexUIModel,
    @required this.goldSilverUIModel,
    @required this.horoscopeUIModel,
    HomeEntity feed,
  });

  bool get hasCoronaData => coronaUIModel != null;
  bool get hasLatestNews => latestNewsUIModel != null;
  bool get hasTrendingNews => trendingNewsUIModel != null;
  bool get hasNewsTopics => newsTopicUIModels != null;
  bool get hasNewsCategories => newsCategoryUIModels != null;
  bool get hasNewsSources => newsSourceUIModels != null;
  bool get hasForex => forexUIModel != null;
  bool get hasGoldSilver => goldSilverUIModel != null;
  bool get hasHoroscope => horoscopeUIModel != null;
}
