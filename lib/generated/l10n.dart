// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `My tasks`
  String get title {
    return Intl.message(
      'My tasks',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Done - `
  String get done {
    return Intl.message(
      'Done - ',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `January`
  String get jan {
    return Intl.message(
      'January',
      name: 'jan',
      desc: '',
      args: [],
    );
  }

  /// `February`
  String get feb {
    return Intl.message(
      'February',
      name: 'feb',
      desc: '',
      args: [],
    );
  }

  /// `March`
  String get mar {
    return Intl.message(
      'March',
      name: 'mar',
      desc: '',
      args: [],
    );
  }

  /// `April`
  String get apr {
    return Intl.message(
      'April',
      name: 'apr',
      desc: '',
      args: [],
    );
  }

  /// `May`
  String get may {
    return Intl.message(
      'May',
      name: 'may',
      desc: '',
      args: [],
    );
  }

  /// `June`
  String get jun {
    return Intl.message(
      'June',
      name: 'jun',
      desc: '',
      args: [],
    );
  }

  /// `July`
  String get jul {
    return Intl.message(
      'July',
      name: 'jul',
      desc: '',
      args: [],
    );
  }

  /// `August`
  String get aug {
    return Intl.message(
      'August',
      name: 'aug',
      desc: '',
      args: [],
    );
  }

  /// `September`
  String get sep {
    return Intl.message(
      'September',
      name: 'sep',
      desc: '',
      args: [],
    );
  }

  /// `October`
  String get oct {
    return Intl.message(
      'October',
      name: 'oct',
      desc: '',
      args: [],
    );
  }

  /// `November`
  String get nov {
    return Intl.message(
      'November',
      name: 'nov',
      desc: '',
      args: [],
    );
  }

  /// `December`
  String get dec {
    return Intl.message(
      'December',
      name: 'dec',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get neww {
    return Intl.message(
      'New',
      name: 'neww',
      desc: '',
      args: [],
    );
  }

  /// `Priority`
  String get priority {
    return Intl.message(
      'Priority',
      name: 'priority',
      desc: '',
      args: [],
    );
  }

  /// `Do before`
  String get do_before {
    return Intl.message(
      'Do before',
      name: 'do_before',
      desc: '',
      args: [],
    );
  }

  /// `None`
  String get none {
    return Intl.message(
      'None',
      name: 'none',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `SAVE`
  String get save {
    return Intl.message(
      'SAVE',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Low`
  String get low {
    return Intl.message(
      'Low',
      name: 'low',
      desc: '',
      args: [],
    );
  }

  /// `!! High`
  String get high {
    return Intl.message(
      '!! High',
      name: 'high',
      desc: '',
      args: [],
    );
  }

  /// `What to do...`
  String get what_need_to_do {
    return Intl.message(
      'What to do...',
      name: 'what_need_to_do',
      desc: '',
      args: [],
    );
  }

  /// `Empty`
  String get empty_case {
    return Intl.message(
      'Empty',
      name: 'empty_case',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
