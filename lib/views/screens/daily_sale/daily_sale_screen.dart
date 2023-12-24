import 'package:flutter/material.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/views/screens/daily_sale/add_sale_data_screen.dart';

class DailySaleScreen extends StatelessWidget {
  const DailySaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          "Daily Sales",
          style: TextStyle(
            color: whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddSaleDataScreen(),
              ),
            );
          },
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          )),
      body: const Center(
        child: Text("I am Daily Sale Screen"),
      ),
    ));
  }
}
