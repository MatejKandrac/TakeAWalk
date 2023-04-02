
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:take_a_walk_app/config/constants.dart';
import 'package:take_a_walk_app/config/router/router.dart';
import 'package:take_a_walk_app/di.dart';
import 'package:take_a_walk_app/ui/bloc/splash/splash_bloc.dart';

@RoutePage()
class SplashPage extends HookWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = useMemoized(() => di<SplashBloc>());
    useEffect(() {
      bloc.checkLoggedIn();
    }, const []);
    return BlocProvider<SplashBloc>(
      create: (context) => bloc,
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state.continueMain) {
            AutoRouter.of(context).replace(const MyEventsRoute());
          }
          if (state.continueLogIn) {
            AutoRouter.of(context).replace(const LoginRoute());
          }
        },
        child: BlocBuilder<SplashBloc, SplashState>(
          builder: (context, state) => Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Container()),
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Image.asset(AppAssets.logoWhite),
                  ),
                  Image.asset(AppAssets.splashText),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(height: 10),
                          Text(
                              state.loadingText,
                              style: Theme.of(context).textTheme.bodyMedium
                          )
                        ],
                      ),
                    ),
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
