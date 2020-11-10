import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/constants/notification_channels.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_main/presentation/blocs/settings/settings_cubit.dart';

class NotificationSettings extends StatelessWidget {
  const NotificationSettings({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final settingsCubit = context.watch<SettingsCubit>();
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: RichText(
                  text: TextSpan(
                    text: 'Trending notifications',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(height: 1.5),
                    children: [
                      TextSpan(
                          text: '\nReceive all trending notifications',
                          style: Theme.of(context).textTheme.caption),
                    ],
                  ),
                ),
              ),
              BlocBuilder<SettingsCubit, SettingsState>(
                buildWhen: (previous, current) =>
                    current is SettingsTrendingNotificationChangedState ||
                    current is SettingsInitialState ||
                    current is SettingsLoadSuccess,
                builder: (context, state) {
                  if (state is SettingsTrendingNotificationChangedState) {
                    return TrendingNotificationSwitch(
                        context: context, initialValue: state.value);
                  }
                  return TrendingNotificationSwitch(
                      context: context,
                      initialValue:
                          settingsCubit.settings.trendingNotifications ?? true);
                },
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: RichText(
                  text: TextSpan(
                    text: 'Comments',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(height: 1.5),
                    children: [
                      TextSpan(
                          text:
                              '\nGet notified when someone replied to your comments.',
                          style: Theme.of(context).textTheme.caption),
                    ],
                  ),
                ),
              ),
              BlocBuilder<SettingsCubit, SettingsState>(
                buildWhen: (previous, current) =>
                    current is SettingsCommentNotificationChangedState ||
                    current is SettingsInitialState ||
                    current is SettingsLoadSuccess,
                builder: (context, state) {
                  if (state is SettingsCommentNotificationChangedState) {
                    return CommentNotificationSwitch(
                        context: context, initialValue: state.value);
                  }
                  return CommentNotificationSwitch(
                      context: context,
                      initialValue:
                          settingsCubit.settings.commentNotifications ?? true);
                },
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: RichText(
                  text: TextSpan(
                    text: 'Messages',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(height: 1.5),
                    children: [
                      TextSpan(
                          text:
                              '\nGet notified when someone sent you a message.',
                          style: Theme.of(context).textTheme.caption),
                    ],
                  ),
                ),
              ),
              BlocBuilder<SettingsCubit, SettingsState>(
                buildWhen: (previous, current) =>
                    current is SettingsMessageNotificationChangedState ||
                    current is SettingsInitialState ||
                    current is SettingsLoadSuccess,
                builder: (context, state) {
                  if (state is SettingsMessageNotificationChangedState) {
                    return MessageNotificationSwitch(
                        context: context, initialValue: state.value);
                  }
                  return MessageNotificationSwitch(
                      context: context,
                      initialValue:
                          settingsCubit.settings.messageNotifications ?? true);
                },
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: RichText(
                  text: TextSpan(
                    text: 'Other notifications',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(height: 1.5),
                    children: [
                      TextSpan(
                          text:
                              '\nGet notified for weather,corona, app updates, etc...',
                          style: Theme.of(context).textTheme.caption),
                    ],
                  ),
                ),
              ),
              BlocBuilder<SettingsCubit, SettingsState>(
                buildWhen: (previous, current) =>
                    current is SettingsOtherNotificationChangedState ||
                    current is SettingsInitialState ||
                    current is SettingsLoadSuccess,
                builder: (context, state) {
                  if (state is SettingsOtherNotificationChangedState) {
                    return OtherNotificationSwitch(
                        context: context, initialValue: state.value);
                  }
                  return OtherNotificationSwitch(
                      context: context,
                      initialValue:
                          settingsCubit.settings.otherNotifications ?? true);
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

class OtherNotificationSwitch extends StatelessWidget {
  const OtherNotificationSwitch({
    Key key,
    @required this.context,
    @required this.initialValue,
  }) : super(key: key);

  final BuildContext context;
  final bool initialValue;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: initialValue,
      onChanged: (value) {
        context.watch<SettingsCubit>().setOtherNotifications(value);
        if (value) {
          GetIt.I
              .get<NotificationService>()
              .subscribe(NotificationChannels.kOtherNotifications, 1);
          GetIt.I.get<AnalyticsService>().logOtherNotificatoon(notify: true);
        } else
          GetIt.I
              .get<NotificationService>()
              .unSubscribe(NotificationChannels.kOtherNotifications);
        GetIt.I.get<AnalyticsService>().logOtherNotificatoon(notify: false);
      },
      activeColor: Theme.of(context).accentColor,
    );
  }
}

class MessageNotificationSwitch extends StatelessWidget {
  const MessageNotificationSwitch({
    Key key,
    @required this.context,
    @required this.initialValue,
  }) : super(key: key);

  final BuildContext context;
  final bool initialValue;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: initialValue,
      onChanged: (value) {
        context.watch<SettingsCubit>().setMessageNotifications(value);
        if (value) {
          GetIt.I
              .get<NotificationService>()
              .subscribe(NotificationChannels.kMessageNotifications, 1);
          GetIt.I.get<AnalyticsService>().logMessageNotification(notify: true);
        } else
          GetIt.I
              .get<NotificationService>()
              .unSubscribe(NotificationChannels.kMessageNotifications);
        GetIt.I.get<AnalyticsService>().logMessageNotification(notify: false);
      },
      activeColor: Theme.of(context).accentColor,
    );
  }
}

class CommentNotificationSwitch extends StatelessWidget {
  const CommentNotificationSwitch({
    Key key,
    @required this.context,
    @required this.initialValue,
  }) : super(key: key);

  final BuildContext context;
  final bool initialValue;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: initialValue,
      onChanged: (value) {
        context.watch<SettingsCubit>().setCommentNotifications(value);
        if (value) {
          GetIt.I
              .get<NotificationService>()
              .subscribe(NotificationChannels.kCommentNotifications, 1);
          GetIt.I.get<AnalyticsService>().logCommentNotification(notify: true);
        } else
          GetIt.I
              .get<NotificationService>()
              .unSubscribe(NotificationChannels.kCommentNotifications);
        GetIt.I.get<AnalyticsService>().logCommentNotification(notify: false);
      },
      activeColor: Theme.of(context).accentColor,
    );
  }
}

class TrendingNotificationSwitch extends StatelessWidget {
  const TrendingNotificationSwitch({
    Key key,
    @required this.context,
    @required this.initialValue,
  }) : super(key: key);

  final BuildContext context;
  final bool initialValue;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: initialValue,
      onChanged: (value) {
        context.watch<SettingsCubit>().setTrendingNotifications(value);
        if (value) {
          GetIt.I
              .get<NotificationService>()
              .subscribe(NotificationChannels.kTrendingNotifications, 1);
          GetIt.I.get<AnalyticsService>().logTrendingNotificatoon(notify: true);
        } else
          GetIt.I
              .get<NotificationService>()
              .unSubscribe(NotificationChannels.kTrendingNotifications);
        GetIt.I.get<AnalyticsService>().logTrendingNotificatoon(notify: false);
      },
      activeColor: Theme.of(context).accentColor,
    );
  }
}
