import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/routes/app_router.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'data/datasources/auth_remote_data_source.dart';
import 'data/datasources/stream_remote_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/stream_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/stream_repository.dart';
import 'domain/usecases/get_streams_usecase.dart';
import 'domain/usecases/sign_in_with_google_usecase.dart';
import 'domain/usecases/sign_out_usecase.dart';
import 'firebase_options.dart';
import 'presentation/home/viewmodel/home_viewmodel.dart';
import 'presentation/auth/viewmodel/login_viewmodel.dart';
import 'presentation/profile/viewmodel/profile_viewmodel.dart';
import 'presentation/splash/viewmodel/splash_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const AliveApp());
}

class AliveApp extends StatelessWidget {
  const AliveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(
          create: (_) => AuthRepositoryImpl(AuthRemoteDataSource()),
        ),
        Provider<StreamRepository>(
          create: (_) => StreamRepositoryImpl(StreamRemoteDataSource()),
        ),
        Provider<SignInWithGoogleUseCase>(
          create: (context) => SignInWithGoogleUseCase(context.read<AuthRepository>()),
        ),
        Provider<SignOutUseCase>(
          create: (context) => SignOutUseCase(context.read<AuthRepository>()),
        ),
        Provider<GetStreamsUseCase>(
          create: (context) => GetStreamsUseCase(context.read<StreamRepository>()),
        ),
        ChangeNotifierProvider<SplashViewModel>(
          create: (context) => SplashViewModel(context.read<AuthRepository>()),
        ),
        ChangeNotifierProvider<LoginViewModel>(
          create: (context) => LoginViewModel(context.read<SignInWithGoogleUseCase>()),
        ),
        ChangeNotifierProvider<HomeViewModel>(
          create: (context) => HomeViewModel(context.read<GetStreamsUseCase>()),
        ),
        ChangeNotifierProvider<ProfileViewModel>(
          create: (context) => ProfileViewModel(context.read<AuthRepository>(), context.read<SignOutUseCase>()),
        ),
      ],
      child: MaterialApp(
        title: 'Alive',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
