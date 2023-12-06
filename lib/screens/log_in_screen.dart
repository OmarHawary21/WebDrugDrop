import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'add_drug_screen.dart';
import '../providers/auth_provider.dart';
import '../../widgets/logo.dart';
import '../../widgets/olives.dart';

class LogInScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

var _isVisible;

class _LogInScreenState extends State<LogInScreen> {
  @override
  void initState() {
    _isVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var media = MediaQuery.of(context);

    return Scaffold(
      body: FadeInUp(
        duration: const Duration(milliseconds: 2000),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Logo(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: media.size.height * 0.7,
                        child: SvgPicture.asset('assets/images/Login.svg'),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FittedBox(
                        child: Text(
                          'Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'PollerOne',
                            fontSize: 20,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                      FittedBox(
                        child: Text(
                          'sign in to continue',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                      SizedBox(height: media.size.height * 0.05),
                      Forms(),
                    ],
                  ),
                ],
              ),
              Olives(),
            ],
          ),
        ),
      ),
    );
  }
}

class Forms extends StatefulWidget {
  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _authData = {
    'phoneNumber': '',
    'password': '',
  };
  var _isLoading = false;

  @override
  void initState() {
    _isVisible = true;
    super.initState();
  }

  void _showDialog(BuildContext context, String content) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'An error Occurred',
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
        content: Text(content),
        actions: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Try again'),
          ),
        ],
      ),
    );
  }

  void submit() async {
    final validator = _formKey.currentState?.validate();
    if (validator == null || !validator) {
      return;
    }
    _formKey.currentState?.save();
    setState(() => _isLoading = true);
    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .login(_authData['phoneNumber']!, _authData['password']!);
      Navigator.of(context).pushNamedAndRemoveUntil(
          AddDrugScreen.routeName, (Route<dynamic> route) => false);
    } catch (error) {
      _showDialog(context,
          'You are not allowed.');
    }
    setState(() => _isLoading = false);
  }
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var media = MediaQuery.of(context);
    final constraints = BoxConstraints(
      maxHeight: media.size.height * 0.055,
      maxWidth: media.size.width * 0.3,
    );
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            maxLines: 1,
            maxLength: 8,
            decoration: InputDecoration(
              constraints: constraints,
              contentPadding: const EdgeInsets.only(left: 15),
              prefixIcon: const Icon(Icons.phone),
              prefixIconColor: theme.colorScheme.primary,
              prefix: const Padding(
                padding: EdgeInsets.only(right: 5),
                child: Text('09'),
              ),
              prefixStyle: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              label: const Text('Phone Number'),
              isDense: true,
              filled: true,
              fillColor: theme.colorScheme.secondary,
              counterText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            validator: (phoneNumber) {
              if (phoneNumber!.isEmpty) {
                return 'This field is required';
              } else if (phoneNumber.length < 8) {
                return 'Must be 8 digits';
              }
            },
            onSaved: (phoneNumber) =>
            _authData['phoneNumber'] = phoneNumber.toString(),
          ),
          const SizedBox(height: 10),
          TextFormField(
            obscureText: _isVisible,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              constraints: constraints,
              contentPadding: const EdgeInsets.only(left: 15),
              prefixIcon: const Icon(Icons.lock),
              prefixIconColor: theme.colorScheme.primary,
              label: const Text('Password'),
              suffixIcon: IconButton(
                onPressed: () => setState(() => _isVisible = !_isVisible),
                icon: Icon(
                    _isVisible ? Icons.visibility : Icons.visibility_off),
              ),
              suffixIconColor: theme.colorScheme.primary,
              isDense: true,
              filled: true,
              fillColor: theme.colorScheme.secondary,
              counterText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            validator: (phoneNumber) {
              if (phoneNumber!.isEmpty) {
                return 'This field is required';
              }
            },
            onSaved: (password) =>
            _authData['password'] = password.toString(),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: submit,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
            ),
            child: _isLoading
                ? const CircularProgressIndicator(
              color: Colors.white,
              strokeCap: StrokeCap.round,
            )
                : const Text(
              'Login',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.2,
          child: ElevatedButton(
            onPressed: () =>
                Navigator.of(context).popAndPushNamed(AddDrugScreen.routeName),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Login',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
