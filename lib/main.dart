import 'package:poggit_ci/app/auth_widget.dart';
import 'package:poggit_ci/app/auth_widget_builder.dart';
import 'package:poggit_ci/app/email_link_error_presenter.dart';
import 'package:poggit_ci/services/apple_sign_in_available.dart';
import 'package:poggit_ci/services/auth_service.dart';
import 'package:poggit_ci/services/auth_service_adapter.dart';
import 'package:poggit_ci/services/email_secure_store.dart';
import 'package:poggit_ci/services/firebase_email_link_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final appleSignInAvailable = await AppleSignInAvailable.check();
  runApp(MyApp(appleSignInAvailable: appleSignInAvailable));
}

class MyApp extends StatelessWidget {
  const MyApp(
      {Key? key,
      required this.appleSignInAvailable,
      this.initialAuthServiceType = AuthServiceType.firebase})
      : super(key: key);
  final AppleSignInAvailable appleSignInAvailable;

  final AuthServiceType initialAuthServiceType;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppleSignInAvailable>.value(value: appleSignInAvailable),
        Provider<AuthService>(
          create: (_) => AuthServiceAdapter(
              initialAuthServiceType: initialAuthServiceType),
          dispose: (_, AuthService authService) => authService.dispose(),
        ),
        Provider<EmailSecureStore>(
          create: (_) => EmailSecureStore(
            flutterSecureStorage: FlutterSecureStorage(),
          ),
        ),
        ProxyProvider2(
          update: (_, AuthService authService, EmailSecureStore storage, __) =>
              FirebaseEmailLinkHandler(
            auth: authService,
            emailStore: storage,
            firebaseDynamicLinks: FirebaseDynamicLinks.instance,
          )..init(),
          dispose: (_, FirebaseEmailLinkHandler linkHandler) =>
              linkHandler.dispose(),
        ),
      ],
      child: AuthWidgetBuilder(
        builder: (BuildContext context, AsyncSnapshot<MyAppUser> userSnapshot) {
          return MaterialApp(
            theme: ThemeData(primarySwatch: Colors.amber),
            home: EmailLinkErrorPresenter.create(
              context,
              child: AuthWidget(userSnapshot: userSnapshot),
            ),
          );
        },
      ),
    );
  }
}
