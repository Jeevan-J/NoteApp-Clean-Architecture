import 'package:flutter/material.dart';
import 'package:memoscape/common/strings.dart';
import 'package:memoscape/di/di.dart';

import 'routes/routes.dart';
import 'theme/theme.dart';

export 'screens/screens.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: getIt<AppRouter>().config(),
      title: StringConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
    );
  }
}
