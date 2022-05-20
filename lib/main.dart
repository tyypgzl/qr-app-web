import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:web_app/feature/shared/utils/api_const.dart';
import 'package:web_app/route/route.dart';
import 'core/constants/app_constants.dart';
import 'core/constants/route_constants.dart';
import 'core/navigation/navigation_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Supabase.initialize(
    url: AppConstants.instance.supabaseURL,
    anonKey: AppConstants.instance.supabaseAnonKey,
  );
  GetIt getIt = GetIt.instance;

  getIt.registerSingleton<SupabaseClient>(SupabaseClient(
      ApiConstants.instance.supabaseURL, ApiConstants.instance.supabaseKEY));
  runApp(const Init());
}

GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class Init extends StatelessWidget {
  const Init({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteConstants.onboard,
      onGenerateRoute: AppRoute.generateRoute,
      navigatorKey: NavigationService.instance.navigatorKey,
      title: AppConstants.instance.appTitle,
      theme: ThemeData.light().copyWith(
        textTheme: GoogleFonts.ralewayTextTheme(),
      ),
    );
  }
}
