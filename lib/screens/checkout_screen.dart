import 'package:ecommerce_app/widgets/checkout_card.dart';
import 'package:ecommerce_app/widgets/rounded_profile_image.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late String chosenMethod;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          RoundedProfileImage(),
          SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              CheckOutCard(
                title: "Cash",
                isChecked: chosenMethod == "Cash",
                onCheck: (item, isChecked) {
                  setState(() {
                    chosenMethod = "Cash";
                  });
                },
                children: const [],
              ),
              const SizedBox(height: 10),
              CheckOutCard(
                title: "Wallet",
                isChecked: chosenMethod == "Wallet",
                onCheck: (item, isChecked) {
                  setState(() {
                    chosenMethod = "Wallet";
                  });
                },
                children: const [],
              ),
              const SizedBox(height: 10),
              CheckOutCard(
                title: "Credit Card",
                isChecked: chosenMethod == "Credit Card",
                onCheck: (item, isChecked) {
                  setState(() {
                    chosenMethod = "Credit Card";
                  });
                },
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Card Name",
                            label: Text("Card Number"),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter value";
                            } else {
                              return null;
                            }
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
