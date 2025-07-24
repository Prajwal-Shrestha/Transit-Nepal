import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:ui' as ui; // Import dart:ui for Path
import 'package:google_fonts/google_fonts.dart'; // Allowed package for Google Fonts

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
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) =>
    page,
    transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      const Offset begin = Offset(1.0, 0.0); // Start from right
      const Offset end = Offset.zero; // End at original position
      const Curve curve = Curves.easeOutCubic; // A smooth curve for the animation

      final Animatable<Offset> tween =
      Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

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
    'name_hint': 'Name',
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
    'app_bar_greeting': 'Happy Teej!',
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
    'नेपाली भाषा', // When in English, option to switch to Nepali language
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
    'call_police': 'Police',

    // New keys for Drawer menu
    'profile_menu': 'Profile',
    'settings_menu': 'Settings',
    'logout_menu': 'Logout',

    // New key for Map display
    'map_directions_title': 'Route Directions',
  };

  static final Map<String, String> _nepaliStrings = {
    'create_account_title': 'खाता\nखोल्नुहोस्',
    'name_hint': 'नाम',
    'phone_number_hint': 'फोन नम्बर',
    'password_hint': 'पासवर्ड पुष्टि गर्नुहोस्',
    'confirm_password_hint': 'पासवर्ड पुष्टि गर्नुहोस्',
    'signup_button': 'साइन अप',
    'already_have_account_question': 'पहिले नै खाता छ?',
    'welcome_back_title': 'फेरि स्वागत छ',
    'email_hint': 'इमेल',
    'forgot_password_question': 'पासवर्ड बिर्सनुभयो?',
    'login_button': 'लगइन',
    'create_account_button': 'खाता खोल्नुहोस्',
    'app_bar_greeting': 'शुभ तिज!',
    'search_hint': 'गन्तव्य वा मार्ग खोज्नुहोस्',
    'current_location_label': 'हालको स्थान',
    'live_nearby_buses_title': 'नजिकका प्रत्यक्ष बसहरू',
    'plan_your_trip_title': 'आफ्नो यात्रा योजना बनाउनुहोस्',
    'from_label': 'बाट:',
    'to_label': 'सम्म:',
    'estimated_time_label': 'अनुमानित समय:',
    'suggest_smart_route_button': 'स्मार्ट मार्ग सुझाव दिनुहोस्',
    'enter_location_hint': 'स्थान प्रविष्ट गर्नुहोस्',
    'home_tab': 'गृहपृष्ठ',
    'toggle_language_label':
    'English Language', // When in Nepali, option to switch to English language
    'tip_tab': 'टिप',
    'sos_tab': 'एसओएस', // Original short label for tab
    'bus_status_not_crowded': 'भीड छैन',
    'bus_status_crowded': 'भीडभाड',
    'bus_status_almost_crowded': 'लगभग भीडभाड',

    // Updated Nepali translations for bus routes as per request
    'bus_route_33': 'कलङ्की-बानेश्वर',
    'bus_time_away_33': '७ मिनेटमा आइपुग्छ',
    'bus_minutes_ago_2': '२ मिनेट अगाडि', // Consistent Nepali for 2/3 min ago

    'bus_route_57': 'जोरपाटी-रत्नपार्क',
    'bus_time_away_57': '१५ मिनेटमा आइपुग्छ',

    'bus_route_28': 'कलङ्की-बानेश्वर', // This was previously 'Airport-Sahid Gate'
    'bus_time_away_28': '२७ मिनेटमा आइपुग्छ',
    'bus_minutes_ago_3': '२ मिनेट अगाडि', // Consistent Nepali for 2/3 min ago

    'bus_route_92': 'बालाजु-जमल',
    'bus_time_away_92': '४५ मिनेटमा आइपुग्छ',

    // New Nepali translations for Tip Page
    'tip_earn_title': 'जानकारी दिनुहोस् र जित्नुहोस्',
    'username_label': 'प्रयोगकर्ता नाम',
    'points_label': 'अंक: ',
    'public_ride_number_hint': 'सार्वजनिक सवारी नम्बर',
    'is_your_ride_label': 'तपाईंको सवारी हो',
    'not_crowded_tip_button': 'अहिले खाली छ',
    'almost_full_tip_button': 'लगभग भीड',
    'crowded_tip_button': 'पूर्ण भीड',
    'submit_tip_button': 'जानकारी दिनुहोस्',

    // New Nepali translation for SOS Page AppBar title
    'emergency_sos_title': 'आपतकालिन र एसओएस',
    'call_medical': 'चिकित्सकलाई_कल',
    'call_fire': 'दमकललाई_कल',
    'call_police': 'पुलिसलाई_कल',

    // New keys for Drawer menu
    'profile_menu': 'प्रोफाइल',
    'settings_menu': 'सेटिङ्स',
    'logout_menu': 'लगआउट',

    // New key for Map display
    'map_directions_title': 'मार्ग निर्देशन',
  };
}

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LanguageProvider>(
      create: (BuildContext context) => LanguageProvider(),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: 'Authentication UI', // Renamed title
          debugShowCheckedModeBanner: false,
          initialRoute: '/signup',
          routes: <String, WidgetBuilder>{
            '/signup': (BuildContext context) => SignupPage(),
            '/login': (BuildContext context) => LoginPage(),
            '/home': (BuildContext context) => HomePage(), // New route for Home page
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
        style: GoogleFonts.raleway(color: _darkBlue), // Input text color changed to dark blue
        decoration: InputDecoration(
          hintText: languageProvider.getString(hintKey), // Localized hint
          hintStyle: GoogleFonts.raleway(color: Colors.grey[400]), // Hint text color changed to lighter grey
          filled: true,
          fillColor: _white, // Consistent with new palette
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: _lightBlue, width: 1), // Light blue border
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: _lightBlue, width: 1), // Light blue border when enabled
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: _lightBlue, width: 2), // Light blue border when focused
          ),
          contentPadding:
          const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
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
                  shape: BoxShape.circle, color: _lightBlue.withOpacity(0.5)),
            ),
          ),
          Positioned(
            top: screenSize.height * 0.13,
            left: screenSize.width * 0.57,
            child: Container(
              width: screenSize.width * 0.1,
              height: screenSize.width * 0.1,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: _lightGrey.withOpacity(0.5)),
            ),
          ),
          Positioned(
            top: screenSize.height * 0.17,
            left: screenSize.width * 0.72,
            child: Container(
              width: screenSize.width * 0.08,
              height: screenSize.width * 0.08,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: _lightBlue.withOpacity(0.5)),
            ),
          ),
          Positioned(
            top: screenSize.height * 0.09,
            left: screenSize.width * 0.5,
            child: Container(
              width: screenSize.width * 0.05,
              height: screenSize.width * 0.05,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: _lightGrey.withOpacity(0.5)),
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
                  shape: BoxShape.circle, color: _lightBlue.withOpacity(0.5)),
            ),
          ),
          Positioned(
            top: screenSize.height * 0.13,
            right: screenSize.width * 0.2,
            child: Container(
              width: screenSize.width * 0.1,
              height: screenSize.width * 0.1,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: _lightGrey.withOpacity(0.5)),
            ),
          ),
          Positioned(
            top: screenSize.height * 0.17,
            right: screenSize.width * 0.1,
            child: Container(
              width: screenSize.width * 0.08,
              height: screenSize.width * 0.08,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: _lightBlue.withOpacity(0.5)),
            ),
          ),
          Positioned(
            top: screenSize.height * 0.09,
            right: screenSize.width * 0.28,
            child: Container(
              width: screenSize.width * 0.05,
              height: screenSize.width * 0.05,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: _lightGrey.withOpacity(0.5)),
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
                shape: BoxShape.circle, color: _lightBlue.withOpacity(0.5)),
          ),
        ),
        Positioned(
          bottom: screenSize.height * 0.03,
          left: screenSize.width * 0.13,
          child: Container(
            width: screenSize.width * 0.13,
            height: screenSize.width * 0.13,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: _lightGrey.withOpacity(0.5)),
          ),
        ),
        Positioned(
          bottom: screenSize.height * 0.09,
          left: screenSize.width * 0.05,
          child: Container(
            width: screenSize.width * 0.08,
            height: screenSize.width * 0.08,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: _lightBlue.withOpacity(0.5)),
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
                color: _lightGrey.withOpacity(0.5)), // Fix: Changed BoxBoxShape to BoxShape
          ),
        ),
      ],
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
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 60), // Space for "Create Account" text
                  Text(
                    languageProvider.getString('create_account_title'), // Localized text
                    style: GoogleFonts.raleway(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: _white, // Text color consistent with new palette
                    ),
                  ),
                  const Spacer(flex: 2), // Pushes text fields down
                  _AuthInputField(
                    hintKey: 'name_hint', // Use hintKey
                    controller: _nameController,
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
                  const Spacer(), // Pushes "Sign Up" row down
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        languageProvider.getString('signup_button'), // Localized text
                        style: GoogleFonts.raleway(
                            fontSize: 16, color: _darkBlue), // Text color changed to dark blue
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          // Navigate to HomePage after signup
                          Navigator.of(context).pushAndRemoveUntil<void>(
                              _buildPageRouteWithSlideTransition(HomePage()),
                                  (Route<dynamic> route) => false);
                        },
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundColor: _darkBlue, // Changed to _darkBlue
                          child: Icon(Icons.arrow_forward, color: _white),
                        ),
                      )
                    ],
                  ),
                  const Spacer(
                      flex: 3), // Pushes "Already have an account?" button down
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pushReplacement<void, void>(
                          _buildPageRouteWithSlideTransition(LoginPage())),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: const BoxDecoration(
                          color: _darkBlue, // Changed to _darkBlue
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(0), // Removed topRight curve
                            topLeft: Radius.circular(40), // Added topLeft curve
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                          ),
                        ),
                        child: Text(
                          languageProvider.getString('already_have_account_question'), // Localized text
                          style: GoogleFonts.raleway(color: _white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // Bottom padding
                ],
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 60), // Space for "Welcome Back" text
                  Text(
                    languageProvider.getString('welcome_back_title'), // Localized text
                    style: GoogleFonts.raleway(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: _white, // Text color consistent with new palette
                    ),
                  ),
                  const Spacer(flex: 2), // Pushes text fields down
                  _AuthInputField(
                    hintKey: 'email_hint', // Use hintKey
                    controller: _emailController,
                  ),
                  _AuthInputField(
                    hintKey: 'password_hint', // Use hintKey
                    obscure: true,
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 10), // Small space after password field
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        languageProvider.getString('forgot_password_question'), // Localized text
                        style: GoogleFonts.raleway(
                            fontSize: 12, color: _darkBlue), // Text color changed to dark blue
                      ),
                    ],
                  ),
                  const Spacer(), // Pushes login button down
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        // Added "Login" text
                        languageProvider.getString('login_button'), // Localized text
                        style: GoogleFonts.raleway(fontSize: 16, color: _darkBlue),
                      ),
                      const SizedBox(width: 10), // Added spacing
                      GestureDetector(
                        onTap: () {
                          // Navigate to HomePage after login
                          Navigator.of(context).pushAndRemoveUntil<void>(
                              _buildPageRouteWithSlideTransition(HomePage()),
                                  (Route<dynamic> route) => false);
                        },
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundColor: _darkBlue, // Changed to _darkBlue
                          child: Icon(Icons.arrow_forward, color: _white),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(flex: 3), // Pushes "Create Account" button down
                  Align(
                    alignment: Alignment
                        .bottomRight, // Align button to bottom-right within its space
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pushReplacement<void, void>(
                          _buildPageRouteWithSlideTransition(SignupPage())),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        decoration: const BoxDecoration(
                          color: _darkBlue, // Changed to _darkBlue
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(0), // No topRight curve
                            topLeft: Radius.circular(40), // Added topLeft curve
                            bottomRight: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                          ),
                        ),
                        child: Text(
                          languageProvider.getString('create_account_button'), // Localized text
                          style: GoogleFonts.raleway(color: _white, fontWeight: FontWeight.bold), // Text color consistent
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // Bottom padding
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// DATA_MODEL for HomePage
enum BusStatus {
  notCrowded,
  crowded,
  almostCrowded,
}

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

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavSelectedIndex = 0; // For BottomNavigationBar display
  late PageController _pageController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // GlobalKey for Scaffold

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0); // Start on Home page (PageView index 0)
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
          greeting: languageProvider.getString('app_bar_greeting'),
          onLeadingPressed: openDrawerCallback, // Use the callback to open the drawer
        );
      case 2: // Tip
        return _TipAppBar(title: languageProvider.getString('tip_earn_title'));
      case 3: // SOS
        return _SOSAppBar(title: languageProvider.getString('emergency_sos_title')); // Changed to new title
      default:
      // Default to Home AppBar for language toggle (index 1) or other cases
        return _HomeAppBar(
          greeting: languageProvider.getString('app_bar_greeting'),
          onLeadingPressed: openDrawerCallback, // Use the callback to open the drawer
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
      drawer: _AppDrawer( // Add the drawer here
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
  final String title;
  final IconData? leadingIcon;
  final VoidCallback? onLeadingPressed; // New: callback for leading icon
  final IconData? titleIcon; // New: icon for the title, e.g., lightbulb
  final List<Widget>? actions;

  const _CustomAppBar({
    super.key,
    required this.title,
    this.leadingIcon,
    this.onLeadingPressed, // Initialize new callback
    this.titleIcon,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: _darkBlue,
      elevation: 0,
      leading: leadingIcon != null
          ? IconButton(
        icon: Icon(leadingIcon, color: _white),
        onPressed: onLeadingPressed, // This callback now handles opening the drawer via GlobalKey
      )
          : null,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (titleIcon != null) ...<Widget>[
            Icon(titleIcon, color: _white, size: 20),
            const SizedBox(width: 8),
          ],
          Text(
            title,
            style: GoogleFonts.raleway(color: _white, fontWeight: FontWeight.bold),
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
  final String greeting;
  final VoidCallback? onLeadingPressed; // Callback for the menu button

  const _HomeAppBar({
    super.key,
    required this.greeting,
    this.onLeadingPressed,
  });

  @override
  Widget build(BuildContext context) {
    return _CustomAppBar(
      title: greeting,
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
class MapPage extends StatelessWidget {
  final String fromLocation;
  final String toLocation;

  const MapPage({
    super.key,
    required this.fromLocation,
    required this.toLocation,
  });

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = context.watch<LanguageProvider>();
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
                height: 200,
                width: double.infinity,
                child: FlutterMap(
                  options: const MapOptions(
                    initialCenter: LatLng(27.7172, 85.3240), // Example: Kathmandu
                    initialZoom: 13.0,
                  ),
                  children: <Widget>[
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.transport_app', // Unique package name
                    ),
                    MarkerLayer(
                      markers: <Marker>[
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: const LatLng(27.7172, 85.3240), // Example: Kathmandu center
                          child: // Changed 'builder' to 'child'
                          const Icon(Icons.location_on, size: 40, color: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '${languageProvider.getString('from_label')} $fromLocation',
              style: GoogleFonts.raleway(fontSize: 16, color: _darkBlue, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '${languageProvider.getString('to_label')} $toLocation',
              style: GoogleFonts.raleway(fontSize: 16, color: _darkBlue, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Text(
              'Estimated travel time: 30 min (approx.)', // Hardcoded for placeholder
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
  // bool _showMap = false; // Removed as map is now a separate page

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
          fromLocation: _fromLocationController.text.isEmpty
              ? 'Unknown Origin'
              : _fromLocationController.text,
          toLocation: _toLocationController.text.isEmpty
              ? 'Unknown Destination'
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
          const _SearchInput(),
          const SizedBox(height: 15),
          const _CurrentLocationDisplay(),
          const SizedBox(height: 20),
          const _LiveBusesCard(),
          const SizedBox(height: 20),
          _PlanTripCard(
            fromController: _fromLocationController,
            toController: _toLocationController,
            onSuggestRoute: _onSuggestRoute,
          ),
          // _MapDisplay removed from here as it's now a separate page
          const SizedBox(height: 20), // Bottom padding
        ],
      ),
    );
  }
}

class _SearchInput extends StatelessWidget {
  const _SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = context.watch<LanguageProvider>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: _white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _lightBlue, width: 1), // Subtle light blue border
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.search, color: _lightBlue), // Search icon
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              readOnly: true, // Placeholder functionality
              decoration: InputDecoration(
                hintText: languageProvider.getString('search_hint'), // Localized hint
                hintStyle: GoogleFonts.raleway(color: Colors.grey[400]),
                border: InputBorder.none, // Remove default TextField border
                contentPadding: EdgeInsets.zero, // Remove default padding
                isDense: true, // Make it compact
              ),
              style: GoogleFonts.raleway(color: _darkBlue),
            ),
          ),
        ],
      ),
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
              style: GoogleFonts.raleway(color: _darkBlue, fontSize: 14), // Based on image
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
        borderRadius: BorderRadius.circular(20), // More rounded corners for cards
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
                languageProvider.getString('live_nearby_buses_title'), // Localized text
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
            children:
            _liveBuses.map<Widget>((BusRoute bus) => _BusEntryRow(bus: bus)).toList(),
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
              style: GoogleFonts.raleway(fontWeight: FontWeight.bold, color: _darkBlue),
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
                  languageProvider.getString(bus.timeAwayKey), // Localized time away
                  style: GoogleFonts.raleway(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          Icon(_getStatusIcon(bus.status), color: _getStatusColor(bus.status), size: 18),
          const SizedBox(width: 5),
          Text(
            _getStatusText(bus.status, languageProvider), // Localized status text
            style: GoogleFonts.raleway(color: _getStatusColor(bus.status), fontSize: 12),
          ),
          const SizedBox(width: 8),
          Text(
            languageProvider.getString(bus.minutesAgoKey), // Localized minutes ago
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

  const _PlanTripCard({
    super.key,
    required this.fromController,
    required this.toController,
    required this.onSuggestRoute,
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
                languageProvider.getString('plan_your_trip_title'), // Localized text
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
                    _TripInputField(
                        labelKey: 'from_label',
                        icon: Icons.location_on,
                        controller: fromController), // Pass controller
                    const SizedBox(height: 10),
                    _TripInputField(
                        labelKey: 'to_label',
                        icon: Icons.person_outline,
                        controller: toController), // Pass controller
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
                      languageProvider.getString('estimated_time_label'), // Localized text
                      style: GoogleFonts.raleway(fontSize: 12, color: _darkBlue),
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
                        style: GoogleFonts.raleway(color: _darkBlue, fontWeight: FontWeight.bold),
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
                languageProvider.getString('suggest_smart_route_button'), // Localized text
                style: GoogleFonts.raleway(color: _white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _darkBlue, // Button background
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TripInputField extends StatelessWidget {
  final String labelKey;
  final IconData icon;
  final TextEditingController controller; // Added controller

  const _TripInputField({
    super.key,
    required this.labelKey,
    required this.icon,
    required this.controller, // Initialize controller
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
        TextField(
          controller: controller, // Use the provided controller
          // readOnly: true, // Removed readOnly to allow input
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            hintText: languageProvider.getString('enter_location_hint'), // Localized hint
            hintStyle: GoogleFonts.raleway(color: Colors.grey[400], fontSize: 12),
            prefixIcon: Icon(icon, color: Colors.grey[600], size: 18),
            filled: true,
            fillColor: _white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none, // No border visible in image
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
          icon: Icon(Icons.home, color: selectedIndex == 0 ? _darkBlue : Colors.grey),
          label: languageProvider.getString('home_tab'), // Localized label
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.language,
              color: selectedIndex == 1 ? _darkBlue : Colors.grey), // Replaced image with Icons.language
          label: languageProvider.getString('toggle_language_label'), // Dynamically localized label
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.lightbulb_outline,
              color: selectedIndex == 2 ? _darkBlue : Colors.grey), // Tip icon
          label: languageProvider.getString('tip_tab'), // Localized label
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.public,
              color: selectedIndex == 3 ? _darkBlue : Colors.grey), // SOS globe icon
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
class _TipPageWaveClipper extends CustomClipper<ui.Path> { // Changed Path to ui.Path
  @override
  ui.Path getClip(Size size) { // Changed Path to ui.Path
    final ui.Path path = ui.Path(); // Changed Path to ui.Path
    path.lineTo(0, size.height * 0.7); // Start at a point on the left edge
    final double controlPoint1X = size.width * 0.25;
    final double controlPoint1Y = size.height * 0.85;
    final double endPoint1X = size.width * 0.5;
    final double endPoint1Y = size.height * 0.7;

    path.quadraticBezierTo(controlPoint1X, controlPoint1Y, endPoint1X, endPoint1Y);

    final double controlPoint2X = size.width * 0.75;
    final double controlPoint2Y = size.height * 0.55;
    final double endPoint2X = size.width;
    final double endPoint2Y = size.height * 0.65; // Slightly higher than starting point

    path.quadraticBezierTo(controlPoint2X, controlPoint2Y, endPoint2X, endPoint2Y);

    path.lineTo(size.width, 0); // Line to top right
    path.lineTo(0, 0); // Line to top left
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<ui.Path> oldClipper) => false; // Changed Path to ui.Path
}

class _UserInfoSection extends StatelessWidget {
  const _UserInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = context.watch<LanguageProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0), // Consistent with auth pages
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
          borderSide: const BorderSide(color: _lightBlue, width: 2), // Blue border on focus
        ),
        contentPadding:
        const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
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
      style: GoogleFonts.raleway(
        fontSize: 16,
        color: _darkBlue,
      ),
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
            color: isSelected ? color.withOpacity(0.1) : _white, // Light fill when selected
            borderRadius: BorderRadius.circular(15), // More rounded corners
            border: Border.all(
              color: isSelected ? color : _lightGrey, // Thicker border when selected
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
              height: screenSize.height * 0.5, // Make blue area cover more for text/pfp
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
            decoration: BoxDecoration(shape: BoxShape.circle, color: _darkBlue.withOpacity(0.2)),
          ),
        ),
        Positioned(
          top: screenSize.height * 0.35,
          left: screenSize.width * 0.2,
          child: Container(
            width: screenSize.width * 0.2,
            height: screenSize.width * 0.2,
            decoration: BoxDecoration(shape: BoxShape.circle, color: _darkBlue.withOpacity(0.2)),
          ),
        ),
        // Main scrollable content
        Positioned.fill(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  SizedBox(height: screenSize.height * 0.08), // Space below custom app bar
                  const _UserInfoSection(),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _PublicRideNumberInput(controller: _publicRideNumberController),
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
                              print('Public Ride Number: ${_publicRideNumberController.text}');
                              // ignore: avoid_print
                              print('Selected Status: $_selectedBusStatus');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        languageProvider.getString('submit_tip_button') + ' pressed!')),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20), // Bottom padding for scroll view
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
class _HexagonClipper extends CustomClipper<ui.Path> { // Changed Path to ui.Path
  @override
  ui.Path getClip(Size size) { // Changed Path to ui.Path
    final ui.Path path = ui.Path(); // Changed Path to ui.Path
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
  bool shouldReclip(covariant CustomClipper<ui.Path> oldClipper) => false; // Changed Path to ui.Path
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
                            '${languageProvider.getString('call_medical')} button pressed!')),
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
                            '${languageProvider.getString('call_fire')} button pressed!')),
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
                            '${languageProvider.getString('call_police')} button pressed!')),
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
                  'User Name', // Placeholder user name
                  style: GoogleFonts.raleway(color: _white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'user@example.com', // Placeholder user email
                  style: GoogleFonts.raleway(color: _white.withOpacity(0.8), fontSize: 12),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: _darkBlue),
            title: Text(languageProvider.getString('home_tab'), style: GoogleFonts.raleway(color: _darkBlue)),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              onHomeTap();
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: _darkBlue),
            title: Text(languageProvider.getString('profile_menu'), style: GoogleFonts.raleway(color: _darkBlue)),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              onProfileTap();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(languageProvider.getString('profile_menu') + ' tapped!')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: _darkBlue),
            title: Text(languageProvider.getString('settings_menu'), style: GoogleFonts.raleway(color: _darkBlue)),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              onSettingsTap();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(languageProvider.getString('settings_menu') + ' tapped!')),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: Text(languageProvider.getString('logout_menu'), style: GoogleFonts.raleway(color: Colors.red)),
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