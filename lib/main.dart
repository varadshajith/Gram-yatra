import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
import 'screens/sos_screen.dart';
import 'screens/kumbh_screen.dart';
import 'screens/plan_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  runApp(const GramYatraApp());
}

class GramYatraApp extends StatelessWidget {
  const GramYatraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gram Yatra',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      themeMode: ThemeMode.light,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          return const Scaffold(body: Center(child: Text('Login UI Placeholder')));
        },
      ),
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const Scaffold(body: Center(child: Text('Login UI Placeholder'))),
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
        '/sos': (context) => const SosScreen(),
        '/kumbh': (context) => const KumbhScreen(),
        '/plan-screen': (context) => const PlanScreen(),
      },
    );
  }
}
