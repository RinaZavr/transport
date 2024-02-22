import 'package:flutter/material.dart';
import 'package:transport/ui/templates/button_template.dart';
import 'package:transport/ui/travels/screens/travels_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Icon(
              Icons.travel_explore_rounded,
              size: 200,
            ),
            const SizedBox(
              height: 100,
            ),
            ButtonTemplate(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TravelsScreen(),
                    ),
                  );
                },
                title: 'Get Started'),
            ButtonTemplate(
                onTap: _launchURL, title: 'Terms and Conditions'),
            ButtonTemplate(onTap: _launchURL, title: 'Privacy Policy'),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  _launchURL() async {
    final Uri url = Uri.parse('https://pub.dev');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
