import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'utils/theme.dart';
import 'screens/welcome_screen.dart';
import 'screens/profile_setup_screen.dart';
import 'screens/user_profile_screen.dart';
import 'screens/home_screen.dart';
import 'screens/plan_builder_screen.dart';
import 'screens/plan_results_screen.dart';
import 'screens/top_attractions_screen.dart';
import 'screens/place_detail_screen.dart';
import 'screens/cuisine_screen.dart';
import 'screens/local_business_screen.dart';
import 'screens/business_category_screen.dart';
import 'screens/road_trips_screen.dart';
import 'screens/traveler_experience_screen.dart';
import 'screens/events_screen.dart';
import 'screens/festivals_screen.dart';
import 'screens/ar_view_screen.dart';
import 'screens/map_screen.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  final prefs = await SharedPreferences.getInstance();
  final bool hasProfile = prefs.getBool('hasProfile') ?? false;
  final String startRoute = hasProfile ? '/home' : '/';

  runApp(GramYatraApp(initialRoute: startRoute));
}

class GramYatraApp extends StatelessWidget {
  final String initialRoute;
  const GramYatraApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, ThemeMode currentMode, child) {
        return MaterialApp(
          title: 'Gram Yatra',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme,
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorSchemeSeed: AppTheme.primary,
          ),
          themeMode: currentMode,
          initialRoute: initialRoute,
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/profile-setup': (context) => const ProfileSetupScreen(),
        '/user-profile': (context) => const UserProfileScreen(),
        '/home': (context) => const HomeScreen(),
        '/plan-builder': (context) => const PlanBuilderScreen(),
        '/plan-results': (context) => const PlanResultsScreen(),
        '/top-attractions': (context) => const TopAttractionsScreen(),
        '/place-detail': (context) => const PlaceDetailScreen(),
        '/cuisine': (context) => const CuisineScreen(),
        '/local-business': (context) => const LocalBusinessScreen(),
        '/business-category': (context) => const BusinessCategoryScreen(),
        '/road-trips': (context) => const RoadTripsScreen(),
        '/traveler-experience': (context) => const TravelerExperienceScreen(),
        '/events': (context) => const EventsScreen(),
        '/festivals': (context) => const FestivalsScreen(),
        '/ar-view': (context) => const ARViewScreen(),
        '/map': (context) => const MapScreen(),
      },
        );
      },
    );
  }
}
