import 'package:flutter/material.dart';
import 'package:fotoporcelana/widgets/krysztal/krysztal_data.dart';
import 'package:fotoporcelana/widgets/krysztal/select_amount.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            KrysztalData(),
            SizedBox(
              height: 12,
            ),
            SelectAmount(),
          ],
        ),
      ),
    );
  }
}
