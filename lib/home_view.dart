import 'package:fingerscan/chk.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final LocalAuthentication auth;
  bool _supportState = false;

  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() {
            _supportState = isSupported;
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          if (_supportState)
            const Text('The device is supported')
          else
            const Text('The device is not supported'),
          const Divider(
            height: 50,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Text(
              'Continue with your \n\t\t\t\t\t\t\tFingerprint',
              style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Center(
            child: Lottie.asset('animations/scan.json',
                height: 300, repeat: true, fit: BoxFit.cover),
          ),
          GestureDetector(
              onTap: () {
                // _authenticate();
                _authenticateAndNavigate(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 90),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 0.09,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.fingerprint,
                        color: Colors.white,
                        size: 45,
                      ),
                      Text(
                        "Authenticate",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Future<void> _authenticateAndNavigate(BuildContext context) async {
    try {
      bool authenticated =
          await _authenticate(); 

      if (authenticated) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ChkPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Authentication failed'),),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<bool> _authenticate() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Scan Fingerprint to Authenticate',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      return authenticated;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    if (kDebugMode) {
      print("List of availableBiometrics: $availableBiometrics");
    }
    if (!mounted) {
      return;
    }
  }
}
