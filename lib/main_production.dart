import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:untitled/generated/l10n.dart';
import 'package:untitled/pages/home_page/home_provider.dart';
import 'package:untitled/provider/provider.dart';
import 'package:untitled/theme/theme.dart';
import 'pages/home_page/homepage.dart';
import 'package:untitled/app/di.dart';

Future<void> main() async {
  await Loc.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Prov()),
        ChangeNotifierProvider(create: (context) => HomeProv())
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: AppTheme.theme(false),
        darkTheme: AppTheme.theme(),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}
