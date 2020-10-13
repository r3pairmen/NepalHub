import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:samachar_hub/core/constants/notification_channels.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_main/domain/entities/settings_entity.dart';
import 'package:samachar_hub/feature_main/presentation/blocs/settings/settings_cubit.dart';

class HoroscopeSettings extends StatelessWidget {
  const HoroscopeSettings({
    Key key,
    @required this.context,
    @required this.settingsEntity,
  }) : super(key: key);

  final BuildContext context;
  final SettingsEntity settingsEntity;

  Widget _buildSignsDropDown(int selectedIndex) {
    return DropdownButton<int>(
      value: selectedIndex,
      onChanged: (value) {
        context.bloc<SettingsCubit>().setdefaultHoroscopeSign(value);
      },
      items: HOROSCOPE_SIGNS[Language.NEPALI]
          .map(
            (e) => DropdownMenuItem<int>(
              value: HOROSCOPE_SIGNS[Language.NEPALI].indexOf(e),
              child: Text(
                e,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildNotificationSwitch(bool initialValue) {
    return Switch(
      value: initialValue,
      onChanged: (value) {
        context.bloc<SettingsCubit>().setShowDailyMorningHoroscope(value);
        if (value) {
          context.repository<NotificationService>().scheduleNotificationDaily(
              NotificationChannels.kMorningHoroscopeId,
              'Good Morning 🌅',
              'Your daily horoscope is here. Click to read. 📰',
              NotificationChannels.kMorningHoroscopeChannelId,
              NotificationChannels.kMorningHoroscopeChannelName,
              NotificationChannels.kMorningHoroscopeChannelDesc,
              Time(7, 0, 0));
          context
              .repository<AnalyticsService>()
              .logHoroscopeDailyMorningNotificatoon(notify: true);
        } else {
          context
              .repository<NotificationService>()
              .flutterLocalNotificationsPlugin
              .cancel(NotificationChannels.kMorningHoroscopeId);
          context
              .repository<AnalyticsService>()
              .logHoroscopeDailyMorningNotificatoon(notify: false);
        }
      },
      activeColor: Theme.of(context).accentColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Your Horoscope',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              BlocBuilder<SettingsCubit, SettingsState>(
                  buildWhen: (previous, current) =>
                      (current is SettingsInitialState) ||
                      (current is SettingsDefaultHoroscopeSignChangedState),
                  builder: (context, state) {
                    if (state is SettingsDefaultHoroscopeSignChangedState) {
                      return _buildSignsDropDown(state.value);
                    }
                    return _buildSignsDropDown(
                        settingsEntity.defaultHoroscopeSign ?? 0);
                  }),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Notify daily horoscope at 7 am',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              BlocBuilder<SettingsCubit, SettingsState>(
                buildWhen: (previous, current) =>
                    (current is SettingsInitialState) ||
                    (current
                        is SettingsDailyMorningHoroscopeNotificationChangedState),
                builder: (context, state) {
                  if (state
                      is SettingsDailyMorningHoroscopeNotificationChangedState) {
                    return _buildNotificationSwitch(state.value);
                  }
                  return _buildNotificationSwitch(
                      settingsEntity.showDailyMorningHoroscope ?? true);
                },
              ),
            ],
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
