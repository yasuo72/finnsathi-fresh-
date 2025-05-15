// This file contains the Sign Up screen for the Finsaathi Multi app.
import 'package:flutter/material.dart';
import '../../widgets/custom_text_field.dart';
import '../../services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  bool _agreed = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _dobController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 230,
              decoration: const BoxDecoration(
                color: Color(0xFF4866FF),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(height: 40),
                  Icon(Icons.account_circle, size: 56, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    'Sign up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  CustomTextField(hint: 'Your Name', icon: Icons.person_outline, controller: _nameController),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        String formattedDate = "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
                        setState(() {
                          _dobController.text = formattedDate;
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: CustomTextField(
                        hint: 'Date of Birth',
                        icon: Icons.calendar_today_outlined,
                        controller: _dobController,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  CustomTextField(hint: 'Email', icon: Icons.email_outlined, controller: _emailController),
                  SizedBox(height: 16),
                  CustomTextField(hint: 'Password', icon: Icons.lock_outline, obscure: true, controller: _passwordController),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                        value: _agreed,
                        onChanged: (v) {
                          setState(() {
                            _agreed = v ?? false;
                          });
                        },
                      ),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: 'By signing up, you agree to the ',
                            style: TextStyle(fontSize: 12),
                            children: [
                              TextSpan(
                                text: 'Terms of Service',
                                style: TextStyle(color: Color(0xFF4866FF)),
                              ),
                              TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(color: Color(0xFF4866FF)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () async {
                              if (!_agreed) {
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('You must agree to the Terms of Service and Privacy Policy.')),
                                );
                                return;
                              }
                              if (_nameController.text.isEmpty || _dobController.text.isEmpty || _emailController.text.isEmpty || _passwordController.text.isEmpty) {
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Please fill in all fields.')),
                                );
                                return;
                              }
                              setState(() => _isLoading = true);
                              try {
                                final response = await AuthService.signup(
                                  name: _nameController.text,
                                  dob: _dobController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                                if (!mounted) return;
                                if (response.statusCode == 200) {
                                  Navigator.pushNamed(context, '/verification');
                                } else {
                                  if (!mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Signup failed: ${response.body}')),
                                  );
                                }
                              } catch (e) {
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('An error occurred: ${e.toString()}')),
                                );
                              } finally {
                                if (!mounted) return;
                                setState(() => _isLoading = false);
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4866FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Sign up',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text('or'),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton.icon(
                      icon: Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/4/4a/Logo_2013_Google.png',
                        height: 24,
                      ),
                      label: Text('Continue with Google'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/mobile');
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Color(0xFF4866FF)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account? ', style: TextStyle(fontSize: 14)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/signin');
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: Color(0xFF4866FF), fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
