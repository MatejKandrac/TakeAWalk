
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:take_a_walk_app/views/register/bloc/register_bloc.dart';
import 'package:take_a_walk_app/widget/app_button.dart';
import 'package:take_a_walk_app/widget/app_text_field.dart';

@RoutePage()
class RegisterPage extends HookWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPassController = useTextEditingController();
    final usernameController = useTextEditingController();

    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {

      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) => SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Register", style: Theme.of(context).textTheme.displayMedium),
                  const SizedBox(height: 10),
                  Expanded(
                      child: Stack(
                        children: [
                          Positioned(
                            top: 35,
                            right: 0,
                            left: 0,
                            child: Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 30),
                                child: Column(
                                  children: [
                                    AppTextField(
                                      controller: usernameController,
                                      labelText: "Username",
                                      icon: const Icon(Icons.account_circle, size:35),
                                      inputAction: TextInputAction.next,
                                    ),
                                    const SizedBox(height: 30),
                                    AppTextField(
                                      controller: emailController,
                                      labelText: "E-mail",
                                      icon: const Icon(Icons.email_outlined, size:35),
                                      inputAction: TextInputAction.next,
                                    ),
                                    const SizedBox(height: 30),
                                    AppTextField(
                                      controller: passwordController,
                                      labelText: "Password",
                                      icon: const Icon(Icons.lock_outline, size:35),
                                      inputAction: TextInputAction.next,
                                      obscureText: true,
                                    ),
                                    const SizedBox(height: 30),
                                    AppTextField(
                                      controller: confirmPassController,
                                      labelText: "Confirm password",
                                      icon: const Icon(Icons.lock_outline, size:35),
                                      inputAction: TextInputAction.next,
                                      obscureText: true,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Align(
                            alignment: Alignment.topCenter,
                            child: Icon(Icons.account_circle, size: 70),
                          )
                        ],
                      )
                  ),
                  AppButton.gradient(child: const Text("Register"), onPressed: () {})
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
