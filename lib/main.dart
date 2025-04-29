// Finsaathi Multi App - Custom Sign Up Screen
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/splash_screen.dart';
import 'screens/loading_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/verification_screen.dart';
import 'screens/mobile_screen.dart';
import 'screens/signin_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/forgot_otp_screen.dart';
import 'screens/new_password_screen.dart';
import 'screens/signup_screen.dart';

Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  runApp(const FinsaathiApp());
}

class FinsaathiApp extends StatelessWidget {
  const FinsaathiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Finsaathi Multi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
      ),
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
