import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/LoginResponse.dart';
import '../retrofit/CommonService.dart';
import 'forgot_password_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _selectedDepartments = '--Select--';
  final List<String> _department = ['--Select--', 'AGRICULTURE', 'HORTICULTURE', 'IRRIGATION', 'DIARY', 'VETERINARY', 'FOOD & CIVIL SUPPLIES', 'OTHERS'];
  String _mobileNumber = '';
  String _password = '';
  bool _isLoading = false;
  // TextEditingController instances
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    if (_mobileNumber.isEmpty || _password.isEmpty || _selectedDepartments == '--Select--') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all required fields')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final commonService = Provider.of<CommonService>(context, listen: false);
      final LoginResponse response = await commonService.login(
        "superadministrator@btragri.co.in",
        _password,
        "D001",
        // _selectedDepartments ?? '',
      );
      print("login_response success: ${response.toString()}");

      if (response.status!) {
        // Handle successful login
        print('token'+response.token.toString());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.token ?? '');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()),);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Success')));

      } else {
        // Show error message if login failed
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to log in: ${response.toString()}')),);
      }
    } catch (e) {
      print("login_response catch: ${e.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to log in: ${e.toString()}')),);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 50),
              Image.asset(
                'resources/image/BTRgov-logo.png',
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                'Email :',
                'Enter email address',
                _mobileNumberController,
                    (value) {
                  setState(() {
                    _mobileNumber = value ?? '';
                  });
                },
                isPhone: true
              ),
              const SizedBox(height: 16),
              _buildTextField(
                'Password :',
                'Enter Password',
                _passwordController,
                    (value) {
                  setState(() {
                    _password = value ?? '';
                  });
                },
              ),
              const SizedBox(height: 16),
              _buildDropdown(
                'Select Department',
                _selectedDepartments,
                _department,
                    (String? newValue) {
                  setState(() {
                    _selectedDepartments = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                      );
                    },
                    child: const Text('Forgot Password?'),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green[800],
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.5,
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Log In'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label,
      String hint,
      TextEditingController controller,
      ValueChanged<String?> onChanged, {
        bool isPhone = false, // Add an optional parameter for phone input
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: Colors.grey),
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
            ),
            keyboardType: isPhone ? TextInputType.emailAddress : TextInputType.text, // Use phone keyboard if isPhone is true
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }


  Widget _buildDropdown(
      String label,
      String? selectedValue,
      List<String> items,
      ValueChanged<String?> onChanged,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: Colors.grey),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedValue,
              isExpanded: true,
              onChanged: onChanged,
              items: items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
