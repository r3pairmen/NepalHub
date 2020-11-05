import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_forex/domain/entities/forex_entity.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_horoscope/presentation/extensions/horoscope_extensions.dart';
import 'package:samachar_hub/feature_main/presentation/blocs/settings/settings_cubit.dart';

class OtherMenuSection extends StatefulWidget {
  final ForexEntity forex;
  final HoroscopeEntity horoscope;
  const OtherMenuSection({
    Key key,
    this.forex,
    this.horoscope,
  }) : super(key: key);

  @override
  _OtherMenuSectionState createState() => _OtherMenuSectionState();
}

class _OtherMenuSectionState extends State<OtherMenuSection>
    with AutomaticKeepAliveClientMixin {
  Widget _buildForexMenu(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      color: Colors.blue,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => GetIt.I.get<NavigationService>().toForexScreen(context),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Icon(
                    FontAwesomeIcons.chartLine,
                    color: Colors.white,
                    size: 32,
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                        text: 'Forex',
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w600),
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  '\n${widget.forex.unit} ${widget.forex.currency.code}=NRs. ${widget.forex.buying}',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(color: Colors.white)),
                          TextSpan(text: '\n'),
                          TextSpan(
                              text: '${widget.forex.formatttedDate}',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: Colors.white)),
                        ]),
                  ),
                  flex: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHoroscopeMenu(BuildContext context) {
    final settingsCubit = context.bloc<SettingsCubit>();
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      color: Colors.deepOrange[600],
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () =>
              GetIt.I.get<NavigationService>().toHoroscopeScreen(context),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Icon(
                    FontAwesomeIcons.starOfDavid,
                    color: Colors.white,
                    size: 32,
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                        text: 'Horoscope',
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w600),
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  '\n${widget.horoscope.signByIndex(settingsCubit.settings.defaultHoroscopeSign ?? 0, Language.NEPALI)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(color: Colors.white)),
                          TextSpan(text: '\n'),
                          TextSpan(
                              text: '${widget.horoscope.formattedDate}',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: Colors.white)),
                        ]),
                  ),
                  flex: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LimitedBox(
      maxHeight: 120,
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(child: _buildForexMenu(context)),
            SizedBox(width: 4),
            Expanded(child: _buildHoroscopeMenu(context)),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
