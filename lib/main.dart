import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_made/core/theme/theme.dart';
import 'package:tailor_made/core/utils/show_snackbar.dart';
import 'package:tailor_made/features/client/presentation/bloc/client_bloc.dart';
import 'package:tailor_made/features/client/presentation/pages/splash_screen.dart';
import 'package:tailor_made/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
      providers: [BlocProvider(create: (_) => sl<ClientBloc>())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tailor Made',
      builder: (context, child) {
        return MultiBlocListener(
          listeners: [
            BlocListener<ClientBloc, ClientState>(
              listenWhen: (previous, current) => current is ClientFailure,
              listener: (context, state) {
                if (state is ClientFailure) {
                  showSnackBar(context: context, text: state.error, color: Colors.red);
                  context.read<ClientBloc>().add(ClientReset());
                }
              },
            )
          ],
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: const SplashScreen(),
    );
  }
}