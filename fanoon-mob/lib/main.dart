import 'dart:developer';

import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funoon/app/routes/routes.dart';
import 'package:funoon/app/theme/themeManager.dart';
import 'package:funoon/app/utils/styles.dart';
import 'package:funoon/features/Authentication/data/repositories/auth_repository_impl.dart';
import 'package:funoon/features/Authentication/data/datasources/API/auth_api.dart';

import 'package:funoon/features/Authentication/domain/usecases/signup_auth.dart';
import 'package:funoon/features/Authentication/presentation/bloc/log_in_form_bloc.dart';
import 'package:funoon/features/feed/data/datasources/API/feed_api.dart';
import 'package:funoon/features/feed/data/repositories/feed_repository_impl.dart';
import 'package:funoon/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:funoon/features/profile/data/datasources/API/profile_api.dart';
import 'package:funoon/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:funoon/features/profile/domain/usecases/create_post.dart';
import 'package:funoon/features/profile/presentation/bloc/upload_post_page_bloc.dart';
import 'package:funoon/presentation/Onboarding/pages/onboarding_page.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'app/widgets/custom_bottom_navigation_bar.dart';
import 'features/Authentication/domain/usecases/login_auth.dart';
import 'features/Authentication/presentation/bloc/authentication_bloc.dart';
import 'features/Authentication/presentation/bloc/signupform_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));

  //to show onboarding screen once
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? true;

  HydratedBlocOverrides.runZoned(
    () => runApp(
      App(
        showHome: showHome,
        authRepository:
            AuthRepositoryImplementation(authAPIImpl: AuthAPIImpl()),
        feedRepository: FeedRepositoryImpl(FeedApiImpl()),
        profileRepository: ProfileRepositoryImpl(
          profileApi: ProfileApiImpl(),
        ),
      ),
    ),
    storage: storage,
  );
}

class MyApp extends StatefulWidget {
  final bool showOnboarding;

  const MyApp({Key? key, required this.showOnboarding}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        //
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return ChangeNotifierProvider(
            create: (_) {
              return themeChangeProvider;
            },
            child: Consumer<DarkThemeProvider>(
                builder: (BuildContext context, value, _) {
              return MaterialApp(
                navigatorKey: AppNavigator.navigatorKey,
                debugShowCheckedModeBanner: false,
                theme: Styles.themeData(themeChangeProvider.darkTheme, context),

                //--------Flow Builder Package--------------------------------------------
                // FlowBuilder is a widget which builds a navigation stack in response to
                //changes in the flow state. onGeneratePages will be invoked for each
                //state change and must return the new navigation stack as a list of pages
                //------------------------------------------------------------------------
                // onGenerateRoute callback is used when the app is navigated to a named route.
                onGenerateRoute: AppNavigator.onGenerateRoute,
                home: widget.showOnboarding
                    ? 
                    const DockingScreen()
                    : const CustomBottomNavigationBar(),
              );
            }),
          );
        });
  }
}

class App extends StatelessWidget {
  final bool showHome;
  final AuthRepositoryImplementation authRepository;
  final FeedRepositoryImpl feedRepository;
  final ProfileRepositoryImpl profileRepository;
  const App({
    Key? key,
    required this.showHome,
    required this.authRepository,
    required this.feedRepository,
    required this.profileRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepository),
        RepositoryProvider.value(value: feedRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => LogInFormBloc(
              loginUsecase: Login(authRepository),
            ),
          ),
          BlocProvider(
            create: (_) => AuthenticationBloc(
              authenticationRepository: authRepository,
            ),
          ),
          BlocProvider(
            create: (_) => SignupFormBloc(
              signupUsecase: SignUp(authRepository),
            ),
          ),
          BlocProvider(
            create: (_) => FeedBloc(
              feedRepository,
            ),
          ),
          BlocProvider(
            create: (_) => UploadPostPageBloc(
              createPostUsecase: CreatePostUsecase(profileRepository),
            ),
          ),
        ],
        child: MyApp(showOnboarding: showHome),
      ),
    );
  }
}
