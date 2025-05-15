// Finsaathi Multi App - Custom Sign Up Screen
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/splash_screen.dart';
import 'screens/loading_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/auth/verification_screen.dart';
import 'screens/mobile_screen.dart';
import 'screens/auth/signin_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/auth/forgot_otp_screen.dart';
import 'screens/auth/new_password_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/auth/pin_screen.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  fontFamily: 'Inter',
  scaffoldBackgroundColor: const Color(0xFFF8F7FA),
  cardColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
  ),
  colorScheme: const ColorScheme.light(
    primary: Colors.blue,
    secondary: Colors.deepPurple,
    surface: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.black87,
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blue,
  fontFamily: 'Inter',
  scaffoldBackgroundColor: const Color(0xFF18191A),
  cardColor: const Color(0xFF23272A),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF23272A),
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
  ),
  colorScheme: const ColorScheme.dark(
    primary: Colors.blue,
    secondary: Colors.deepPurple,
    surface: Color(0xFF23272A),
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white70,
  ),
);

Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  runApp(const FinsaathiApp());
}

class FinsaathiApp extends StatefulWidget {
  const FinsaathiApp({super.key});

  @override
  FinsaathiAppState createState() => FinsaathiAppState();
}

class FinsaathiAppState extends State<FinsaathiApp> {
  bool isDarkMode = false;

  void toggleDarkMode(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Finsaathi Multi',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/loading': (context) => const LoadingScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/verification': (context) => const VerificationScreen(),
        '/mobile': (context) => const MobileScreen(),
        '/signin': (context) => const SignInScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
        '/forgot_otp': (context) => const ForgotOtpScreen(),
        '/new_password': (context) => const NewPasswordScreen(),
        '/home': (context) => const HomeScreen(),
        '/pin': (context) => const PinScreen(),
      },
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool obscure;
  const CustomTextField({super.key, required this.hint, required this.icon, this.obscure = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Color(0xFF4866FF)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFF4866FF)),
        ),
      ),
    );
  }
}
