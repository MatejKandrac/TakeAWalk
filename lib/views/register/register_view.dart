
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:take_a_walk_app/config/router/router.dart';
import 'package:take_a_walk_app/views/register/bloc/register_bloc.dart';
import 'package:take_a_walk_app/widget/app_button.dart';
import 'package:take_a_walk_app/widget/app_text_field.dart';
import 'package:take_a_walk_app/widget/loading_dialog.dart';
import 'package:take_a_walk_app/widget/success_dialog.dart';

@RoutePage()
class RegisterPage extends HookWidget {
  const RegisterPage({Key? key}) : super(key: key);

  _onRegister(BuildContext context, String username, String email,
      String pass, String confirmPass) {
    BlocProvider.of<RegisterBloc>(context).register(username, email, pass, confirmPass);
  }

  void _onRegisterSuccess(BuildContext context) {
    Navigator.of(context).pop();
    showStateDialog(
      context: context,
      isSuccess: true,
      text: "Account created successfully!"
    ).then((value) => AutoRouter.of(context).replace(MyEventsRoute()));
  }

  void _onLoading(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const LoadingDialog(loadingText: "Creating account...")
    );
  }

  void _onError(BuildContext context, String error) {
    Navigator.of(context).pop();
    showStateDialog(context: context, isSuccess: false, text: error, closeOnConfirm: true);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = useMemoized<RegisterBloc>(() => BlocProvider.of(context));
    useEffect(() {
      bloc.emitRegisterFormState();
      return null;
    }, const []);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPassController = useTextEditingController();
    final usernameController = useTextEditingController();
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          _onRegisterSuccess(context);
        } else if (state is RegisterLoadingState) {
          _onLoading(context);
        } else if (state is RegisterErrorState) {
          _onError(context, state.error);
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        buildWhen: (previous, current) => current is RegisterFormState,
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
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      AppTextField(
                                        controller: usernameController,
                                        labelText: "Username",
                                        icon: const Icon(Icons.account_circle, size:35),
                                        inputAction: TextInputAction.next,
                                        errorText: (state as RegisterFormState).usernameError,
                                      ),
                                      const SizedBox(height: 30),
                                      AppTextField(
                                        controller: emailController,
                                        labelText: "E-mail",
                                        icon: const Icon(Icons.email_outlined, size:35),
                                        inputAction: TextInputAction.next,
                                        errorText: state.emailError,
                                      ),
                                      const SizedBox(height: 30),
                                      AppTextField(
                                        controller: passwordController,
                                        labelText: "Password",
                                        icon: const Icon(Icons.lock_outline, size:35),
                                        inputAction: TextInputAction.next,
                                        obscureText: true,
                                        errorText: state.passwordError,
                                      ),
                                      const SizedBox(height: 30),
                                      AppTextField(
                                        controller: confirmPassController,
                                        labelText: "Confirm password",
                                        icon: const Icon(Icons.lock_outline, size:35),
                                        inputAction: TextInputAction.next,
                                        obscureText: true,
                                        errorText: state.confirmPassError,
                                      ),
                                    ],
                                  ),
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
                  AppButton.gradient(child: const Text("Register"),
                      onPressed: () => _onRegister(
                          context,
                          usernameController.text,
                          emailController.text,
                          passwordController.text,
                          confirmPassController.text)
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
