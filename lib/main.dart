import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fotoporcelana/my_colors.dart';
import 'package:fotoporcelana/providers/data_provider.dart';
import 'package:fotoporcelana/providers/krysztal_options.dart';
import 'package:fotoporcelana/providers/porcelana_options.dart';
import 'package:fotoporcelana/screens/krysztal_screen.dart';
import 'package:fotoporcelana/screens/other_products_screen.dart';
import 'package:fotoporcelana/screens/porcelana_screen.dart';
import 'package:fotoporcelana/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: PorcelanaOptions(),
        ),
        ChangeNotifierProvider.value(
          value: KrysztalOptions(),
        ),
        ChangeNotifierProvider.value(
          value: DataProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Fotoporcelana.net',
        theme: ThemeData(
          checkboxTheme: CheckboxThemeData(
              fillColor: MaterialStateProperty.all(MyColors.accentMaterial)),
          primaryColor: MyColors.mainMaterial,
          fontFamily: 'Noto Sans',
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.grey,
            accentColor: MyColors.accentMaterial,
          )
              .copyWith(
                  secondary: MyColors.accentMaterial,
                  onSecondary: Colors.grey[200])
              .copyWith(background: Colors.grey[200]),
        ),
        home: const HomeScreen(),
        routes: {
          HomeScreen.routeName: (ctx) => const HomeScreen(),
          PorcelanaScreen.routeName: (ctx) => const PorcelanaScreen(),
          KrysztalScreen.routeName: (ctx) => const KrysztalScreen(),
          OtherProductsScreen.routeName: (ctx) => const OtherProductsScreen(),
        },
      ),
    );
  }
}
