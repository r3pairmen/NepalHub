import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class ForexModel {
  final Map<String, dynamic> rawData;
  final int id;
  final DateTime date;
  final String type;
  final String code;
  final String currency;
  final int unit;
  final double buying;
  final double selling;
  final String source;
  final String sourceUrl;
  final DateTime addedDate;
  bool isDefault = false;

  ForexModel(
      {@required this.id,
      @required this.date,
      @required this.type,
      @required this.code,
      @required this.currency,
      @required this.unit,
      @required this.buying,
      @required this.selling,
      @required this.source,
      @required this.sourceUrl,
      @required this.addedDate,
      @required this.rawData,
      this.isDefault});

  String formattedDate(DateTime date) =>
      DateFormat('dd MMMM, yyyy').format(date);
}
