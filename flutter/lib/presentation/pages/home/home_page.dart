import 'package:flutter/material.dart';
import 'package:google_solution2/resources/widgets/public_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: PublicText(txt: "Soon...",),
    );
  }
}