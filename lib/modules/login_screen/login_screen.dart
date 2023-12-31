import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manage_app/layout/med_manage_layout.dart';
import '../../core/api/services/local/cache_helper.dart';
import '../../core/styles/colors/colors.dart';
import '../../core/styles/text_styles.dart';
import '../../core/utils/app_assets.dart';
import '../../core/widgets/custome_button.dart';
import '../../core/widgets/custome_error_widget.dart';
import '../../core/widgets/custome_image.dart';
import '../../core/widgets/custome_progress_indicator.dart';
import '../../core/widgets/custome_text_field.dart';
import '../../main.dart';
import 'manager/login_cubit.dart';
import 'manager/login_states.dart';

class LoginView extends StatelessWidget {
  static const route = 'LoginView';
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: const Scaffold(
            body: LoginViewBody(),
          ),
        ),
      ),
    );
  }
}

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginStates>(
      builder: (context, state) {
        if (state is LoginLoading) {
          return const CustomeProgressIndicator();
        } else if (state is LoginFailure) {
          return CustomeErrorWidget(errorMsg: state.failureMsg);
        } else if (state is LoginSuccess) {
          CacheHelper.saveData(key: 'Token', value: state.loginModel.token);
          return const MedManageLayout();
        } else {
          return _body(context);
        }
      },
    );
  }

  Widget _body(context) {
    LoginCubit loginCubit = BlocProvider.of<LoginCubit>(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: screenSize.width),
            CustomeImage(
              image: AppAssets.adminImage,
              fit: BoxFit.contain,
              width: screenSize.width * .9,
              height: screenSize.height * .3,
              color: Colors.transparent,
            ),
            SizedBox(height: screenSize.height * .02),
            Text(
              'Login',
              style: TextStyles.textStyle50,
            ),
            SizedBox(height: screenSize.height * .02),
            Text(
              'Please Enter Your Credentials To Get Started ...',
              style: TextStyles.textStyle18,
              maxLines: 2,
            ),
            SizedBox(height: screenSize.height * .06),
            CustomeTextField(
              keyboardType: TextInputType.emailAddress,
              hintText: ' Email ...',
              onChanged: (value) => loginCubit.email = value,
            ),
            SizedBox(height: screenSize.height * .04),
            CustomeTextField(
              iconData: Icons.lock,
              hintText: ' Password ...',
              obscureText: loginCubit.obscureText,
              onChanged: (value) => loginCubit.password = value,
              suffixIcon: IconButton(
                onPressed: () {
                  loginCubit.changePasswordState();
                },
                icon: Icon(
                  loginCubit.icon,
                  color: defaultColor2,
                ),
              ),
            ),
            SizedBox(height: screenSize.height * .15),
            Center(
              child: CustomeButton(
                text: 'Login',
                onPressed: () {
                  loginCubit.login();
                },
              ),
            ),
            SizedBox(height: screenSize.height * .04),
          ],
        ),
      ),
    );
  }
}
