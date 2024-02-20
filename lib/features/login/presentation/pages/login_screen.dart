import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tobby_reviewer/core/widgets/app_logo_view.dart';
import 'package:tobby_reviewer/core/widgets/custom_button.dart';
import 'package:tobby_reviewer/core/widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppLogoView(),
              const Gap(64),
              const Form(
                child: CustomTextFormField(),
              ),
              const Gap(32),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: const CustomButton.positive(title: 'Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
