import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutterfire_ui/auth.dart';

import '../configs/provider_configuration.dart';
import '../auth_state.dart';

import 'internal/login_screen.dart';
import 'internal/responsive_page.dart';

/// A screen displaying a fully styled Sign In flow for Authentication.
///
/// {@subCategory service:auth}
/// {@subCategory type:screen}
/// {@subCategory description:A screen displaying a fully styled Sign In flow for Authentication.}
/// {@subCategory img:https://place-hold.it/400x150}
class SignInScreen extends StatelessWidget {
  final FirebaseAuth? auth;
  final List<ProviderConfiguration> providerConfigs;
  final double? headerMaxExtent;
  final HeaderBuilder? headerBuilder;
  final SideBuilder? sideBuilder;
  final ButtonVariant? oauthButtonVariant;
  final TextDirection? desktopLayoutDirection;
  final String? email;
  final bool? showAuthActionSwitch;
  final AuthViewContentBuilder? subtitleBuilder;
  final AuthViewContentBuilder? footerBuilder;
  final Key? loginViewKey;

  const SignInScreen({
    Key? key,
    required this.providerConfigs,
    this.auth,
    this.headerMaxExtent,
    this.headerBuilder,
    this.sideBuilder,
    this.oauthButtonVariant = ButtonVariant.icon_and_text,
    this.desktopLayoutDirection,
    this.showAuthActionSwitch,
    this.email,
    this.subtitleBuilder,
    this.footerBuilder,
    this.loginViewKey,
  }) : super(key: key);

  Future<void> _signInWithDifferentProvider(
    BuildContext context,
    DifferentSignInMethodsFound state,
    AuthController controller,
  ) async {
    await showDifferentMethodSignInDialog(
      availableProviders: state.methods,
      providerConfigs: providerConfigs,
      context: context,
      auth: auth,
      onSignedIn: () {
        Navigator.of(context).pop();
      },
    );

    await controller.link(state.credential!);
  }

  @override
  Widget build(BuildContext context) {
    return AuthStateListener<OAuthController>(
      listener: (oldState, newState, controller) {
        if (newState is DifferentSignInMethodsFound) {
          _signInWithDifferentProvider(context, newState, controller);
        }
      },
      child: LoginScreen(
        loginViewKey: loginViewKey,
        action: AuthAction.signIn,
        providerConfigs: providerConfigs,
        auth: auth,
        headerMaxExtent: headerMaxExtent,
        headerBuilder: headerBuilder,
        sideBuilder: sideBuilder,
        desktopLayoutDirection: desktopLayoutDirection,
        oauthButtonVariant: oauthButtonVariant,
        email: email,
        showAuthActionSwitch: showAuthActionSwitch,
        subtitleBuilder: subtitleBuilder,
        footerBuilder: footerBuilder,
      ),
    );
  }
}
