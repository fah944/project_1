import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/functions/custome_snack_bar.dart';
import '../../../core/utils/app_assets.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import '../../../models/secretaria/view_secretaria_model.dart';
import '../../secretaria_profile/secretaria_profile-screen.dart';
import '../../../styles/colors/colors.dart';
import '../../../widgets/add_image.dart';
import '../../../widgets/component.dart';
import '../../../widgets/edit_text_field.dart';

class EditSecretariaProfItem extends StatelessWidget {

  final ViewSecretariaModel model;
  final int index;
  var formKey = GlobalKey<FormState>();

  EditSecretariaProfItem({
    super.key,
    required this.model,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    var firstName = TextEditingController(text: model.secretary.user.firstName);
    var lastName = TextEditingController(text: model.secretary.user.lastName);
    var phoneNum = TextEditingController(text: model.secretary.user.phoneNum);
    var department = TextEditingController(text: model.department.name);
    return BlocProvider(
      create: (context) => MedManageCubit()..indexDepartment(),
      child: BlocConsumer<MedManageCubit,MedManageStates>(
        listener: (context, state)
        {
          if(state is SecretariaProfSuccssesState){
            navigateTo(context, SecretariaProfile(index: index,));
          }
          if(state is SecretariaProfEditSuccssesState){
            CustomeSnackBar.showSnackBar(
              context,
              msg: 'Update Succsses',
              color: Colors.green,
            );
          }
          if(state is SecretariaProfEditErrorState){
            CustomeSnackBar.showSnackBar(
              context,
              msg: 'Update Failed',
              color: Colors.red,
            );
            navigateAndReplacement(context, SecretariaProfile(index: index,));
          }
        },
        builder: (context, state)
        {
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
          }else if(state is IndexDepartmentListSuccssesState)
          {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                leadingWidth: 100.0,
                //shadowColor: Colors.grey.shade100,
                //elevation: 1.0,
                //backgroundColor: Colors.white,
                leading: TextButton(
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: (){
                    navigateAndReplacement(context, SecretariaProfile(index: index,));
                  },
                ),
                actions: [
                  TextButton(
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: (){
                      if(formKey.currentState!.validate()){
                        MedManageCubit.get(context).updateSecretaria(
                          first_name: firstName.text,
                          last_name: lastName.text,
                          department_name: department.text,
                          phone_num: phoneNum.text,
                          user_id: model.secretary.userId,
                        );
                        MedManageCubit.get(context).viewSecretaria(
                          user_id: model.secretary.userId,);
                      }
                    },
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsetsDirectional.only(
                    start: 25.0,
                    end: 25.0,
                    top: 20.0,
                    bottom: 10.0,
                  ),
                  width: double.infinity,
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AddImage(
                          image: AppAssets.sec,
                          width: MediaQuery.of(context).size.height * .2,
                          height: MediaQuery.of(context).size.height * .2,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .05,
                        ),
                        EditTextField(
                          hintText: 'First Name...',
                          controller: firstName,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.sentences,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .05,
                        ),
                        EditTextField(
                          hintText: 'Last Name...',
                          controller: lastName,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.sentences,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .05,
                        ),
                        EditTextField(
                          hintText: 'Phone Number...',
                          controller: phoneNum,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .05,
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
                          child: EditTextField(
                            hintText: 'Department...',
                            controller: department,
                            keyboardType: TextInputType.text,
                            enabled: false,
                            suffixIcon: Icons.expand_more_sharp,
                            suffixSize: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }else{
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }
}
