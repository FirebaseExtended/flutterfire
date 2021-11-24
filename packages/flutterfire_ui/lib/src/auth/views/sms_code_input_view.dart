import 'package:flutterfire_ui/i10n.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';

typedef SMSCodeSubmitCallback = void Function(String smsCode);

class SMSCodeInputView extends StatefulWidget {
  final FirebaseAuth? auth;
  final AuthAction? action;
  final Object flowKey;
  final VoidCallback? onCodeVerified;
  final SMSCodeSubmitCallback? onSubmit;

  const SMSCodeInputView({
    Key? key,
    required this.flowKey,
    this.onCodeVerified,
    this.auth,
    this.action,
    this.onSubmit,
  }) : super(key: key);

  @override
  State<SMSCodeInputView> createState() => _SMSCodeInputViewState();
}

class _SMSCodeInputViewState extends State<SMSCodeInputView> {
  final columnKey = GlobalKey();
  final key = GlobalKey<SMSCodeInputState>();

  void submit(String code, PhoneAuthController ctrl) {
    if (widget.onSubmit != null) {
      widget.onSubmit!(code);
    } else {
      ctrl.verifySMSCode(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = FirebaseUILocalizations.labelsOf(context);

    return AuthFlowBuilder<PhoneAuthController>(
      auth: widget.auth,
      action: widget.action,
      flowKey: widget.flowKey,
      listener: (oldState, newState, controller) {
        if (newState is SignedIn || newState is CredentialLinked) {
          widget.onCodeVerified?.call();
        }
      },
      builder: (context, state, ctrl, child) {
        return IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            key: key,
            children: [
              SMSCodeInput(
                key: key,
                onSubmit: (smsCode) {
                  submit(smsCode, ctrl);
                },
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8),
                child: OutlinedButton(
                  onPressed: () {
                    final code = key.currentState!.code;
                    if (code.length < 6) return;
                    submit(code, ctrl);
                  },
                  child: Text(l.verifyCodeButtonText),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
