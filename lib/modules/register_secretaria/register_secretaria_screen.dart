import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/functions/custome_snack_bar.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../layout/med_manage_layout.dart';
import '../../styles/colors/colors.dart';
import '../../widgets/add_image.dart';
import '../../widgets/component.dart';
import '../../widgets/custome_button.dart';
import '../../widgets/edit_text_field.dart';
import '../../widgets/register_text_field.dart';

class RegisterSecretaria extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var phoneNum = TextEditingController();
  var email = TextEditingController();
  var pass = TextEditingController();
  var department = TextEditingController();

  RegisterSecretaria({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MedManageCubit()..indexDepartment(),
      child: BlocConsumer<MedManageCubit,MedManageStates>(
        listener: (context, state) {
          if(state is SecretariaRegisterSuccssesState)
          {
            CustomeSnackBar.showSnackBar(
              context,
              msg: 'Register Succsses',
              color: Colors.green,
            );
            Navigator.pop(context);
          }
          if(state is SecretariaRegisterErrorState){
            CustomeSnackBar.showSnackBar(
              context,
              msg: 'Register Failed',
              color: Colors.red,
            );
            Navigator.pop(context);          }
        },
        builder: (context, state) {
          MedManageCubit cubit = MedManageCubit.get(context);
          if(state is IndexDepartmentListErrorState)
          {
            return const Scaffold(
              body: Center(
                child: Text(
                  'There is some thing error',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            );
          }else if(state is IndexDepartmentListLoadingState)
          {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }else
          {
            return Scaffold(
              backgroundColor: Colors.white,
              body: ConditionalBuilder(
                  condition: state is! SecretariaRegisterLoadingState,
                  builder: (context) => Padding(
                    padding: const EdgeInsetsDirectional.all(10.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(top: 10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AddImage(
                                image: 'assets/images/undraw_Male_avatar_g98d (1).png',
                                width: MediaQuery.of(context).size.height * .2,
                                height: MediaQuery.of(context).size.height * .2,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * .03,
                              ),
                              RegisterTextField(
                                hintText: 'First Name...',
                                icon: Icons.person,
                                controller: firstName,
                                keyboardType: TextInputType.text,
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * .03,
                              ),
                              RegisterTextField(
                                hintText: 'Last Name...',
                                icon: Icons.person,
                                controller: lastName,
                                keyboardType: TextInputType.name,
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * .03,
                              ),
                              RegisterTextField(
                                hintText: 'Phone Number...',
                                icon: Icons.phone,
                                controller: phoneNum,
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * .03,
                              ),
                              RegisterTextField(
                                hintText: 'Email...',
                                icon: Icons.mail,
                                controller: email,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * .03,
                              ),
                              RegisterTextField(
                                hintText: 'Password...',
                                icon: Icons.lock,
                                controller: pass,
                                keyboardType: TextInputType.visiblePassword,
                                validator: (value) {
                                  if (value!.length < 6) {
                                    return 'the password must be at least 6 characters';
                                  }
                                  return null;
                                },
                                obscureText: MedManageCubit.get(context).isPassShow,
                                suffixIcon: MedManageCubit.get(context).suffixIcon,
                                onPressed: (){
                                  MedManageCubit.get(context).changePassVisibility();
                                },
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * .03,
                              ),
                              GestureDetector(
                                onTap: (){
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SimpleDialog(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.all(Radius.circular(10.r))),
                                          children: [
                                            Container(
                                              width: 260.w,
                                              height: 280.h,
                                              padding: EdgeInsetsDirectional.all(15.h),
                                              child: ListView.separated(
                                                //shrinkWrap: true,
                                                itemBuilder: (context, index) => SimpleDialogOption(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    department.text = cubit.indexDepartmentModel.department[index].name;
                                                  },
                                                  child: Text(
                                                    cubit.indexDepartmentModel.department[index].name,
                                                    style: TextStyle(
                                                      color: defaultColor,
                                                      fontSize: 20.w,
                                                      fontWeight: FontWeight.w500
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                separatorBuilder: (context, index) => SizedBox(
                                                  height: 1,
                                                  child: Container(
                                                    color: Colors.grey.shade400,
                                                  ),
                                                ),
                                                itemCount: cubit.indexDepartmentModel.department.length,
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                  );
                                },
                                child: RegisterTextField(
                                  hintText: 'Department...',
                                  icon: Icons.business_rounded,
                                  controller: department,
                                  keyboardType: TextInputType.text,
                                  enabled: false,
                                  suffixIcon: Icons.expand_more_sharp,
                                  suffixSize: 40,
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * .05,
                              ),
                              CustomeButton(
                                text: 'Next',
                                onPressed: (){
                                  if(formKey.currentState!.validate()){
                                    MedManageCubit.get(context).registerSecretaria(
                                      first_name: firstName.text,
                                      last_name: lastName.text,
                                      phone_num: phoneNum.text,
                                      email: email.text,
                                      password: pass.text,
                                      department_name: department.text,
                                    );
                                    //MedManageCubit.get(context).indexSecretariaList();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  fallback: (context) => const Center(child: CircularProgressIndicator())
              ),
            );
          }
        },
      ),
    );
  }
}


