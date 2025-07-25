import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import 'package:google_fonts/google_fonts.dart';
import 'dart:collection'; // For Queue
import 'dart:async'; // For Timer and Future
import 'package:flutter_map/flutter_map.dart'; // Import flutter_map
import 'package:latlong2/latlong.dart'; // Import latlong2 for LatLng

// New color palette constants as per the request based on the image
const Color _darkBlue = Color(0xFF1A237E); // A deep indigo-like blue
const Color _lightBlue = Color(0xFF2196F3); // A vibrant blue
const Color _white = Color(0xFFFFFFFF); // Standard white
const Color _lightGrey = Color(0xFFE0E0E0); // For translucent elements
const Color _lightRed = Color(0xFFF08080); // Light coral for SOS hexagon

/// A custom page route builder for a slide transition animation.
/// The new page slides in from the right.
PageRouteBuilder<void> _buildPageRouteWithSlideTransition(Widget page) {
  return PageRouteBuilder<void>(
    pageBuilder:
        (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder:
        (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) {
      const Offset begin = Offset(1.0, 0.0); // Start from right
      const Offset end = Offset.zero; // End at original position
      const Curve curve =
          Curves.easeOutCubic; // A smooth curve for the animation

      final Animatable<Offset> tween = Tween<Offset>(
        begin: begin,
        end: end,
      ).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 500),
    reverseTransitionDuration: const Duration(milliseconds: 500),
  );
}

void main() => runApp(const AuthApp());

/// DATA_MODEL for Language Management
class LanguageProvider extends ChangeNotifier {
  bool _isNepali = false; // false for English, true for Nepali

  bool get isNepali => _isNepali;

  void toggleLanguage() {
    _isNepali = !_isNepali;
    notifyListeners();
  }

  String getString(String key) {
    if (_isNepali) {
      return _nepaliStrings[key] ?? _englishStrings[key] ?? key;
    }
    return _englishStrings[key] ?? key;
  }

  // All UI strings for both English and Nepali
  static final Map<String, String> _englishStrings = {
    'create_account_title': 'Create\nAccount',
    'name_hint': 'Userame',
    'phone_number_hint': 'Phone Number',
    'password_hint': 'Password',
    'confirm_password_hint': 'Confirm Password',
    'signup_button': 'Sign Up',
    'already_have_account_question': 'Already have an account?',
    'welcome_back_title': 'Welcome\nBack',
    'email_hint': 'Email',
    'forgot_password_question': 'Forgot password?',
    'login_button': 'Login',
    'create_account_button': 'Create Account',
    'app_bar_greeting': 'TranzITनेपाल',
    'search_hint': 'search for your destination or route',
    'current_location_label': 'Current Location',
    'live_nearby_buses_title': 'Live Nearby Buses',
    'plan_your_trip_title': 'Plan Your Trip',
    'from_label': 'from:',
    'to_label': 'to:',
    'estimated_time_label': 'Estimated time:',
    'suggest_smart_route_button': 'Suggest smart route',
    'enter_location_hint': 'Enter location',
    'home_tab': 'Home',
    'toggle_language_label':
    ' ', // When in English, option to switch to Nepali language
    'tip_tab': 'Tip',
    'sos_tab': 'SOS', // Original short label for tab
    'bus_status_not_crowded': 'not crowded',
    'bus_status_crowded': 'crowded',
    'bus_status_almost_crowded': 'almost crowded',

    // New keys for bus routes
    'bus_route_33': 'Kalanki-Baneshwor',
    'bus_time_away_33': '7 min away',
    'bus_minutes_ago_2': '2 min ago',

    'bus_route_57': 'Jorpati-Ratnapark',
    'bus_time_away_57': '16 min away',

    'bus_route_28': 'Airport-Sahid Gate',
    'bus_time_away_28': '27 min away',
    'bus_minutes_ago_3': '3 min ago',

    'bus_route_92': 'Balaju-Jamal',
    'bus_time_away_92': '47 min away',

    // New keys for Tip Page
    'tip_earn_title': 'Tip & Earn',
    'username_label': 'Username',
    'points_label': 'Points: ',
    'public_ride_number_hint': 'public ride number',
    'is_your_ride_label': 'is your ride,',
    'not_crowded_tip_button': 'not crowded?',
    'almost_full_tip_button': 'almost full?',
    'crowded_tip_button': 'crowded?',
    'submit_tip_button': 'submit tip',

    // New key for SOS Page AppBar title
    'emergency_sos_title': 'Emergency & SOS',
    'call_medical': 'Medical',
    'call_fire': 'Fire',
    'call_police': 'L.E.O.',

    // New keys for Drawer menu
    'profile_menu': 'Profile',
    'settings_menu': 'Settings',
    'logout_menu': 'Logout',
    'logged_in_as': 'Logged in as:', // New key for drawer profile
    // New key for Map display
    'map_directions_title': 'Route Directions',

    // New keys for Route Planning
    'system_label': 'System',
    'route_details_title': 'Route Details',
    'origin_label': 'Origin',
    'destination_label': 'Destination',
    'intermediate_stops_label': 'Intermediate Stops',
    'total_distance_label': 'Total Distance',
    'no_route_found':
    'No specific route found for your selection. Displaying general map.',
    'km_unit': 'km',
    'invalid_credentials': 'Invalid email or password.',
    'transfer_at_label': 'Transfer at',
    'take_bus_label': 'Take Bus',
    'from_to_label': 'from [FROM] to [TO]',
    'first_leg_label': 'First Leg',
    'second_leg_label': 'Second Leg',
    'direct_route_label': 'Direct Route',
    'estimated_travel_time': 'Estimated travel time:',
    'approx_label': 'approx.',
    'total_stops_label': 'Total Stops',
    'changes_label': 'Changes',
    'bus_label': 'Bus',
    'passwords_do_not_match': 'Passwords do not match.', // New key
    'registration_failed':
    'Registration failed. Email might already be in use.', // New key
  };

  static final Map<String, String> _nepaliStrings = {
    'create_account_title': 'खाता\nबनाउनुहोस्',
    'name_hint': 'प्रयोगकर्ता नाम',
    'phone_number_hint': 'फोन नम्बर',
    'password_hint': 'पासवर्ड', // Corrected from '  '
    'confirm_password_hint': 'पासवर्ड पुष्टि गर्नुहोस्',
    'signup_button': 'साइन अप गर्नुहोस्',
    'already_have_account_question': 'पहिले नै खाता छ?',
    'welcome_back_title': 'फेरि स्वागत छ',
    'email_hint': 'इमेल',
    'forgot_password_question': 'पासवर्ड बिर्सनुभयो?',
    'login_button': 'लगइन',
    'create_account_button': 'खाता बनाउनुहोस्',
    'app_bar_greeting': 'शुभ तीज!',
    'search_hint': 'आफ्नो गन्तव्य वा मार्ग खोज्नुहोस्',
    'current_location_label': 'हालको स्थान',
    'live_nearby_buses_title': 'प्रत्यक्ष नजिकका बसहरू',
    'plan_your_trip_title': 'आफ्नो यात्रा योजना बनाउनुहोस्',
    'from_label': 'बाट:',
    'to_label': 'सम्म:',
    'estimated_time_label': 'अनुमानित समय:',
    'suggest_smart_route_button': 'स्मार्ट मार्ग सुझाव दिनुहोस्',
    'enter_location_hint': 'स्थान प्रविष्ट गर्नुहोस्',
    'home_tab': 'गृह',
    'toggle_language_label':
    'English Language', // When in Nepali, option to switch to English language
    'tip_tab': 'टिप',
    'sos_tab': 'एसओएस', // Original short label for tab
    'bus_status_not_crowded': 'भीडभाड छैन',
    'bus_status_crowded': 'भीडभाड',
    'bus_status_almost_crowded': 'लगभग भीडभाड',

    // Updated Nepali translations for bus routes as per request
    'bus_route_33': 'कलंकी-बानेश्वर',
    'bus_time_away_33': '७ मिनेट टाढा',
    'bus_minutes_ago_2': '२ मिनेट अघि', // Consistent Nepali for 2/3 min ago

    'bus_route_57': 'जोरपाटी-रत्नपार्क',
    'bus_time_away_57': '१६ मिनेट टाढा',

    'bus_route_28': 'एयरपोर्ट-शहीद गेट', // Corrected to match English
    'bus_time_away_28': '२७ मिनेट टाढा',
    'bus_minutes_ago_3': '३ मिनेट अघि', // Corrected to 3 min ago

    'bus_route_92': 'बालाजु-जमल',
    'bus_time_away_92': '४७ मिनेट टाढा',

    // New Nepali translations for Tip Page
    'tip_earn_title': 'टिप र कमाउनुहोस्',
    'username_label': 'प्रयोगकर्ता नाम',
    'points_label': 'अंक: ',
    'public_ride_number_hint': 'सार्वजनिक सवारी नम्बर',
    'is_your_ride_label': 'तपाईंको सवारी हो,',
    'not_crowded_tip_button': 'भीडभाड छैन?',
    'almost_full_tip_button': 'लगभग भरिएको?',
    'crowded_tip_button': 'भीडभाड?',
    'submit_tip_button': 'टिप बुझाउनुहोस्',

    // New Nepali translation for SOS Page AppBar title
    'emergency_sos_title': 'आपतकालीन र एसओएस',
    'call_medical': 'चिकित्सा', // Removed underscore
    'call_fire': 'आगो', // Removed underscore
    'call_police': 'प्रहरी', // Removed underscore
    // New keys for Drawer menu
    'profile_menu': 'प्रोफाइल',
    'settings_menu': 'सेटिङ्स',
    'logout_menu': 'लगआउट',
    'logged_in_as': 'यसको रूपमा लग इन:', // New key for drawer profile
    // New key for Map display
    'map_directions_title': 'मार्ग निर्देशन',

    // New keys for Route Planning
    'system_label': 'प्रणाली',
    'route_details_title': 'मार्ग विवरण',
    'origin_label': 'उत्पत्ति',
    'destination_label': 'गन्तव्य',
    'intermediate_stops_label': 'मध्यवर्ती स्टपहरू',
    'total_distance_label': 'कुल दूरी',
    'no_route_found':
    'तपाईंको चयनका लागि कुनै विशेष मार्ग फेला परेन। सामान्य नक्सा प्रदर्शन गर्दै।',
    'km_unit': 'किमी',
    'invalid_credentials': 'अवैध इमेल वा पासवर्ड।',
    'transfer_at_label': 'मा स्थानान्तरण',
    'take_bus_label': 'बस लिनुहोस्',
    'from_to_label': '[FROM] बाट [TO] सम्म',
    'first_leg_label': 'पहिलो खुट्टा',
    'second_leg_label': 'दोस्रो खुट्टा',
    'direct_route_label': 'प्रत्यक्ष मार्ग',
    'estimated_travel_time': 'अनुमानित यात्रा समय:',
    'approx_label': 'लगभग',
    'total_stops_label': 'कुल स्टपहरू',
    'changes_label': 'परिवर्तनहरू',
    'bus_label': 'बस',
    'passwords_do_not_match': 'पासवर्डहरू मेल खाँदैनन्।', // New key
    'registration_failed':
    'दर्ता असफल भयो। इमेल पहिले नै प्रयोगमा हुन सक्छ।', // New key
  };
}

/// DATA_MODEL for Authentication
class AuthProvider extends ChangeNotifier {
  // Simulate a user database
  final Map<String, String> _users = <String, String>{
    'user@example.com': 'password123',
    'test@test.com': 'test',
    'a@gmail.com': '999999', // Added new user
  };

  String? _currentUserEmail;

  String? get currentUserEmail => _currentUserEmail;

  /// Attempts to log in a user with the given email and password.
  /// Returns true if credentials are valid, false otherwise.
  bool login(String email, String password) {
    // Trim inputs to handle potential whitespace issues
    final String trimmedEmail = email.trim();
    final String trimmedPassword = password.trim();

    if (_users.containsKey(trimmedEmail) &&
        _users[trimmedEmail] == trimmedPassword) {
      _currentUserEmail = trimmedEmail;
      notifyListeners();
      return true;
    }
    return false;
  }

  /// Registers a new user with the given email and password.
  /// Returns true if registration is successful (email not already in use), false otherwise.
  bool register(String email, String password) {
    final String trimmedEmail = email.trim();
    final String trimmedPassword = password.trim();

    if (trimmedEmail.isEmpty || trimmedPassword.isEmpty) {
      return false; // Prevent empty credentials
    }

    if (_users.containsKey(trimmedEmail)) {
      return false; // Email already registered
    }

    _users[trimmedEmail] = trimmedPassword;
    _currentUserEmail = trimmedEmail;
    notifyListeners();
    return true;
  }

  /// Placeholder for logout logic.
  void logout() {
    _currentUserEmail = null;
    notifyListeners();
  }
}

// DATA_MODEL for Bus Tracking and movement simulation
class LiveBus {
  final String id;
  final String routeNumber;
  final List<LatLng> routePath; // The full path of the bus
  int _currentPathIndex; // Current index on the routePath
  int _direction; // 1 for forward, -1 for reverse
  LatLng _currentPosition;

  LiveBus({
    required this.id,
    required this.routeNumber,
    required this.routePath,
  })  : _currentPathIndex = 0,
        _direction = 1, // Start moving forward
        _currentPosition = routePath.isNotEmpty ? routePath[0] : const LatLng(0, 0);

  LatLng get currentPosition => _currentPosition;

  void moveNext() {
    if (routePath.isEmpty) return;

    _currentPathIndex += _direction;

    if (_currentPathIndex >= routePath.length) {
      _currentPathIndex = routePath.length - 2; // Move back one before reversing
      _direction = -1; // Reverse direction
      if (_currentPathIndex < 0) { // Handle case where route has only one point
        _currentPathIndex = 0;
      }
    } else if (_currentPathIndex < 0) {
      _currentPathIndex = 1; // Move forward one before reversing
      _direction = 1; // Reverse direction
      if (_currentPathIndex >= routePath.length) { // Handle case where route has only one point
        _currentPathIndex = routePath.length - 1;
      }
    }
    _currentPosition = routePath[_currentPathIndex];
  }
}

// New Class: Manages all live bus locations and updates
class BusLocationTracker extends ChangeNotifier {
  final List<LiveBus> _buses = <LiveBus>[];
  Timer? _timer;

  // Predefined sample routes for simulation (Kathmandu coordinates)
  static final Map<String, List<LatLng>> _sampleBusRoutes = {
    'route_33_kalanki_baneshwor': <LatLng>[
      const LatLng(27.7011, 85.2936), // Kalanki
      const LatLng(27.7047, 85.3015), // Balkhu
      const LatLng(27.7081, 85.3113), // Teku
      const LatLng(27.7049, 85.3182), // Tripureshwor
      const LatLng(27.6976, 85.3204), // Thapathali
      const LatLng(27.6908, 85.3217), // Maitighar
      const LatLng(27.6836, 85.3236), // Babarmahal
      const LatLng(27.6800, 85.3260), // Naya Baneshwor
      const LatLng(27.6750, 85.3250), // Anamnagar (near Baneshwor)
    ],
    'route_57_jorpati_ratnapark': <LatLng>[
      const LatLng(27.7471, 85.3670), // Jorpati
      const LatLng(27.7350, 85.3600), // Narayantar
      const LatLng(27.7289, 85.3524), // Chabahil
      const LatLng(27.7161, 85.3465), // Gaushala
      const LatLng(27.7071, 85.3375), // Old Baneshwor
      const LatLng(27.7062, 85.3276), // Kamaladi
      const LatLng(27.7011, 85.3151), // Ratnapark
    ],
    'route_28_airport_sahidgate': <LatLng>[
      const LatLng(27.6961, 85.3562), // Tribhuvan Airport
      const LatLng(27.6978, 85.3486), // Tinkune
      const LatLng(27.6962, 85.3385), // Naya Baneshwor (east)
      const LatLng(27.6908, 85.3217), // Maitighar
      const LatLng(27.6881, 85.3195), // Sahid Gate
    ],
  };

  BusLocationTracker() {
    _initializeBuses();
    _startTracking();
  }

  List<LiveBus> get buses => _buses;
  Map<String, List<LatLng>> get sampleRoutes => _sampleBusRoutes; // Expose routes for drawing

  void _initializeBuses() {
    // Initialize a few buses on different routes
    if (_sampleBusRoutes['route_33_kalanki_baneshwor'] != null) {
      _buses.add(LiveBus(
        id: 'Bus-A',
        routeNumber: '33',
        routePath: _sampleBusRoutes['route_33_kalanki_baneshwor']!,
      ));
    }
    if (_sampleBusRoutes['route_57_jorpati_ratnapark'] != null) {
      _buses.add(LiveBus(
        id: 'Bus-B',
        routeNumber: '57',
        routePath: _sampleBusRoutes['route_57_jorpati_ratnapark']!,
      ));
    }
    if (_sampleBusRoutes['route_28_airport_sahidgate'] != null) {
      _buses.add(LiveBus(
        id: 'Bus-C',
        routeNumber: '28',
        routePath: _sampleBusRoutes['route_28_airport_sahidgate']!,
      ));
    }
  }

  void _startTracking() {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(milliseconds: 500), (Timer timer) {
      for (final LiveBus bus in _buses) {
        bus.moveNext();
      }
      notifyListeners(); // Notify listeners to rebuild the map with new positions
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}


class AuthApp extends StatelessWidget {
  const AuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <ChangeNotifierProvider<ChangeNotifier>>[
        ChangeNotifierProvider<LanguageProvider>(
          create: (BuildContext context) => LanguageProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (BuildContext context) => AuthProvider(),
        ),
        ChangeNotifierProvider<BusLocationTracker>( // Add BusLocationTracker
          create: (BuildContext context) => BusLocationTracker(),
          lazy: false, // Eagerly create to start tracking immediately
        ),
      ],
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: 'Authentication UI', // Renamed title
          debugShowCheckedModeBanner: false,
          initialRoute: '/loading', // Set initial route to loading page
          routes: <String, WidgetBuilder>{
            '/loading': (BuildContext context) =>
                LoadingPage(), // Add loading page route
            '/signup': (BuildContext context) => SignupPage(),
            '/login': (BuildContext context) => LoginPage(),
            '/home': (BuildContext context) =>
                HomePage(), // New route for Home page
            // The MapPage route needs to be defined with a builder that accepts arguments
            // as it will be pushed with arguments from _HomeContentPage.
            // For simplicity and direct argument passing, we'll push it directly
            // instead of using a named route with arguments for now.
            // '/map_display': (BuildContext context) => MapPage(), // Removed this as it's not how it's being pushed
          },
          theme: ThemeData(
            // Apply GoogleFonts.raleway as the default font for the entire app
            // This ensures consistency without manually setting for every Text widget.
            textTheme: GoogleFonts.ralewayTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
        );
      },
    );
  }
}

/// A custom widget for consistent input field styling.
class _AuthInputField extends StatelessWidget {
  final String hintKey;
  final bool obscure;
  final TextEditingController controller;

  _AuthInputField({
    super.key,
    required this.hintKey,
    this.obscure = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = context.watch<LanguageProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: GoogleFonts.raleway(
          color: _darkBlue,
        ), // Input text color changed to dark blue
        decoration: InputDecoration(
          hintText: languageProvider.getString(hintKey), // Localized hint
          hintStyle: GoogleFonts.raleway(
            color: Colors.grey[400],
          ), // Hint text color changed to lighter grey
          filled: true,
          fillColor: _white, // Consistent with new palette
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: _lightBlue,
              width: 1,
            ), // Light blue border
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: _lightBlue,
              width: 1,
            ), // Light blue border when enabled
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: _lightBlue,
              width: 2,
            ), // Light blue border when focused
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),
        ),
      ),
    );
  }
}

/// A reusable widget for drawing the decorative circles on auth pages.
class _DecorativeCircles extends StatelessWidget {
  final Size screenSize;
  final bool isLoginPage;

  const _DecorativeCircles({
    super.key,
    required this.screenSize,
    this.isLoginPage = false, // Default to signup page layout
  });

  @override
  Widget build(BuildContext context) {
    final double circleRadius = screenSize.width * 0.9;
    return Stack(
      children: <Widget>[
        // Large dark blue half-circle at the top
        Positioned(
          // Adjusted 'top' value to position the semi-circle to be halfway through the name box.
          // A less negative value moves the circle downwards, extending the visible blue area.
          top: -circleRadius * 0.7,
          left: screenSize.width / 2 - circleRadius, // Center it horizontally
          child: Container(
            width: circleRadius * 2,
            height: circleRadius * 2,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: _darkBlue,
            ),
          ),
        ),
        // Top decorative circles (different for login/signup)
        if (!isLoginPage) ...<Widget>[
          // Signup Top Left decorative
          Positioned(
            top: screenSize.height * 0.08,
            left: screenSize.width * 0.65,
            child: Container(
              width: screenSize.width * 0.15,
              height: screenSize.width * 0.15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _lightBlue.withOpacity(0.5),
              ),
            ),
          ),
          Positioned(
            top: screenSize.height * 0.13,
            left: screenSize.width * 0.57,
            child: Container(
              width: screenSize.width * 0.1,
              height: screenSize.width * 0.1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _lightGrey.withOpacity(0.5),
              ),
            ),
          ),
          Positioned(
            top: screenSize.height * 0.17,
            left: screenSize.width * 0.72,
            child: Container(
              width: screenSize.width * 0.08,
              height: screenSize.width * 0.08,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _lightBlue.withOpacity(0.5),
              ),
            ),
          ),
          Positioned(
            top: screenSize.height * 0.09,
            left: screenSize.width * 0.5,
            child: Container(
              width: screenSize.width * 0.05,
              height: screenSize.width * 0.05,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _lightGrey.withOpacity(0.5),
              ),
            ),
          ),
        ] else ...<Widget>[
          // Login Top Right decorative
          Positioned(
            top: screenSize.height * 0.08,
            right: screenSize.width * 0.13,
            child: Container(
              width: screenSize.width * 0.15,
              height: screenSize.width * 0.15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _lightBlue.withOpacity(0.5),
              ),
            ),
          ),
          Positioned(
            top: screenSize.height * 0.13,
            right: screenSize.width * 0.2,
            child: Container(
              width: screenSize.width * 0.1,
              height: screenSize.width * 0.1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _lightGrey.withOpacity(0.5),
              ),
            ),
          ),
          Positioned(
            top: screenSize.height * 0.17,
            right: screenSize.width * 0.1,
            child: Container(
              width: screenSize.width * 0.08,
              height: screenSize.width * 0.08,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _lightBlue.withOpacity(0.5),
              ),
            ),
          ),
          Positioned(
            top: screenSize.height * 0.09,
            right: screenSize.width * 0.28,
            child: Container(
              width: screenSize.width * 0.05,
              height: screenSize.width * 0.05,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _lightGrey.withOpacity(0.5),
              ),
            ),
          ),
        ],

        // Bottom-left decorative circles (consistent for both pages)
        Positioned(
          bottom: -screenSize.height * 0.07,
          left: -screenSize.width * 0.08,
          child: Container(
            width: screenSize.width * 0.35,
            height: screenSize.width * 0.35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _lightBlue.withOpacity(0.5),
            ),
          ),
        ),
        Positioned(
          bottom: screenSize.height * 0.03,
          left: screenSize.width * 0.13,
          child: Container(
            width: screenSize.width * 0.13,
            height: screenSize.width * 0.13,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _lightGrey.withOpacity(0.5),
            ),
          ),
        ),
        Positioned(
          bottom: screenSize.height * 0.09,
          left: screenSize.width * 0.05,
          child: Container(
            width: screenSize.width * 0.08,
            height: screenSize.width * 0.08,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _lightBlue.withOpacity(0.5),
            ),
          ),
        ),
        Positioned(
          bottom: screenSize.height * 0.13,
          left: screenSize.width * 0.18,
          child: Container(
            width: screenSize.width * 0.05,
            height: screenSize.width * 0.05,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _lightGrey.withOpacity(0.5),
            ), // Fix: Changed BoxBoxShape to BoxShape
          ),
        ),
      ],
    );
  }
}

class LoadingPage extends StatefulWidget {
  LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatusAndNavigate();
  }

  Future<void> _checkAuthStatusAndNavigate() async {
    // Simulate a loading delay
    await Future<void>.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final AuthProvider authProvider = context.read<AuthProvider>();
    if (authProvider.currentUserEmail != null) {
      // User is already logged in, navigate to Home page
      Navigator.of(context).pushAndRemoveUntil<void>(
        _buildPageRouteWithSlideTransition(HomePage()),
            (Route<dynamic> route) => false,
      );
    } else {
      // No user logged in, navigate to Login page
      Navigator.of(context).pushAndRemoveUntil<void>(
        _buildPageRouteWithSlideTransition(LoginPage()),
            (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkBlue, // Use dark blue as the background for loading
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // App Logo/Icon
            Image.network(
              'https://i.ibb.co/JW1ccdRL/tranzitlogog.png', // Logo URL
              height: 100, // Adjust height as needed
              width: 100, // Adjust width as needed
              fit: BoxFit.contain,
              loadingBuilder:
                  (
                  BuildContext context,
                  Widget child,
                  ImageChunkEvent? loadingProgress,
                  ) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                    color: _white, // Loading indicator color
                  ),
                );
              },
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                return const Center(
                  child: Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 50,
                  ), // Error icon for logo
                );
              },
            ),
            const SizedBox(height: 20),
            // App Name
            Text(
              'TranzITनेपाल',
              style: GoogleFonts.raleway(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: _white,
              ),
            ),
            const SizedBox(height: 30),
            // Loading indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(_lightBlue),
            ),
            const SizedBox(height: 20),
            // Loading text (optional)
            Text(
              'Loading...',
              style: GoogleFonts.raleway(
                fontSize: 16,
                color: _white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignupPage extends StatefulWidget {
  SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController(); // Initialize new controller
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose(); // Dispose new controller
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignup() {
    final AuthProvider authProvider = context.read<AuthProvider>();
    final LanguageProvider languageProvider = context.read<LanguageProvider>();

    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(languageProvider.getString('passwords_do_not_match')),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Attempt to register
    final bool registered = authProvider.register(email, password);

    if (registered) {
      // Registration successful, navigate to HomePage
      Navigator.of(context).pushAndRemoveUntil<void>(
        _buildPageRouteWithSlideTransition(HomePage()),
            (Route<dynamic> route) => false,
      );
    } else {
      // Registration failed (e.g., email already exists or empty fields)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(languageProvider.getString('registration_failed')),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final LanguageProvider languageProvider = context.watch<LanguageProvider>();

    return Scaffold(
      backgroundColor: _white, // Scaffold background is white
      body: Stack(
        children: <Widget>[
          _DecorativeCircles(screenSize: screenSize, isLoginPage: false),
          // Main content Column within SafeArea
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: SingleChildScrollView(
                // Added SingleChildScrollView to prevent overflow
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Added to fix layout error
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 60,
                    ), // Space for "Create Account" text
                    Text(
                      languageProvider.getString(
                        'create_account_title',
                      ), // Localized text
                      style: GoogleFonts.raleway(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: _white, // Text color consistent with new palette
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.loose,
                      child: const SizedBox.shrink(),
                    ), // Replaced Spacer with Flexible
                    _AuthInputField(
                      hintKey: 'name_hint', // Use hintKey
                      controller: _nameController,
                    ),
                    _AuthInputField(
                      hintKey: 'email_hint', // New email field
                      controller: _emailController,
                    ),
                    _AuthInputField(
                      hintKey: 'phone_number_hint', // Use hintKey
                      controller: _phoneController,
                    ),
                    _AuthInputField(
                      hintKey: 'password_hint', // Use hintKey
                      obscure: true,
                      controller: _passwordController,
                    ),
                    _AuthInputField(
                      hintKey: 'confirm_password_hint', // Use hintKey
                      obscure: true,
                      controller: _confirmPasswordController,
                    ),
                    const SizedBox(height: 20), // Spacing before the button row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          languageProvider.getString(
                            'signup_button',
                          ), // Localized text
                          style: GoogleFonts.raleway(
                            fontSize: 16,
                            color: _darkBlue,
                          ), // Text color changed to dark blue
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap:
                          _handleSignup, // Call the new _handleSignup method
                          child: const CircleAvatar(
                            radius: 20,
                            backgroundColor: _darkBlue, // Changed to _darkBlue
                            child: Icon(Icons.arrow_forward, color: _white),
                          ),
                        ),
                      ],
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: const SizedBox.shrink(),
                    ), // Replaced Spacer with Flexible
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: GestureDetector(
                        onTap: () =>
                            Navigator.of(context).pushReplacement<void, void>(
                              _buildPageRouteWithSlideTransition(LoginPage()),
                            ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: const BoxDecoration(
                            color: _darkBlue, // Changed to _darkBlue
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(
                                0,
                              ), // Removed topRight curve
                              topLeft: Radius.circular(
                                40,
                              ), // Added topLeft curve
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                            ),
                          ),
                          child: Text(
                            languageProvider.getString(
                              'already_have_account_question',
                            ), // Localized text
                            style: GoogleFonts.raleway(
                              color: _white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20), // Bottom padding
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    final AuthProvider authProvider = context.read<AuthProvider>();
    final LanguageProvider languageProvider = context.read<LanguageProvider>();

    final String email = _emailController.text;
    final String password = _passwordController.text;

    if (authProvider.login(email, password)) {
      // Login successful, navigate to HomePage
      Navigator.of(context).pushAndRemoveUntil<void>(
        _buildPageRouteWithSlideTransition(HomePage()),
            (Route<dynamic> route) => false,
      );
    } else {
      // Login failed, show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(languageProvider.getString('invalid_credentials')),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final LanguageProvider languageProvider = context.watch<LanguageProvider>();

    return Scaffold(
      backgroundColor: _white, // Scaffold background is white
      body: Stack(
        children: <Widget>[
          _DecorativeCircles(screenSize: screenSize, isLoginPage: true),
          // Main content Column within SafeArea
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: SingleChildScrollView(
                // Added SingleChildScrollView to prevent overflow
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Added to fix layout error
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 60), // Space for "Welcome Back" text
                    Text(
                      languageProvider.getString(
                        'welcome_back_title',
                      ), // Localized text
                      style: GoogleFonts.raleway(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: _white, // Text color consistent with new palette
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.loose,
                      child: const SizedBox.shrink(),
                    ), // Replaced Spacer with Flexible
                    _AuthInputField(
                      hintKey: 'email_hint', // Use hintKey
                      controller: _emailController,
                    ),
                    _AuthInputField(
                      hintKey: 'password_hint', // Use hintKey
                      obscure: true,
                      controller: _passwordController,
                    ),
                    const SizedBox(
                      height: 10,
                    ), // Small space after password field
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          languageProvider.getString(
                            'forgot_password_question',
                          ), // Localized text
                          style: GoogleFonts.raleway(
                            fontSize: 12,
                            color: Colors.red, // Changed to red as requested
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ), // Spacing before the login button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          // Added "Login" text
                          languageProvider.getString(
                            'login_button',
                          ), // Localized text
                          style: GoogleFonts.raleway(
                            fontSize: 16,
                            color: _darkBlue,
                          ),
                        ),
                        const SizedBox(width: 10), // Added spacing
                        GestureDetector(
                          onTap:
                          _handleLogin, // Call the new _handleLogin method
                          child: const CircleAvatar(
                            radius: 20,
                            backgroundColor: _darkBlue, // Changed to _darkBlue
                            child: Icon(Icons.arrow_forward, color: _white),
                          ),
                        ),
                      ],
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: const SizedBox.shrink(),
                    ), // Replaced Spacer with Flexible
                    Align(
                      alignment: Alignment
                          .bottomRight, // Align button to bottom-right within its space
                      child: GestureDetector(
                        onTap: () =>
                            Navigator.of(context).pushReplacement<void, void>(
                              _buildPageRouteWithSlideTransition(SignupPage()),
                            ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 14,
                          ),
                          decoration: const BoxDecoration(
                            color: _darkBlue, // Changed to _darkBlue
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(
                                40,
                              ), // Changed to rounded top right
                              topLeft: Radius.circular(0), // No top left curve
                              bottomRight: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                            ),
                          ),
                          child: Text(
                            languageProvider.getString(
                              'create_account_button',
                            ), // Localized text
                            style: GoogleFonts.raleway(
                              color: _white,
                              fontWeight: FontWeight.bold,
                            ), // Text color consistent
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20), // Bottom padding
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// DATA_MODEL for HomePage
enum BusStatus { notCrowded, crowded, almostCrowded }

class BusRoute {
  final String number;
  final String routeKey; // Key for localized route name
  final String timeAwayKey; // Key for localized time away message
  final BusStatus status;
  final String minutesAgoKey; // Key for localized minutes ago message

  BusRoute({
    required this.number,
    required this.routeKey,
    required this.timeAwayKey,
    required this.status,
    required this.minutesAgoKey,
  });
}

final List<BusRoute> _liveBuses = <BusRoute>[
  BusRoute(
    number: '33',
    routeKey: 'bus_route_33',
    timeAwayKey: 'bus_time_away_33',
    status: BusStatus.notCrowded,
    minutesAgoKey: 'bus_minutes_ago_2',
  ),
  BusRoute(
    number: '57',
    routeKey: 'bus_route_57',
    timeAwayKey: 'bus_time_away_57',
    status: BusStatus.crowded,
    minutesAgoKey: 'bus_minutes_ago_2',
  ),
  BusRoute(
    number: '28',
    routeKey: 'bus_route_28',
    timeAwayKey: 'bus_time_away_28',
    status: BusStatus.almostCrowded,
    minutesAgoKey: 'bus_minutes_ago_3',
  ),
  BusRoute(
    number: '92',
    routeKey: 'bus_route_92',
    timeAwayKey: 'bus_time_away_92',
    status: BusStatus.notCrowded,
    minutesAgoKey: 'bus_minutes_ago_2',
  ),
];

// DATA_MODEL for detailed route planning
class RoutePoint {
  final String name;
  final double distanceKm; // Distance from the system's origin terminal

  RoutePoint({required this.name, required this.distanceKm});
}

class BusSystem {
  final String systemId; // e.g., 'A', 'B'
  final String originTerminal;
  final String destinationTerminal;
  final List<RoutePoint>
  routePoints; // Includes origin, intermediates, and destination

  BusSystem({
    required this.systemId,
    required this.originTerminal,
    required this.destinationTerminal,
    required this.routePoints,
  });

  // Helper to get all unique place names in this system
  Set<String> getAllPlaces() {
    final Set<String> places = <String>{};
    places.add(originTerminal);
    places.add(destinationTerminal);
    for (final RoutePoint point in routePoints) {
      places.add(point.name);
    }
    return places;
  }
}

// Helper function to generate route points with approximate distances
List<RoutePoint> _generateRoutePoints(List<String> stopNames) {
  final List<RoutePoint> points = <RoutePoint>[];
  double currentDistance = 0.0;
  const double distanceIncrement = 1.5; // Approx 1.5 km per stop
  for (final String name in stopNames) {
    points.add(RoutePoint(name: name, distanceKm: currentDistance));
    currentDistance += distanceIncrement;
  }
  return points;
}

final List<BusSystem> _busSystems = <BusSystem>[
  BusSystem(
    systemId: 'A',
    originTerminal: 'Jorpati',
    destinationTerminal: 'Ratnapark', // Standardized
    routePoints: <RoutePoint>[
      RoutePoint(name: 'Jorpati', distanceKm: 0),
      RoutePoint(name: 'Gausala', distanceKm: 5),
      RoutePoint(name: 'Sundarijal', distanceKm: 15),
      RoutePoint(name: 'Sankhu', distanceKm: 19),
      RoutePoint(name: 'Ratnapark', distanceKm: 25), // Standardized
    ],
  ),
  BusSystem(
    systemId: 'B',
    originTerminal: 'Lagankhel',
    destinationTerminal: 'Ratnapark (Lagankhel)', // Standardized
    routePoints: <RoutePoint>[
      RoutePoint(name: 'Lagankhel', distanceKm: 0),
      RoutePoint(name: 'Patandhoka', distanceKm: 5),
      RoutePoint(name: 'Lagankhel -', distanceKm: 7.5),
      RoutePoint(name: 'Godavari', distanceKm: 18),
      RoutePoint(name: 'Chapagaon', distanceKm: 18),
      RoutePoint(name: 'Ratnapark (Lagankhel)', distanceKm: 25), // Standardized
    ],
  ),
  BusSystem(
    systemId: 'C',
    originTerminal: 'Kirtipur',
    destinationTerminal: 'Ratnapark', // Standardized
    routePoints: <RoutePoint>[
      RoutePoint(name: 'Kirtipur', distanceKm: 0),
      RoutePoint(name: 'Kimdol (Swayambu)', distanceKm: 6),
      RoutePoint(name: 'Kirtipur', distanceKm: 8),
      RoutePoint(name: 'Thankot', distanceKm: 10),
      RoutePoint(name: 'Ratnapark', distanceKm: 15), // Standardized
    ],
  ),
  BusSystem(
    systemId: 'D',
    originTerminal: 'Air Port',
    destinationTerminal: 'Shahid Gate',
    routePoints: <RoutePoint>[
      RoutePoint(name: 'Air Port', distanceKm: 0),
      RoutePoint(name: 'Air Port', distanceKm: 8),
      RoutePoint(name: 'Bhadgaou (Bhaktapur)', distanceKm: 14),
      RoutePoint(name: 'Dhulinkhel', distanceKm: 30),
      RoutePoint(name: 'Shahid Gate', distanceKm: 35), // Assumed final distance
    ],
  ),
  BusSystem(
    systemId: 'E',
    originTerminal: 'Balaju',
    destinationTerminal: 'Jamal',
    routePoints: <RoutePoint>[
      RoutePoint(name: 'Balaju', distanceKm: 0),
      RoutePoint(name: 'Balaju', distanceKm: 5),
      RoutePoint(name: 'Narayansthan', distanceKm: 10.5),
      RoutePoint(name: 'Jamal', distanceKm: 15), // Assumed final distance
    ],
  ),
  BusSystem(
    systemId: 'F',
    originTerminal: 'Tangal',
    destinationTerminal: 'Ratnapark', // Standardized
    routePoints: <RoutePoint>[
      RoutePoint(name: 'Tangal', distanceKm: 0),
      RoutePoint(name: 'Bishalugar', distanceKm: 5),
      RoutePoint(name: 'Ratnapark', distanceKm: 10), // Standardized
    ],
  ),
  BusSystem(
    systemId: 'G',
    originTerminal: 'Dakshinkali',
    destinationTerminal: 'Shahid Gate',
    routePoints: <RoutePoint>[
      RoutePoint(name: 'Dakshinkali', distanceKm: 0),
      RoutePoint(name: 'Dakshinkali', distanceKm: 22),
      RoutePoint(name: 'Shahid Gate', distanceKm: 30), // Assumed final distance
    ],
  ),
  // New bus systems added from user prompt
  // 1)Bhaktapur - Purano Thimi- Purano Buspark bus routes
  BusSystem(
    systemId: 'H',
    originTerminal: 'Bagbazar',
    destinationTerminal: 'Dudhpati Bus Stop',
    routePoints: _generateRoutePoints(<String>[
      'Bagbazar',
      'Maitighar',
      'Buddhanagar Stop',
      'Naya Baneshwar Bus Station',
      'Minbhawan Stop',
      'Shantinagar Stop',
      'Tinkune Stop',
      'Koteshwor Stop',
      'Jadibti Stop',
      'Pepsicola Stop',
      'Panika Stop',
      'Siddhikali Chowk Bus Stop',
      'Bahakha Bazar Bus Stop',
      'Radheradhe Chowk Bus Stop',
      'Hindunagar Chowk Bus Stop',
      'Dhungedhara Chowk Bus Stop',
      'Dudhpati Bus Stop',
    ]),
  ),
  // 2)Lagankhel - Naya Buspark ( Ringroad ) bus routes
  BusSystem(
    systemId: 'I',
    originTerminal: 'Lagankhel Stop',
    destinationTerminal: 'Naya Buspark', // Standardized
    routePoints: _generateRoutePoints(<String>[
      'Lagankhel Stop',
      'Batuk Bhairav',
      'Lalitpur Industrial Estate',
      'Satdobato',
      'B & B Hospital/KCM stop',
      'Gwarko Chok',
      'Koteshwar Stop',
      'Gairigaun Stop',
      'Sinamangal Ring Road Stop',
      'Airport Bus Station',
      'Chabahil',
      'Gopi Krishna Stop',
      'Sukedhara Stop',
      'Chapal Karkhana stop',
      'Narayan Gopal Chok',
      'Basundhara',
      'Samakhusi Stop',
      'Gongabu Chok',
      'Naya Buspark', // Standardized
    ]),
  ),
  // 3)Purana Buspark - Chabahil bus routes
  BusSystem(
    systemId: 'J',
    originTerminal: 'Bhadrakali',
    destinationTerminal: 'Maharajgunj Chowk',
    routePoints: _generateRoutePoints(<String>[
      'Bhadrakali',
      'Singha Durbar West Stop',
      'Maitighar',
      'Buddhanagar Stop',
      'Naya Baneshwar Bus Station',
      'Minbhawan Stop',
      'Shantinagar Stop',
      'Tinkune Stop',
      'Gairigaun Stop',
      'Sinamangal Ring Road Stop',
      'Airport Bus Station',
      'Gaushala Chok Stop',
      'Chabahil',
      'Gopikrishna Stop',
      'Dhumbarahi Stop',
      'Chappalkarkhana Stop',
      'Maharajgunj Chowk',
    ]),
  ),
  // 4)Budhanilkantha School - Ratna Park bus routes
  BusSystem(
    systemId: 'K',
    originTerminal: 'Budhanilkantha School Blue Micro Stand',
    destinationTerminal: 'Ratnapark', // Standardized
    routePoints: _generateRoutePoints(<String>[
      'Budhanilkantha School Blue Micro Stand',
      'Budhanilkantha Micro Stand',
      'Golfutar stop',
      'Bansbari stop',
      'Chakrapath Stop-- South',
      'Panipokhari stop',
      'Lazimpat stop',
      'Lainchaur stop',
      'Kantipath',
      'Ratnapark', // Standardized
    ]),
  ),
  // 5)Kalanki - TIA Airport bus routes
  BusSystem(
    systemId: 'L',
    originTerminal: 'Kalanki Chowk',
    destinationTerminal: 'Airport Bus Station',
    routePoints: _generateRoutePoints(<String>[
      'Kalanki Chowk',
      'Kalimati',
      'Tripureshwar',
      'Thapathali',
      'Maitighar Stop--South',
      'Maitighar',
      'Buddhanagar Stop',
      'Naya Baneshwar Bus Station',
      'Minbhawan Stop',
      'Shantinagar Stop',
      'Tinkune Stop',
      'Gairigaun',
      'Sinamangal Stop',
      'Airport Bus Station',
    ]),
  ),
  // 6)Chakrapath - Parikrama bus routes (Circular route, origin/destination same for planning)
  BusSystem(
    systemId: 'M',
    originTerminal: 'Gaushala Chowk Stop',
    destinationTerminal:
    'Gaushala', // Ending point for calculation, can be same as origin for circular
    routePoints: _generateRoutePoints(<String>[
      'Gaushala Chowk Stop',
      'Gopi Krishna Stop',
      'Sukedharastop',
      'Dhumbarahi Stop',
      'Chappal Karkhana Stop',
      'Narayan Gopal Stop',
      'Basundhara Stop',
      'Samakhusi Stop',
      'Gongabu Stop',
      'Macchapokhari Stop',
      'Balaju stop',
      'Banasthali Stop',
      'Dhungedhara Stop',
      'Sano Bharyang',
      'Thulo Bharyang',
      'Swyambhu Stop',
      'Kalanki Chowk',
      'Khasibazaar',
      'Balkhu',
      'Sanepa Height',
      'Ekantakuna',
      'Satdobato Stop',
      'Gwarko Stop',
      'Koteshwor Stop',
      'Tinkune Stop',
      'Sinamangal Stop',
      'Pinglasthan',
      'Gaushala',
    ]),
  ),
  // 7)Gothatar - Purano Buspark bus routes
  BusSystem(
    systemId: 'N',
    originTerminal: 'Bagbazar',
    destinationTerminal: 'Gothatar Stop',
    routePoints: _generateRoutePoints(<String>[
      'Bagbazar',
      'Maitighar',
      'Buddhanagar Stop',
      'Naya Baneshwar Bus Station',
      'Minbhawan Stop',
      'Shantinagar Stop',
      'Tinkune Stop',
      'Koteshwor Stop',
      'Jadibti Stop',
      'Pepsicola Stop',
      'Khahare Chowk Bus Stop',
      'Gothatar Stop',
    ]),
  ),
  // 8)Kalanki - Pepsicola bus routes
  BusSystem(
    systemId: 'O',
    originTerminal: 'Kalanki Chowk',
    destinationTerminal: 'Pepsicola Chowk Stop',
    routePoints: _generateRoutePoints(<String>[
      'Kalanki Chowk',
      'Kalimati',
      'Tripureshwar',
      'Thapathali',
      'Maitighar Stop--South',
      'Maitighar',
      'Buddhanagar Stop',
      'Naya Baneshwar Bus Station',
      'Minbhawan Stop',
      'Shantinagar Stop',
      'Tinkune Stop',
      'Koteshwar Stop',
      'Jadibuti Stop',
      'Pepsicola Chowk Stop',
    ]),
  ),
  // 9)Kamalbinayak - Ratnapark bus routes
  BusSystem(
    systemId: 'P',
    originTerminal: 'Ratnapark', // Standardized
    destinationTerminal: 'Kamalbinayak Stop',
    routePoints: _generateRoutePoints(<String>[
      'Ratnapark', // Standardized
      'Bhadrakali',
      'Singha Durbar West Stop',
      'Maitighar',
      'Buddhanagar Stop',
      'Naya Baneshwar Bus Station',
      'Minbhawan Stop',
      'Shantinagar Stop',
      'Tinkune Stop',
      'Koteshwor Stop',
      'Lokanthali Stop',
      'Gathaghar Stop',
      'Shrijananagar Stop',
      'Dudhpati',
      'Byasi',
      'Kamalbinayak Stop',
    ]),
  ),
  // 10)Purano Bus Park - Sakhu bus routes
  BusSystem(
    systemId: 'Q',
    originTerminal: 'Purano Buspark', // Standardized
    destinationTerminal: 'Sakhu',
    routePoints: _generateRoutePoints(<String>[
      'Purano Buspark', // Standardized
      'Tundikhel',
      'Singha Durbar',
      'Maitighar Mandala',
      'Nayabaneshwor',
      'Minbhawan Stop',
      'Shentinagar Stop',
      'Tinkune Stop',
      'Gairigaun Stop',
      'Sinamangal Ring Road Stop',
      'Airport Bus Station',
      'Gaushala Chok Stop',
      'Chabahil',
      'Hyatt Regency',
      'Boudha',
      'Jorpati',
      'Narayantar Bridge',
      'Mulpani',
      'Thali',
      'Sakhu',
    ]),
  ),
  // 11)Ratnapark - Chyamasingh bus routes
  BusSystem(
    systemId: 'R',
    originTerminal: 'Bagbazar',
    destinationTerminal: 'Chyamasing Bus Stop',
    routePoints: _generateRoutePoints(<String>[
      'Bagbazar',
      'Bhadrakali',
      'Singha Durbar West Stop',
      'Maitighar',
      'Buddhanagar Stop',
      'Naya Baneshwar Bus Station',
      'Minbhawan Stop',
      'Shantinagar Stop',
      'Tinkune Stop',
      'Koteshwor Stop',
      'Lokanthali Stop',
      'Gathaghar Stop',
      'Shrijananagar Stop',
      'Sallaghari Stop',
      'Chunudevi',
      'Suotabinayak Stop',
      'Dholeshwor Mahadev Bus Stop',
      'Adarsha Bus Stop',
      'Jagati Bus Stop',
      'Chyamasing Bus Stop',
    ]),
  ),
  // New routes from prompt (7-20)
  BusSystem(
    systemId: 'S',
    originTerminal: 'Naikap',
    destinationTerminal: 'Kausaltar',
    routePoints: _generateRoutePoints(<String>[
      'Naikap',
      'Kalanki Chowk',
      'Kalimati',
      'Tripureshwor',
      'Thapathali',
      'Maitighar Stop--South',
      'Maitighar',
      'Buddhanagar Stop',
      'Naya Baneshwar Bus Station',
      'Minbhawan Stop',
      'Shantinagar Stop',
      'Tinkune Stop',
      'Koteshwar Stop',
      'Jadibuti',
      'Lokanthali',
      'Kausaltar',
    ]),
  ),
  BusSystem(
    systemId: 'T',
    originTerminal: 'Ratnapark', // Standardized
    destinationTerminal: 'Changunarayan Stop',
    routePoints: _generateRoutePoints(<String>[
      'Ratnapark', // Standardized
      'Singha Durbar West Stop',
      'Maitighar',
      'Buddhanagar Stop',
      'Naya Baneshwar Bus Station',
      'Minbhawan Stop',
      'Shantinagar Stop',
      'Tinkune Stop',
      'Koteshwor Stop',
      'Lokanthali Stop',
      'Gathaghar Stop',
      'Gaushala Chok Stop',
      'Shrijananagar Stop',
      'Dudhpati',
      'Byasi',
      'Changunarayan Road',
      'Changunarayan Stop',
    ]),
  ),
  BusSystem(
    systemId: 'U',
    originTerminal: 'Bhadrakali',
    destinationTerminal: 'Panauti',
    routePoints: _generateRoutePoints(<String>[
      'Bhadrakali',
      'Singha Durbar West Stop',
      'Maitighar',
      'Buddhanagar Stop',
      'Naya Baneshwar Bus Station',
      'Minbhawan Stop',
      'Tinkune Stop',
      'Jadibuti',
      'Kausaltar',
      'Gathaghar',
      'Thimi',
      'Srijana nagar',
      'Tinkune Bhaktapur',
      'Sallaghari Stop',
      'Chunudevi',
      'Barahi Movies',
      'Suryabinayek',
      'Adarsha',
      'Jagati',
      'Sanga',
      'Bansdol',
      'Banepa Tindobato',
      'Khadpu',
      'Panauti',
    ]),
  ),
  BusSystem(
    systemId: 'V',
    originTerminal: 'Purano Buspark', // Standardized
    destinationTerminal: 'Budhanilkantha Stop',
    routePoints: _generateRoutePoints(<String>[
      'Purano Buspark', // Standardized
      'Deuba Chowk stop',
      'Kantipath',
      'Lainchaur stop',
      'Lazimpat stop',
      'Panipokhari stop',
      'Chakrapath Stop-- South',
      'Bansbari stop',
      'Golfutar stop',
      'Budhanilkantha Stop',
    ]),
  ),
  BusSystem(
    systemId: 'W',
    originTerminal: 'Jorpati',
    destinationTerminal: 'Purano Buspark', // Standardized
    routePoints: _generateRoutePoints(<String>[
      'Jorpati',
      'Bouddha',
      'Chuchepati',
      'Chabahil',
      'Mitrapark',
      'Gaushala',
      'Battisputali',
      'Purano Baneshwor',
      'Setopul',
      'Dillibazar',
      'Putalisadak',
      'Bagbazar',
      'Purano Buspark', // Standardized
    ]),
  ),
  BusSystem(
    systemId: 'X',
    originTerminal: 'Ratnapark', // Standardized
    destinationTerminal: 'Sundarijal',
    routePoints: _generateRoutePoints(<String>[
      'Ratnapark', // Standardized
      'Singha Durbar West Stop',
      'Kamalpokhari',
      'Gyanehwor',
      'Ratopul',
      'Gaushala',
      'Mitrapark',
      'Chabahil',
      'Chuchepati',
      'Bouddha',
      'Jorpati',
      'Gokarneshwor Mahadev Temple',
      'Nayapati',
      'Sundarijal',
    ]),
  ),
  BusSystem(
    systemId: 'Y',
    originTerminal: 'Gokarna Bus Stop',
    destinationTerminal: 'Kalanki Chowk',
    routePoints: _generateRoutePoints(<String>[
      'Gokarna Bus Stop',
      'Jorpati',
      'Boudha',
      'Hyatt Regency',
      'Chabahil',
      'Gopi Krishna Stop',
      'Dhumbarahi',
      'Narayan Gopal Chok',
      'Samakhusi Stop',
      'Naya Buspark', // Standardized
      'Balaju',
      'Dhungedhara',
      'Kalanki Chowk',
    ]),
  ),
  BusSystem(
    systemId: 'Z',
    originTerminal: 'Sukedhara Stop',
    destinationTerminal: 'Balkumari Bus Stop',
    routePoints: _generateRoutePoints(<String>[
      'Sukedhara Stop',
      'Dhumbarahi Stop',
      'Chappal Kerkhana',
      'Narayan Gopal Chowk',
      'Baluwatar Bus Stop',
      'Naxal Stop',
      'Mariott Stop',
      'Hattisar Stop',
      'Putali Sadak Stop',
      'New Plaza Bus Stop',
      'Ghattekulo Bus Stop',
      'Hanumansthan Bus Stop',
      'New Baneshwor',
      'Minbhawan Bus Stand',
      'Tinkune Bus Stand',
      'Koteshwor Bus Stand',
      'Balkumari Bus Stop',
    ]),
  ),
  BusSystem(
    systemId: 'AA',
    originTerminal: 'Ratnapark', // Standardized
    destinationTerminal: 'Dakhinkali Temple',
    routePoints: _generateRoutePoints(<String>[
      'Ratnapark', // Standardized
      'Kalimati',
      'Kuleshwor',
      'Balkhu',
      'Chobar',
      'Taudaha',
      'Chalnakhel Bus Stop',
      'Satikhel',
      'Bhanjyang Bus Stop',
      'Dollu Bus stop',
      'Satikhel Bus Stop',
      'Dakhinkali Temple',
    ]),
  ),
  BusSystem(
    systemId: 'BB',
    originTerminal: 'Bhadrakali',
    destinationTerminal: 'Purano Buspark', // Standardized
    routePoints: _generateRoutePoints(<String>[
      'Bhadrakali',
      'Singha Durbar West Stop',
      'Maitighar',
      'Buddhanagar Stop',
      'Naya Baneshwar Bus Station',
      'Minbhawan Stop',
      'Shantinagar Stop',
      'Tinkune Stop',
      'Gairigaun Stop',
      'Sinamangal Ring Road Stop',
      'Airport Bus Station',
      'Gaushala Chok Stop',
      'Chabahil',
      'Hyatt Regency',
      'Boudha',
      'Jorpati',
      'Attarkhel',
      'Purano Buspark', // Standardized
    ]),
  ),
  BusSystem(
    systemId: 'CC',
    originTerminal: 'Kalanki Chowk',
    destinationTerminal: 'Balkumari Stop',
    routePoints: _generateRoutePoints(<String>[
      'Kalanki Chowk',
      'Kalimati',
      'Tripureshwor',
      'Thapathali',
      'Maitighar Stop--South',
      'Maitighar',
      'Buddhanagar Stop',
      'Naya Baneshwar Bus Station',
      'Minbhawan Stop',
      'Shantinagar Stop',
      'Tinkune Stop',
      'Koteshwar Stop',
      'Balkumari Stop',
    ]),
  ),
  BusSystem(
    systemId: 'DD',
    originTerminal: 'Purano Buspark', // Standardized
    destinationTerminal: 'Shivapuri Park Stop',
    routePoints: _generateRoutePoints(<String>[
      'Purano Buspark', // Standardized
      'Deuba Chowk stop',
      'Kantipath',
      'Lainchaur stop',
      'Lazimpat stop',
      'Panipokhari stop',
      'Chakrapath Stop-- South',
      'Bansbari stop',
      'Golfutar stop',
      'Budhanilkantha Micro Stand',
      'Shivapuri Park Stop',
    ]),
  ),
  BusSystem(
    systemId: 'EE',
    originTerminal: 'Bhadrakali',
    destinationTerminal: 'Dhulikhel Bus Station',
    routePoints: _generateRoutePoints(<String>[
      'Bhadrakali',
      'Singha Durbar West Stop',
      'Maitighar',
      'Buddhanagar Stop',
      'Naya Baneshwar Bus Station',
      'Minbhawan Stop',
      'Tinkune Stop',
      'Jadibuti',
      'Kausaltar',
      'Gathaghar',
      'Thimi',
      'Srijana nagar',
      'Tinkune Bhaktapur',
      'Sallaghari Stop',
      'Chunudevi',
      'Barahi Movies',
      'Suryabinayek',
      'Adarsha',
      'Jagati',
      'Sanga',
      'Bansdol',
      'Banepa Tindobato',
      'Budol BUs Station',
      'Basghari',
      'Dhulikhel Bus Station',
    ]),
  ),
  BusSystem(
    systemId: 'FF',
    originTerminal: 'Bagbazar',
    destinationTerminal: 'Kamalbinayak Stop',
    routePoints: _generateRoutePoints(<String>[
      'Bagbazar',
      'Bhadrakali',
      'Singha Durbar West Stop',
      'Maitighar',
      'Buddhanagar Stop',
      'Naya Baneshwar Bus Station',
      'Minbhawan Stop',
      'Shantinagar Stop',
      'Tinkune Stop',
      'Koteshwor Stop',
      'Lokanthali Stop',
      'Gathaghar Stop',
      'Gaushala Chok Stop',
      'Shrijananagar Stop',
      'Dudhpati',
      'Byasi',
      'Kamalbinayak Stop',
    ]),
  ),
];

// DATA_MODEL for a suggested route (direct or with transfer)
class SuggestedRoute {
  final String origin;
  final String destination;
  final List<RouteDetail> routeDetails; // Now a list for multiple legs

  SuggestedRoute({
    required this.origin,
    required this.destination,
    required this.routeDetails,
  });

  // Helper for total distance
  double get totalDistance {
    return routeDetails.fold<double>(
      0.0,
          (double sum, RouteDetail detail) => sum + detail.getTotalDistance(),
    );
  }

  // Helper for total changes (transfers)
  int get totalChanges {
    if (routeDetails.isEmpty) return 0;
    int changes = 0;
    // Iterate from the second leg to count transfers from the previous leg
    for (int i = 1; i < routeDetails.length; i++) {
      if (routeDetails[i].isTransfer) {
        // This flag now correctly indicates a transfer happened to start this leg
        changes++;
      }
    }
    return changes;
  }

  // Helper for total stops. Count all unique stops by traversing the route.
  int get totalStops {
    if (routeDetails.isEmpty) return 0;
    final Set<String> uniqueStops = <String>{};
    for (final RouteDetail leg in routeDetails) {
      for (final RoutePoint point in leg.getSegmentStops()) {
        uniqueStops.add(point.name.toLowerCase());
      }
    }
    return uniqueStops.length;
  }
}

class RouteDetail {
  final BusSystem system;
  final String startPoint;
  final String endPoint;
  final bool isTransfer; // True if this segment is the second leg of a transfer

  RouteDetail({
    required this.system,
    required this.startPoint,
    required this.endPoint,
    this.isTransfer = false,
  });

  // Helper to get stops relevant to this segment
  List<RoutePoint> getSegmentStops() {
    final List<RoutePoint> segment = <RoutePoint>[];
    bool started = false;
    for (final RoutePoint point in system.routePoints) {
      if (point.name.toLowerCase() == startPoint.toLowerCase()) {
        started = true;
      }
      if (started) {
        segment.add(point);
      }
      if (point.name.toLowerCase() == endPoint.toLowerCase()) {
        break;
      }
    }
    return segment;
  }

  double getTotalDistance() {
    // Find the actual start and end points in the system's routePoints to get their distances
    final RoutePoint? actualStart = _firstWhereOrNull<RoutePoint>(
      system.routePoints,
          (RoutePoint p) => p.name.toLowerCase() == startPoint.toLowerCase(),
    );
    final RoutePoint? actualEnd = _firstWhereOrNull<RoutePoint>(
      system.routePoints,
          (RoutePoint p) => p.name.toLowerCase() == endPoint.toLowerCase(),
    );

    if (actualStart != null && actualEnd != null) {
      return (actualEnd.distanceKm - actualStart.distanceKm).abs();
    }
    return 0.0;
  }
}

// Replaced extension with a global helper function to avoid creating extension on Iterable implicitly.
T? _firstWhereOrNull<T>(Iterable<T> iterable, bool Function(T element) test) {
  for (final T element in iterable) {
    if (test(element)) {
      return element;
    }
  }
  return null;
}

// Utility function to get all unique searchable places including fixed ones and those from bus systems
List<String> _getCombinedSearchablePlaces() {
  final Set<String> places = <String>{
    'Kathmandu',
    'Pokhara',
    'Lalitpur',
    'Bhaktapur',
    'Biratnagar',
    'Bharatpur',
    'Birgunj',
    'Janakpur',
    'Hetauda',
    'Butwal',
    'Dharan',
    'Nepalgunj',
    'Ghorahi',
    'Itahari',
    'Mechinagar',
    'Kirtipur',
    'Damak',
    'Tulsipur',
    'Dhangadhi',
    'Siddharthanagar',
    'Birtamod',
    'Kohalpur',
    'Lahan',
    'Tikapur',
    'Gulariya',
    'Dhankuta',
    'Baglung',
    'Bidur',
    'Ilam',
    'Dipayal Silgadhi',
    'Waling',
    'Suryabinayak',
    'Madhyapur Thimi',
    'Tokha',
    'Chandragiri',
    'Budhanilkantha',
    'Godawari',
    'Maharajgunj',
    'Patan',
    'Baneshwor',
    'Kalanki',
    'Jorpati',
    'Ratnapark', // Standardized
    'Airport',
    'Sahid Gate',
    'Balaju',
    'Jamal',
    // Add existing specific route points here if not already covered by busSystems
    // These specific points will be added by iterating _busSystems.getAllPlaces()
  };
  for (final BusSystem system in _busSystems) {
    places.addAll(system.getAllPlaces());
  }
  return places.toList();
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavSelectedIndex = 0; // For BottomNavigationBar display
  late PageController _pageController;
  final GlobalKey<ScaffoldState> _scaffoldKey =
  GlobalKey<ScaffoldState>(); // GlobalKey for Scaffold

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    ); // Start on Home page (PageView index 0)
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onDrawerHomeTap() {
    // Navigate to Home page (PageView index 0)
    if (_pageController.page?.round() != 0) {
      _pageController.jumpToPage(0);
      setState(() {
        _bottomNavSelectedIndex = 0; // Sync bottom nav bar
      });
    }
  }

  void _onDrawerProfileTap() {
    // Placeholder action for Profile
    // The SnackBar message is already handled in _AppDrawer, no need to duplicate here.
  }

  void _onDrawerSettingsTap() {
    // Placeholder action for Settings
    // The SnackBar message is already handled in _AppDrawer, no need to duplicate here.
  }

  void _onDrawerLogoutTap() {
    // Call logout on AuthProvider
    context.read<AuthProvider>().logout();
    // Navigate to Login page and remove all previous routes
    Navigator.of(context).pushAndRemoveUntil<void>(
      _buildPageRouteWithSlideTransition(LoginPage()),
          (Route<dynamic> route) => false,
    );
  }

  // Changed return type from Builder to PreferredSizeWidget, no longer returning Builder
  PreferredSizeWidget _getAppBar(BuildContext context) {
    final LanguageProvider languageProvider = context.watch<LanguageProvider>();

    // Callback to open the drawer using the GlobalKey
    void openDrawerCallback() {
      _scaffoldKey.currentState?.openDrawer();
    }

    switch (_bottomNavSelectedIndex) {
      case 0: // Home
        return _HomeAppBar(
          // No longer uses 'greeting' parameter
          onLeadingPressed:
          openDrawerCallback, // Use the callback to open the drawer
        );
      case 2: // Tip
        return _TipAppBar(title: languageProvider.getString('tip_earn_title'));
      case 3: // SOS
        return _SOSAppBar(
          title: languageProvider.getString('emergency_sos_title'),
        ); // Changed to new title
      default:
      // Default to Home AppBar for language toggle (index 1) or other cases
        return _HomeAppBar(
          // No longer uses 'greeting' parameter
          onLeadingPressed:
          openDrawerCallback, // Use the callback to open the drawer
        );
    }
  }

  void _onBottomNavItemTapped(int index) {
    if (index == 1) {
      // Language toggle, doesn't change the page content
      Provider.of<LanguageProvider>(context, listen: false).toggleLanguage();
      // No state change for _bottomNavSelectedIndex, it stays on the current content page.
    } else {
      setState(() {
        _bottomNavSelectedIndex = index;
      });
      // Map BottomNavBar index to PageView index
      int pageViewIndex = 0;
      if (index == 0) {
        pageViewIndex = 0; // Home
      } else if (index == 2) {
        pageViewIndex = 1; // Tip
      } else if (index == 3) {
        pageViewIndex = 2; // SOS
      }

      _pageController.jumpToPage(pageViewIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the GlobalKey to the Scaffold
      backgroundColor: _white, // Main background
      appBar: _getAppBar(context), // Dynamic AppBar
      drawer: _AppDrawer(
        // Add the drawer here
        onHomeTap: _onDrawerHomeTap,
        onProfileTap: _onDrawerProfileTap,
        onSettingsTap: _onDrawerSettingsTap,
        onLogoutTap: _onDrawerLogoutTap,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (int pageIdx) {
          // Sync PageView changes with BottomNavigationBar selection
          // Map PageView index back to BottomNavBar index
          setState(() {
            if (pageIdx == 0) {
              _bottomNavSelectedIndex = 0; // Home
            } else if (pageIdx == 1) {
              _bottomNavSelectedIndex = 2; // Tip
            } else if (pageIdx == 2) {
              _bottomNavSelectedIndex = 3; // SOS
            }
          });
        },
        children: <Widget>[
          _HomeContentPage(),
          _TipContentPage(),
          const _SOSContentPage(),
        ],
      ),
      bottomNavigationBar: _HomeBottomNavigationBar(
        selectedIndex: _bottomNavSelectedIndex,
        onItemTapped: _onBottomNavItemTapped,
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  // Original properties, now made optional or with default value if not strictly needed when customTitleWidget is present
  final String
  title; // Default value if not provided, used when customTitleWidget is null
  final IconData? leadingIcon;
  final VoidCallback? onLeadingPressed;
  final IconData? titleIcon;
  final List<Widget>? actions;

  // New property for a completely custom title widget (e.g., for HomeAppBar)
  final Widget? customTitleWidget;

  const _CustomAppBar({
    super.key,
    this.title = '', // Default value if not explicitly passed
    this.leadingIcon,
    this.onLeadingPressed,
    this.titleIcon,
    this.actions,
    this.customTitleWidget, // Initialize new property
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: _darkBlue,
      elevation: 0,
      leading: leadingIcon != null
          ? IconButton(
        icon: Icon(leadingIcon, color: _white),
        onPressed:
        onLeadingPressed, // This callback now handles opening the drawer via GlobalKey
      )
          : null,
      title:
      customTitleWidget ??
          Row(
            // Use customTitleWidget if provided, otherwise fallback to existing logic
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (titleIcon != null) ...<Widget>[
                Icon(titleIcon, color: _white, size: 20),
                const SizedBox(width: 8),
              ],
              Text(
                title,
                style: GoogleFonts.raleway(
                  color: _white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20.0);
}

class _HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onLeadingPressed; // Callback for the menu button

  const _HomeAppBar({super.key, this.onLeadingPressed});

  @override
  Widget build(BuildContext context) {
    return _CustomAppBar(
      customTitleWidget: Row(
        mainAxisSize: MainAxisSize.min, // Keep the row compact
        children: <Widget>[
          Image.network(
            'https://i.ibb.co/JW1ccdRL/tranzitlogog.png', // Logo URL
            height: 40, // Adjust height as needed
            width: 40, // Adjust width as needed
            fit: BoxFit.contain,
            loadingBuilder:
                (
                BuildContext context,
                Widget child,
                ImageChunkEvent? loadingProgress,
                ) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                      : null,
                  color: _white, // Loading indicator color
                ),
              );
            },
            errorBuilder:
                (BuildContext context, Object error, StackTrace? stackTrace) {
              return const Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 20,
                ), // Error icon for logo
              );
            },
          ),
          const SizedBox(width: 8), // Space between logo and text
          Text(
            'TranzITनेपाल', // App name
            style: GoogleFonts.raleway(
              color: _white,
              fontWeight: FontWeight.bold,
              fontSize: 20, // Adjust font size for the app name
            ),
          ),
        ],
      ),
      leadingIcon: Icons.menu,
      onLeadingPressed: onLeadingPressed, // Pass the callback to _CustomAppBar
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.notifications_none, color: _white),
          onPressed: () {
            // Placeholder for notifications action
          },
        ),
        IconButton(
          icon: const Icon(Icons.person_outline, color: _white),
          onPressed: () {
            // Placeholder for profile action
          },
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20.0);
}

class _TipAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const _TipAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return _CustomAppBar(
      title: title,
      titleIcon: Icons.lightbulb_outline, // Lightbulb icon
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20.0);
}

class _SOSAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const _SOSAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return _CustomAppBar(
      title: title,
      titleIcon: Icons.public, // Globe icon for SOS
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20.0);
}

// Start of new Map Page
class MapPage extends StatefulWidget {
  final LatLng startPoint;
  final LatLng endPoint;
  final String fromLocation;
  final String toLocation;

  const MapPage({
    super.key,
    this.startPoint = const LatLng(27.7172, 85.3240), // Default Kathmandu
    this.endPoint = const LatLng(27.7031, 85.3336), // Default Patan
    required this.fromLocation, // Marked as required
    required this.toLocation, // Marked as required
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // Use MapController if programmatic map control is needed, e.g., to fit bounds
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = context.watch<LanguageProvider>();
    final BusLocationTracker busLocationTracker = context.watch<BusLocationTracker>();

    final List<Marker> mapMarkers = <Marker>[];
    final List<Polyline> mapPolylines = <Polyline>[];

    // 1. Add User's Trip Markers
    mapMarkers.add(
      Marker(
        width: 80.0,
        height: 80.0,
        point: widget.startPoint,
        child: const Icon(Icons.location_on, size: 40, color: Colors.green), // Green for start
      ),
    );
    mapMarkers.add(
      Marker(
        width: 80.0,
        height: 80.0,
        point: widget.endPoint,
        child: const Icon(Icons.location_on, size: 40, color: Colors.red), // Red for end
      ),
    );

    // 2. Add Polylines for Sample Bus Routes
    busLocationTracker.sampleRoutes.forEach((String routeName, List<LatLng> points) {
      mapPolylines.add(
        Polyline(
          points: points,
          color: _lightBlue.withOpacity(0.5), // Semi-transparent blue for bus routes
          strokeWidth: 3.0,
        ),
      );
    });

    // 3. Add User's Trip Polyline (a simple line between start and end)
    mapPolylines.add(
      Polyline(
        points: <LatLng>[widget.startPoint, widget.endPoint],
        color: _darkBlue, // Solid dark blue for user's planned route
        strokeWidth: 5.0,
      ),
    );

    // 4. Add Live Bus Markers
    for (final LiveBus bus in busLocationTracker.buses) {
      mapMarkers.add(
        Marker(
          width: 60.0, // Smaller marker for buses
          height: 60.0,
          point: bus.currentPosition,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.directions_bus, size: 30, color: Colors.blue[700]), // Darker blue bus icon
              Text(
                '#${bus.routeNumber}',
                style: GoogleFonts.raleway(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blue[900]),
              ),
            ],
          ),
        ),
      );
    }

    // Determine initial center and zoom to fit all relevant points
    LatLng center;
    double zoom;

    // Collect all points to calculate the bounding box
    final List<LatLng> allPointsForBounds = <LatLng>[
      widget.startPoint,
      widget.endPoint,
      ...busLocationTracker.sampleRoutes.values.expand<LatLng>((List<LatLng> points) => points),
      ...busLocationTracker.buses.map<LatLng>((LiveBus bus) => bus.currentPosition),
    ].where((LatLng latLng) => latLng.latitude != 0.0 || latLng.longitude != 0.0).toList(); // Filter out default (0,0) if any

    if (allPointsForBounds.isNotEmpty) {
      double minLat = allPointsForBounds[0].latitude;
      double maxLat = allPointsForBounds[0].latitude;
      double minLon = allPointsForBounds[0].longitude;
      double maxLon = allPointsForBounds[0].longitude;

      for (final LatLng point in allPointsForBounds) {
        if (point.latitude < minLat) minLat = point.latitude;
        if (point.latitude > maxLat) maxLat = point.latitude;
        if (point.longitude < minLon) minLon = point.longitude;
        if (point.longitude > maxLon) maxLon = point.longitude;
      }

      center = LatLng((minLat + maxLat) / 2, (minLon + maxLon) / 2);
      // Simple heuristic for zoom level based on bounding box size
      // This is very basic and might need fine-tuning based on actual map area.
      // A typical map zoom formula based on degrees: zoom = log2(360 / max_delta_degree)
      final double latDelta = maxLat - minLat;
      final double lonDelta = maxLon - minLon;
      final double maxDelta = (latDelta > lonDelta ? latDelta : lonDelta);

      if (maxDelta > 0) {
        zoom = 13.0 - (maxDelta * 50); // Adjust multiplier for desired effect
      } else {
        zoom = 13.0; // Default zoom if all points are the same
      }

      // Clamp zoom to reasonable values for Kathmandu
      if (zoom < 10.0) zoom = 10.0; // Don't zoom out too far
      if (zoom > 15.0) zoom = 15.0; // Don't zoom in too much initially
    } else {
      center = const LatLng(27.7172, 85.3240); // Default Kathmandu if no points
      zoom = 13.0;
    }


    return Scaffold(
      backgroundColor: _white,
      appBar: _CustomAppBar(
        title: languageProvider.getString('map_directions_title'),
        titleIcon: Icons.map, // Map icon for the title
        leadingIcon: Icons.arrow_back, // Standard back button
        onLeadingPressed: () => Navigator.of(context).pop(), // Pop to go back
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 300, // Increased map height for better visibility
                width: double.infinity,
                child: FlutterMap(
                  mapController: _mapController, // Assign controller
                  options: MapOptions(
                    initialCenter: center,
                    initialZoom: zoom,
                    minZoom: 8.0,
                    maxZoom: 18.0,
                    interactionOptions: const InteractionOptions(flags: InteractiveFlag.all), // Fixed interactiveFlags parameter
                  ),
                  children: <Widget>[
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.transport_app', // Unique package name
                    ),
                    PolylineLayer(
                      polylines: mapPolylines,
                    ),
                    MarkerLayer(
                      markers: mapMarkers,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '${languageProvider.getString('from_label')} ${widget.fromLocation}',
              style: GoogleFonts.raleway(fontSize: 16, color: _darkBlue, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '${languageProvider.getString('to_label')} ${widget.toLocation}',
              style: GoogleFonts.raleway(fontSize: 16, color: _darkBlue, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Text(
              // Using a placeholder for estimated time, as actual routing is complex
              '${languageProvider.getString('estimated_time_label')} 30 min (approx.)',
              style: GoogleFonts.raleway(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
// End of new Map Page

class _HomeContentPage extends StatefulWidget {
  // Converted to StatefulWidget to manage map visibility and text controllers
  _HomeContentPage({super.key});

  @override
  State<_HomeContentPage> createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<_HomeContentPage> {
  late final TextEditingController _fromLocationController;
  late final TextEditingController _toLocationController;
  final List<String> _allPlaces = _getCombinedSearchablePlaces();

  @override
  void initState() {
    super.initState();
    _fromLocationController = TextEditingController();
    _toLocationController = TextEditingController();
  }

  @override
  void dispose() {
    _fromLocationController.dispose();
    _toLocationController.dispose();
    super.dispose();
  }

  void _onSuggestRoute() {
    // Navigate to new MapPage instead of showing it inline
    Navigator.of(context).push<void>(
      _buildPageRouteWithSlideTransition(
        MapPage(
          startPoint: const LatLng(27.7172, 85.3240), // Default Kathmandu for start
          endPoint: const LatLng(27.7050, 85.3350), // Default Patan for end
          fromLocation: _fromLocationController.text.isEmpty
              ? 'Ratnapark, Kathmandu' // Default if empty
              : _fromLocationController.text,
          toLocation: _toLocationController.text.isEmpty
              ? 'New Road, Kathmandu' // Default if empty
              : _toLocationController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20),
          _SearchInput(options: _allPlaces),
          const SizedBox(height: 15),
          const _CurrentLocationDisplay(),
          const SizedBox(height: 20),
          const _LiveBusesCard(),
          const SizedBox(height: 20),
          _PlanTripCard(
            fromController: _fromLocationController,
            toController: _toLocationController,
            onSuggestRoute: _onSuggestRoute,
            autocompleteOptions: _allPlaces, // Pass options to PlanTripCard
          ),
          // _MapDisplay removed from here as it's now a separate page
          const SizedBox(height: 20), // Bottom padding
        ],
      ),
    );
  }
}

class _SearchInput extends StatelessWidget {
  final List<String> options;

  const _SearchInput({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = context.watch<LanguageProvider>();
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        }
        return options.where((String option) {
          return option.toLowerCase().contains(
            textEditingValue.text.toLowerCase(),
          );
        });
      },
      fieldViewBuilder:
          (
          BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted,
          ) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _lightBlue,
              width: 1,
            ), // Subtle light blue border
          ),
          child: Row(
            children: <Widget>[
              const Icon(Icons.search, color: _lightBlue), // Search icon
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  onSubmitted: (String value) {
                    onFieldSubmitted(); // Trigger Autocomplete's onFieldSubmitted
                    // Optionally, perform a search action here using 'value'
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Searching for: $value')),
                    );
                  },
                  decoration: InputDecoration(
                    hintText: languageProvider.getString(
                      'search_hint',
                    ), // Localized hint
                    hintStyle: GoogleFonts.raleway(color: Colors.grey[400]),
                    border:
                    InputBorder.none, // Remove default TextField border
                    contentPadding:
                    EdgeInsets.zero, // Remove default padding
                    isDense: true, // Make it compact
                  ),
                  style: GoogleFonts.raleway(color: _darkBlue),
                ),
              ),
            ],
          ),
        );
      },
      optionsViewBuilder:
          (
          BuildContext context,
          AutocompleteOnSelected<String> onSelected,
          Iterable<String> options,
          ) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 200.0, // Limit height of dropdown
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final String option = options.elementAt(index);
                  return ListTile(
                    title: Text(
                      option,
                      style: GoogleFonts.raleway(color: _darkBlue),
                    ),
                    onTap: () {
                      onSelected(option);
                    },
                  );
                },
              ),
            ),
          ),
        );
      }, // This comma was missing, causing the "Expected an identifier" error.
      onSelected: (String selection) {
        // This callback is fired when an option is selected.
        // ignore: avoid_print
        print('Selected search destination: $selection');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Selected: $selection')));
      },
    );
  }
}

class _CurrentLocationDisplay extends StatelessWidget {
  const _CurrentLocationDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = context.watch<LanguageProvider>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: _white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _lightGrey, width: 1), // Subtle grey border
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.location_on, color: Colors.grey),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              // Combine localized label with fixed location string
              '${languageProvider.getString('current_location_label')}: Ratnapark,Kathmandu',
              style: GoogleFonts.raleway(
                color: _darkBlue,
                fontSize: 14,
              ), // Based on image
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundedCardContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const _RoundedCardContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _lightGrey,
        borderRadius: BorderRadius.circular(
          20,
        ), // More rounded corners for cards
      ),
      padding: padding,
      child: child,
    );
  }
}

class _LiveBusesCard extends StatelessWidget {
  const _LiveBusesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = context.watch<LanguageProvider>();
    return _RoundedCardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.bus_alert, color: _darkBlue), // Bus icon
              const SizedBox(width: 8),
              Text(
                languageProvider.getString(
                  'live_nearby_buses_title',
                ), // Localized text
                style: GoogleFonts.raleway(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _darkBlue,
                ),
              ),
            ],
          ),
          const Divider(color: Colors.grey, height: 20), // Separator
          Column(
            children: _liveBuses
                .map<Widget>((BusRoute bus) => _BusEntryRow(bus: bus))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _BusEntryRow extends StatelessWidget {
  final BusRoute bus;

  const _BusEntryRow({super.key, required this.bus});

  IconData _getStatusIcon(BusStatus status) {
    switch (status) {
      case BusStatus.notCrowded:
        return Icons.check_circle;
      case BusStatus.crowded:
        return Icons.cancel;
      case BusStatus.almostCrowded:
        return Icons.warning_rounded;
    }
  }

  Color _getStatusColor(BusStatus status) {
    switch (status) {
      case BusStatus.notCrowded:
        return Colors.green[700]!;
      case BusStatus.crowded:
        return Colors.red[700]!;
      case BusStatus.almostCrowded:
        return Colors.orange[700]!;
    }
  }

  String _getStatusText(BusStatus status, LanguageProvider languageProvider) {
    switch (status) {
      case BusStatus.notCrowded:
        return languageProvider.getString('bus_status_not_crowded');
      case BusStatus.crowded:
        return languageProvider.getString('bus_status_crowded');
      case BusStatus.almostCrowded:
        return languageProvider.getString('bus_status_almost_crowded');
    }
  }

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = context.watch<LanguageProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 30, // Fixed width for bus number column
            child: Text(
              '#${bus.number}',
              style: GoogleFonts.raleway(
                fontWeight: FontWeight.bold,
                color: _darkBlue,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  languageProvider.getString(bus.routeKey), // Localized route
                  style: GoogleFonts.raleway(color: _darkBlue, fontSize: 14),
                ),
                Text(
                  languageProvider.getString(
                    bus.timeAwayKey,
                  ), // Localized time away
                  style: GoogleFonts.raleway(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          Icon(
            _getStatusIcon(bus.status),
            color: _getStatusColor(bus.status),
            size: 18,
          ),
          const SizedBox(width: 5),
          Text(
            _getStatusText(
              bus.status,
              languageProvider,
            ), // Localized status text
            style: GoogleFonts.raleway(
              color: _getStatusColor(bus.status),
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            languageProvider.getString(
              bus.minutesAgoKey,
            ), // Localized minutes ago
            style: GoogleFonts.raleway(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _PlanTripCard extends StatelessWidget {
  final TextEditingController fromController;
  final TextEditingController toController;
  final VoidCallback onSuggestRoute;
  final List<String> autocompleteOptions;

  const _PlanTripCard({
    super.key,
    required this.fromController,
    required this.toController,
    required this.onSuggestRoute,
    required this.autocompleteOptions,
  });

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = context.watch<LanguageProvider>();
    return _RoundedCardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.location_on, color: _darkBlue), // Location icon
              const SizedBox(width: 8),
              Text(
                languageProvider.getString(
                  'plan_your_trip_title',
                ), // Localized text
                style: GoogleFonts.raleway(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _darkBlue,
                ),
              ),
            ],
          ),
          const Divider(color: Colors.grey, height: 20), // Separator
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _AutocompleteInputField(
                      labelKey: 'from_label',
                      icon: Icons.location_on,
                      controller: fromController,
                      hintKey: 'enter_location_hint',
                      options: autocompleteOptions,
                    ), // Pass options
                    const SizedBox(height: 10),
                    _AutocompleteInputField(
                      labelKey: 'to_label',
                      icon: Icons.person_outline,
                      controller: toController,
                      hintKey: 'enter_location_hint',
                      options: autocompleteOptions,
                    ), // Pass options
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      languageProvider.getString(
                        'estimated_time_label',
                      ), // Localized text
                      style: GoogleFonts.raleway(
                        fontSize: 12,
                        color: _darkBlue,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 80, // Approximate height to match image
                      decoration: BoxDecoration(
                        color: Colors.grey[300], // Grey box
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '#AD', // Placeholder from image
                        style: GoogleFonts.raleway(
                          color: _darkBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft, // Image shows it aligned left
            child: ElevatedButton.icon(
              onPressed: onSuggestRoute, // Call the provided callback
              icon: const Icon(Icons.send, color: _white),
              label: Text(
                languageProvider.getString(
                  'suggest_smart_route_button',
                ), // Localized text
                style: GoogleFonts.raleway(color: _white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _darkBlue, // Button background
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AutocompleteInputField extends StatelessWidget {
  final String labelKey;
  final IconData icon;
  final TextEditingController controller;
  final String hintKey;
  final List<String> options;

  const _AutocompleteInputField({
    super.key,
    required this.labelKey,
    required this.icon,
    required this.controller,
    required this.hintKey,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = context.watch<LanguageProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          languageProvider.getString(labelKey), // Localized label
          style: GoogleFonts.raleway(fontSize: 12, color: _darkBlue),
        ),
        const SizedBox(height: 5),
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            }
            return options.where((String option) {
              return option.toLowerCase().contains(
                textEditingValue.text.toLowerCase(),
              );
            });
          },
          fieldViewBuilder:
              (
              BuildContext context,
              TextEditingController textEditingController,
              FocusNode focusNode,
              VoidCallback onFieldSubmitted,
              ) {
            // Ensure the external controller reflects the internal Autocomplete controller's text
            controller.text = textEditingController.text;

            return TextField(
              controller: textEditingController,
              focusNode: focusNode,
              onSubmitted: (String value) {
                onFieldSubmitted();
                controller.text =
                    value; // Update external controller on submit
              },
              onChanged: (String value) {
                controller.text =
                    value; // Update external controller on change
              },
              style: GoogleFonts.raleway(color: _darkBlue),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                hintText: languageProvider.getString(
                  hintKey,
                ), // Localized hint
                hintStyle: GoogleFonts.raleway(
                  color: Colors.grey[400],
                  fontSize: 12,
                ),
                prefixIcon: Icon(icon, color: Colors.grey[600], size: 18),
                filled: true,
                fillColor: _white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            );
          },
          optionsViewBuilder:
              (
              BuildContext context,
              AutocompleteOnSelected<String> onSelected,
              Iterable<String> options,
              ) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4.0,
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: 200.0,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final String option = options.elementAt(index);
                      return ListTile(
                        title: Text(
                          option,
                          style: GoogleFonts.raleway(color: _darkBlue),
                        ),
                        onTap: () {
                          onSelected(option);
                          controller.text =
                              option; // Manually update controller on selection
                        },
                      );
                    },
                  ),
                ),
              ),
            );
          },
          onSelected: (String selection) {
            controller.text = selection;
          },
        ),
      ],
    );
  }
}

class _HomeBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const _HomeBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = context.watch<LanguageProvider>();
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: selectedIndex == 0 ? _darkBlue : Colors.grey,
          ),
          label: languageProvider.getString('home_tab'), // Localized label
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.language,
            color: selectedIndex == 1 ? _darkBlue : Colors.grey,
          ), // Replaced image with Icons.language
          label: languageProvider.getString(
            'toggle_language_label',
          ), // Dynamically localized label
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.lightbulb_outline,
            color: selectedIndex == 2 ? _darkBlue : Colors.grey,
          ), // Tip icon
          label: languageProvider.getString('tip_tab'), // Localized label
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.public,
            color: selectedIndex == 3 ? _darkBlue : Colors.grey,
          ), // SOS globe icon
          label: languageProvider.getString('sos_tab'), // Localized label
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: _darkBlue,
      unselectedItemColor: Colors.grey,
      onTap: onItemTapped,
      type: BottomNavigationBarType.fixed, // To show all labels
      backgroundColor: _white,
      selectedLabelStyle: GoogleFonts.raleway(fontWeight: FontWeight.bold),
      unselectedLabelStyle: GoogleFonts.raleway(fontWeight: FontWeight.normal),
    );
  }
}

// Start of Tip Page implementation
class _TipPageWaveClipper extends CustomClipper<ui.Path> {
  @override
  ui.Path getClip(Size size) {
    final ui.Path path = ui.Path();
    path.lineTo(0, size.height * 0.7); // Start at a point on the left edge
    final double controlPoint1X = size.width * 0.25;
    final double controlPoint1Y = size.height * 0.85;
    final double endPoint1X = size.width * 0.5;
    final double endPoint1Y = size.height * 0.7;

    path.quadraticBezierTo(
      controlPoint1X,
      controlPoint1Y,
      endPoint1X,
      endPoint1Y,
    );

    final double controlPoint2X = size.width * 0.75;
    final double controlPoint2Y = size.height * 0.55;
    final double endPoint2X_adjusted = size.width;
    final double endPoint2Y =
        size.height * 0.65; // Slightly higher than starting point

    path.quadraticBezierTo(
      controlPoint2X,
      controlPoint2Y,
      endPoint2X_adjusted,
      endPoint2Y,
    );

    path.lineTo(size.width, 0); // Line to top right
    path.lineTo(0, 0); // Line to top left
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<ui.Path> oldClipper) => false;
}

class _UserInfoSection extends StatelessWidget {
  const _UserInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = context.watch<LanguageProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40.0,
      ), // Consistent with auth pages
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  languageProvider.getString('username_label'),
                  style: GoogleFonts.raleway(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: _white,
                  ),
                ),
                Text(
                  '${languageProvider.getString('points_label')}9999',
                  style: GoogleFonts.raleway(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: _white,
                  ),
                ),
              ],
            ),
          ),
          const CircleAvatar(
            radius: 40, // PFP circle size
            backgroundColor: _lightGrey,
            child: Text(
              'pfp',
              style: TextStyle(color: _darkBlue, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class _PublicRideNumberInput extends StatelessWidget {
  final TextEditingController controller;
  const _PublicRideNumberInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = context.watch<LanguageProvider>();
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: GoogleFonts.raleway(color: _darkBlue),
      decoration: InputDecoration(
        hintText: languageProvider.getString('public_ride_number_hint'),
        hintStyle: GoogleFonts.raleway(color: Colors.grey[400]),
        filled: true,
        fillColor: _white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15), // Rounded corners for input
          borderSide: const BorderSide(color: _lightGrey, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: _lightGrey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: _lightBlue,
            width: 2,
          ), // Blue border on focus
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),
      ),
    );
  }
}

class _IsYourRideText extends StatelessWidget {
  const _IsYourRideText({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = context.watch<LanguageProvider>();
    return Text(
      languageProvider.getString('is_your_ride_label'),
      style: GoogleFonts.raleway(fontSize: 16, color: _darkBlue),
    );
  }
}

class _CrowdStatusButton extends StatelessWidget {
  final BusStatus status;
  final BusStatus? selectedStatus;
  final ValueChanged<BusStatus> onPressed;

  const _CrowdStatusButton({
    super.key,
    required this.status,
    this.selectedStatus,
    required this.onPressed,
  });

  IconData _getIcon(BusStatus status) {
    switch (status) {
      case BusStatus.notCrowded:
        return Icons.check_circle_outline;
      case BusStatus.crowded:
        return Icons.cancel_outlined;
      case BusStatus.almostCrowded:
        return Icons.warning_amber_outlined;
    }
  }

  Color _getColor(BusStatus status) {
    switch (status) {
      case BusStatus.notCrowded:
        return Colors.green[700]!;
      case BusStatus.crowded:
        return Colors.red[700]!;
      case BusStatus.almostCrowded:
        return Colors.orange[700]!;
    }
  }

  String _getTextKey(BusStatus status) {
    switch (status) {
      case BusStatus.notCrowded:
        return 'not_crowded_tip_button';
      case BusStatus.crowded:
        return 'crowded_tip_button';
      case BusStatus.almostCrowded:
        return 'almost_full_tip_button'; // Mapped to almost_full_tip_button
    }
  }

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = context.watch<LanguageProvider>();
    final bool isSelected = status == selectedStatus;
    final Color color = _getColor(status);

    return Expanded(
      child: GestureDetector(
        onTap: () => onPressed(status),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? color.withOpacity(0.1)
                : _white, // Light fill when selected
            borderRadius: BorderRadius.circular(15), // More rounded corners
            border: Border.all(
              color: isSelected
                  ? color
                  : _lightGrey, // Thicker border when selected
              width: isSelected ? 2.0 : 1.0,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(_getIcon(status), color: color, size: 24),
              const SizedBox(height: 4),
              Text(
                languageProvider.getString(_getTextKey(status)),
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                  color: color,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CrowdStatusButtons extends StatelessWidget {
  final BusStatus? selectedStatus;
  final ValueChanged<BusStatus> onStatusSelected;

  const _CrowdStatusButtons({
    super.key,
    required this.selectedStatus,
    required this.onStatusSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _CrowdStatusButton(
          status: BusStatus.notCrowded,
          selectedStatus: selectedStatus,
          onPressed: onStatusSelected,
        ),
        const SizedBox(width: 10),
        _CrowdStatusButton(
          status: BusStatus.almostCrowded,
          selectedStatus: selectedStatus,
          onPressed: onStatusSelected,
        ),
        const SizedBox(width: 10),
        _CrowdStatusButton(
          status: BusStatus.crowded,
          selectedStatus: selectedStatus,
          onPressed: onStatusSelected,
        ),
      ],
    );
  }
}

class _SubmitTipButton extends StatelessWidget {
  final VoidCallback onSubmit;

  const _SubmitTipButton({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = context.watch<LanguageProvider>();
    return ElevatedButton(
      onPressed: onSubmit,
      style: ElevatedButton.styleFrom(
        backgroundColor: _darkBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      ),
      child: Text(
        languageProvider.getString('submit_tip_button'),
        style: GoogleFonts.raleway(color: _white, fontSize: 16),
      ),
    );
  }
}

class _TipContentPage extends StatefulWidget {
  _TipContentPage({super.key});

  @override
  State<_TipContentPage> createState() => _TipContentPageState();
}

class _TipContentPageState extends State<_TipContentPage> {
  BusStatus? _selectedBusStatus;
  late final TextEditingController _publicRideNumberController;

  @override
  void initState() {
    super.initState();
    _publicRideNumberController = TextEditingController();
  }

  @override
  void dispose() {
    _publicRideNumberController.dispose();
    super.dispose();
  }

  void _onCrowdStatusSelected(BusStatus status) {
    setState(() {
      _selectedBusStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final LanguageProvider languageProvider = context.watch<LanguageProvider>();

    return Stack(
      children: <Widget>[
        // Blue wave background (fixed position)
        Align(
          alignment: Alignment.topCenter,
          child: ClipPath(
            clipper: _TipPageWaveClipper(),
            child: Container(
              height:
              screenSize.height *
                  0.5, // Make blue area cover more for text/pfp
              color: _lightBlue,
            ),
          ),
        ),
        // Decorative circles (fixed positions relative to screen)
        Positioned(
          top: screenSize.height * 0.28,
          right: screenSize.width * 0.15,
          child: Container(
            width: screenSize.width * 0.1,
            height: screenSize.width * 0.1,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _darkBlue.withOpacity(0.2),
            ),
          ),
        ),
        Positioned(
          top: screenSize.height * 0.35,
          left: screenSize.width * 0.2,
          child: Container(
            width: screenSize.width * 0.2,
            height: screenSize.width * 0.2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _darkBlue.withOpacity(0.2),
            ),
          ),
        ),
        // Main scrollable content
        Positioned.fill(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: screenSize.height * 0.08,
                  ), // Space below custom app bar
                  const _UserInfoSection(),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _PublicRideNumberInput(
                          controller: _publicRideNumberController,
                        ),
                        const SizedBox(height: 20),
                        const _IsYourRideText(),
                        const SizedBox(height: 10),
                        _CrowdStatusButtons(
                          selectedStatus: _selectedBusStatus,
                          onStatusSelected: _onCrowdStatusSelected,
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: _SubmitTipButton(
                            onSubmit: () {
                              // Handle submit logic
                              // ignore: avoid_print
                              print(
                                'Public Ride Number: ${_publicRideNumberController.text}',
                              );
                              // ignore: avoid_print
                              print('Selected Status: $_selectedBusStatus');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    languageProvider.getString(
                                      'submit_tip_button',
                                    ) +
                                        ' pressed!',
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ), // Bottom padding for scroll view
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Start of SOS Page implementation
class _HexagonClipper extends CustomClipper<ui.Path> {
  @override
  ui.Path getClip(Size size) {
    final ui.Path path = ui.Path();
    final double width = size.width;
    final double height = size.height;

    path.moveTo(width / 2, 0); // Top middle
    path.lineTo(width, height / 4); // Top right
    path.lineTo(width, height * 3 / 4); // Bottom right
    path.lineTo(width / 2, height); // Bottom middle
    path.lineTo(0, height * 3 / 4); // Bottom left
    path.lineTo(0, height / 4); // Top left
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<ui.Path> oldClipper) => false;
}

class _SOSActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String labelKey;
  final VoidCallback onPressed;

  const _SOSActionButton({
    super.key,
    required this.icon,
    required this.color,
    required this.labelKey,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = context.watch<LanguageProvider>();
    return Expanded(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: onPressed,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle, // Use circle for the background
              ),
              child: Icon(icon, color: _white, size: 30),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            languageProvider.getString(labelKey),
            style: GoogleFonts.raleway(color: _darkBlue, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _SOSContentPage extends StatelessWidget {
  const _SOSContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = context.watch<LanguageProvider>();
    final Size screenSize = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Spacer(),
        Center(
          child: SizedBox(
            width: screenSize.width * 0.4, // Control the size of the hexagon
            height: screenSize.width * 0.4,
            child: ClipPath(
              clipper: _HexagonClipper(),
              child: Container(
                color: _lightRed, // Light red background for hexagon
                child: const Center(
                  child: Icon(
                    Icons.warning_rounded, // Exclamation mark
                    color: _white, // White exclamation mark
                    size: 80, // Adjust size to fit hexagon
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          languageProvider.getString('sos_tab'), // "SOS" text
          style: GoogleFonts.raleway(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600], // Grey color for "SOS"
          ),
        ),
        const Spacer(flex: 2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _SOSActionButton(
                icon: Icons.local_hospital, // Medical cross
                color: Colors.red[700]!, // Red
                labelKey: 'call_medical',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${languageProvider.getString('call_medical')} button pressed!',
                      ),
                    ),
                  );
                },
              ),
              _SOSActionButton(
                icon: Icons.local_fire_department, // Fire flame
                color: Colors.orange[700]!, // Orange
                labelKey: 'call_fire',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${languageProvider.getString('call_fire')} button pressed!',
                      ),
                    ),
                  );
                },
              ),
              _SOSActionButton(
                icon: Icons.local_police, // Police shield with star
                color: _darkBlue, // Dark blue
                labelKey: 'call_police',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${languageProvider.getString('call_police')} button pressed!',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const Spacer(flex: 3), // Push content up slightly
      ],
    );
  }
}

/// A custom drawer for the app's navigation menu.
class _AppDrawer extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onProfileTap;
  final VoidCallback onSettingsTap;
  final VoidCallback onLogoutTap;

  const _AppDrawer({
    super.key,
    required this.onHomeTap,
    required this.onProfileTap,
    required this.onSettingsTap,
    required this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = context.watch<LanguageProvider>();
    final AuthProvider authProvider = context.watch<AuthProvider>();

    final String displayEmail = authProvider.currentUserEmail ?? 'Guest';
    final String welcomeText = authProvider.currentUserEmail == null
        ? languageProvider.getString(
      'profile_menu',
    ) // "Profile" if not logged in
        : '${languageProvider.getString('logged_in_as')} $displayEmail'; // "Logged in as: email"

    return Drawer(
      backgroundColor: _white, // Drawer background
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: _darkBlue, // Header background
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: _lightBlue,
                  child: Icon(Icons.person, color: _white, size: 30),
                ),
                const SizedBox(height: 8),
                Text(
                  welcomeText, // Display "Logged in as: email" or "Profile"
                  style: GoogleFonts.raleway(
                    color: _white,
                    fontSize: 16, // Adjusted font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (authProvider.currentUserEmail !=
                    null) // Only show email explicitly if logged in
                  Text(
                    displayEmail, // Display the email
                    style: GoogleFonts.raleway(
                      color: _white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: _darkBlue),
            title: Text(
              languageProvider.getString('home_tab'),
              style: GoogleFonts.raleway(color: _darkBlue),
            ),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              onHomeTap();
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: _darkBlue),
            title: Text(
              languageProvider.getString('profile_menu'),
              style: GoogleFonts.raleway(color: _darkBlue),
            ),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              onProfileTap();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    languageProvider.getString('profile_menu') + ' tapped!',
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: _darkBlue),
            title: Text(
              languageProvider.getString('settings_menu'),
              style: GoogleFonts.raleway(color: _darkBlue),
            ),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              onSettingsTap();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    languageProvider.getString('settings_menu') + ' tapped!',
                  ),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: Text(
              languageProvider.getString('logout_menu'),
              style: GoogleFonts.raleway(color: Colors.red),
            ),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              onLogoutTap();
            },
          ),
        ],
      ),
    );
  }
}
