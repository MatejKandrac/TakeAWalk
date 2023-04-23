import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:take_a_walk_app/config/router/router.dart';
import 'package:take_a_walk_app/widget/app_button.dart';
import 'package:take_a_walk_app/widget/app_text_field.dart';
import 'package:take_a_walk_app/widget/loading_dialog.dart';
import 'package:take_a_walk_app/widget/success_dialog.dart';

import 'bloc/login_bloc.dart';

@RoutePage()
class LoginPage extends HookWidget {
  const LoginPage({Key? key}) : super(key: key);

  _onLoginSuccess(BuildContext context) {
    Navigator.of(context).pop(); // pop loading
    showStateDialog(
        context: context,
        isSuccess: true,
        text: "Successfully logged in!"
    ).then((value) => AutoRouter.of(context).replace(MyEventsRoute()));
  }

  _onLogin(String email, String password, BuildContext context) {
    BlocProvider.of<LoginBloc>(context).login(email, password);
  }
  
  _onRegister(BuildContext context) {
    AutoRouter.of(context).push(const RegisterRoute());
  }

  _onLoading(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const LoadingDialog(loadingText: "Logging in, please wait...")
    );
  }

  _onError(BuildContext context, String error) {
    Navigator.of(context).pop(); // Pop loading dialog
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(error, style: Theme.of(context).textTheme.bodySmall),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = useMemoized<LoginBloc>(() => BlocProvider.of(context));
    useEffect(() {
      bloc.emitLoginFormState();
      return null;
    }, const []);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          _onLoginSuccess(context);
        } else if (state is LoginLoadingState) {
          _onLoading(context);
        } else if (state is LoginErrorState) {
          _onError(context, state.errorText);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => current is LoginFormState,
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Login", style: Theme.of(context).textTheme.displayMedium),
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
                                        errorText: (state as LoginFormState).emailError ? "This field is required" : null,
                                      ),
                                      const SizedBox(height: 30),
                                      AppTextField(
                                        controller: passwordController,
                                        labelText: "Password",
                                        icon: const Icon(Icons.lock_outline, size:35),
                                        inputAction: TextInputAction.next,
                                        obscureText: true,
                                        errorText: state.passwordError ? "This field is required" : null,
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
                        ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
