import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({super.key});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MediaQuery.sizeOf(context).width > 600
            ? 'Purchase'.text.make()
            : null,
      ),
      body: Column(
        children: [],
      ).p20().scrollVertical(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: FaIcon(Icons.add),
          label: const Text('Add A New Purchase'),
        ),
      ),
    );
  }
}
