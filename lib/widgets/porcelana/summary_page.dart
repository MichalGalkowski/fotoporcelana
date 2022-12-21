import 'package:flutter/material.dart';
import 'package:fotoporcelana/widgets/porcelana/porcelana_data.dart';
import 'package:fotoporcelana/widgets/porcelana/select_amount.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            PorcelanaData(),
            SizedBox(height: 10),
            SelectAmount(),
          ],
        ),
      ),
    );
  }
}
