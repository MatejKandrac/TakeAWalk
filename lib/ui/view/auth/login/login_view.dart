import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:take_a_walk_app/config/router/router.dart';
import 'package:take_a_walk_app/di.dart';
import 'package:take_a_walk_app/ui/bloc/bloc_container.dart';
import 'package:take_a_walk_app/ui/widget/app_button.dart';
import 'package:take_a_walk_app/ui/widget/app_text_field.dart';

@RoutePage()
class LoginPage extends HookWidget {
  const LoginPage({Key? key}) : super(key: key);

  _onLogin(String email, String password, BuildContext context) {
    BlocProvider.of<LoginBloc>(context).login(email, password);
  }
  
  _onRegister(BuildContext context) {
    AutoRouter.of(context).push(const RegisterRoute());
  }

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final bloc = useMemoized<LoginBloc>(() => di());
    return BlocProvider<LoginBloc>(
      create: (context) => bloc,
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) => SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Login", style: Theme.of(context).textTheme.displayLarge),
                  const SizedBox(height: 10),
                  Expanded(
                      child: Stack(
                        children: [
                          Positioned.fill(
                            top: 35,
                            child: Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
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
                                    )
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
                  Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AppButton.gradient(
                              onPressed: () => _onLogin(emailController.text, passwordController.text, context),
                              child: Text("Login", style: Theme.of(context).textTheme.bodyMedium)
                          ),
                          Text("Don't have an account?", style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold
                          )),
                          AppButton.text(
                              child: Text("Create new account", style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: const Color(0xff7740c2)
                              )),
                              onPressed: () => _onRegister(context)
                          )
                        ],
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
