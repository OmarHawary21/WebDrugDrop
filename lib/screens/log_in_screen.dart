import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';
import '../widgets/logo.dart';
import '../widgets/my_upper_clipper.dart';
import '../providers/auth_provider.dart';

class LogInScreen extends StatelessWidget {
  static const routeName = '/log-in';

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var media = MediaQuery.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: media.size.height - media.padding.top,
          margin: EdgeInsets.only(
            top: media.padding.top,
            bottom: media.padding.bottom,
          ),
          child: Stack(
            children: [
              Center(
                child: Image.asset(
                  'assets/images/Login.png',
                  color: Colors.white.withOpacity(0.2),
                  colorBlendMode: BlendMode.modulate,
                ),
              ),
              ClipPath(
                clipper: MyUpperClipper(),
                child: Container(
                  height: media.size.height * 0.2,
                  width: double.infinity,
                  color: const Color.fromRGBO(205, 230, 255, 1),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Transform.flip(
                  flipX: true,
                  flipY: true,
                  child: ClipPath(
                    clipper: MyUpperClipper(),
                    child: Container(
                      height: media.size.height * 0.2,
                      width: double.infinity,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
              SlideInUp(
                duration: const Duration(milliseconds: 1000),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Logo(color: theme.colorScheme.primary),
                    const Spacer(),
                    Column(
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
                      ],
                    ),
                    const Spacer(),
                    Forms(),
                    const Spacer(flex: 2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Circle extends StatelessWidget {
  final double radius;
  final Color color;

  Circle(this.radius, {this.color = const Color.fromRGBO(205, 230, 255, 1)});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color,
      radius: radius,
    );
  }
}

var _isVisible;

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
          .login(_authData['phoneNumber']!, _authData['password']!)
          .timeout(
            const Duration(seconds: 5),
            onTimeout: () => throw Exception('Something went wrong'),
          );
      Navigator.of(context).pushNamedAndRemoveUntil(
          HomeScreen.routeName, (Route<dynamic> route) => false);
    } catch (error) {
      _showDialog(
        context,
        error.toString() == 'Something went wrong'
            ? 'Something went wrong.'
            : 'Worng phone number or password please check the spelling and try again.',
      );
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      child: Form(
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
                constraints: BoxConstraints(maxWidth: size.width * 0.3),
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
                fillColor: Colors.transparent,
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
            const SizedBox(height: 20),
            TextFormField(
              obscureText: _isVisible,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                constraints: BoxConstraints(maxWidth: size.width * 0.3),
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
                fillColor: Colors.transparent,
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
            _isLoading
                ? CircularProgressIndicator(
                    color: theme.colorScheme.primary,
                    strokeCap: StrokeCap.round,
                  )
                : ElevatedButton(
                    // onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                    //     HomeBottomBar.routeName, (Route<dynamic> route) => false),
                    onPressed: submit,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
