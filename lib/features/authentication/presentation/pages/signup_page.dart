import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:samsidh_task/core/constants/auth_constants.dart';
import 'package:samsidh_task/core/theme/app_theme.dart';
import 'package:samsidh_task/features/authentication/presentation/pages/login_page.dart';
import 'package:samsidh_task/features/authentication/presentation/provider/auth_provider.dart';
import 'package:samsidh_task/features/authentication/presentation/widgets/button_widget.dart';
import 'package:samsidh_task/features/authentication/presentation/widgets/text_widget.dart';
import 'package:samsidh_task/features/authentication/presentation/widgets/textfield_widget.dart';

class SingUpPage extends ConsumerWidget {
  static const routePath = '/signUp';
  const SingUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppTheme.of(context).colors;
    final space = AppTheme.of(context).spaces;
    final data = ref.watch(authConstansProvider);
    final emailController =
        ref.read(authenticationProvider(context).notifier).emailController;
    final passwordController =
        ref.read(authenticationProvider(context).notifier).passwordController;

    return Scaffold(
      backgroundColor: colors.primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: space.space_100 * 13,
            ),
            TextWidget(text: data.txtCreate),
            SizedBox(
              height: space.space_700,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: space.space_200,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: colors.secondary,
                  borderRadius: BorderRadius.circular(
                    space.space_200,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: space.space_300),
                    TextWidget(text: data.txtSignUp),
                    SizedBox(height: space.space_300),
                    TextFieldWidget(
                      labelText: data.txtEmail,
                      iconData: const Icon(Icons.email),
                      controller: emailController,
                    ),
                    TextFieldWidget(
                      labelText: data.txtPass,
                      iconData: const Icon(Icons.lock),
                      controller: passwordController,
                    ),
                    SizedBox(height: space.space_300),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: space.space_400),
                        child: ButtonWidget(
                          buttonText: data.txtSignUp,
                          onPressed: () {
                            ref
                                .read(authenticationProvider(context).notifier)
                                .signup(emailController.text,
                                    passwordController.text);
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: space.space_400),
                  ],
                ),
              ),
            ),
            SizedBox(height: space.space_300),
            Text(
              data.txtContinue,
              style: TextStyle(
                color: colors.textInverse,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: colors.secondary,
                  borderRadius: BorderRadius.circular(space.space_100)),
              child: InkWell(
                onTap: () {
                  ref
                      .read(authenticationProvider(context).notifier)
                      .googleSignIn();
                },
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: space.space_100),
                      child: SizedBox(
                        width: space.space_100 * 10,
                        height: space.space_700,
                        child: Image.asset(
                          data.txtGoogleImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      data.txtGoogle,
                      style: TextStyle(
                        color: colors.text,
                        fontSize: space.space_200,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: space.space_300),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data.txtAlready,
                  style: TextStyle(
                    color: colors.textInverse,
                    fontSize: space.space_200,
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.push(LoginPage.routePath);
                  },
                  child: Text(
                    data.txtLogin,
                    style: TextStyle(
                      color: colors.text,
                      fontSize: space.space_200,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
