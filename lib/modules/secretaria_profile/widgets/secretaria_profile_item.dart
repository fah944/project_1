import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_manage_app/core/utils/app_assets.dart';

import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import '../../../layout/med_manage_layout.dart';
import '../../../models/secretaria/view_secretaria_model.dart';
import '../../edit_secretaria_prof/edit_secretaria_prof_screen.dart';
import '../../../widgets/component.dart';
import '../../../widgets/custome_image.dart';
import '../../../widgets/default_text_info.dart';

class SecretariaProfileItem extends StatelessWidget {

  final ViewSecretariaModel model;
  final int index;

  const SecretariaProfileItem({
    super.key,
    required this.model,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedManageCubit,MedManageStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        MedManageCubit cubit = MedManageCubit.get(context);
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              navigateTo(context, EditSecretariaProfScreen(index: index, model: model));
            },
            child: const Icon(
              Icons.edit,
              size: 40,
              color: Colors.white,
            ),
          ),
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ),
              onPressed: (){
                cubit.indexSecretariaList();
                Navigator.pop(context);
              },
            ),
            title: Text(
              model.secretary.user.firstName,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomeImage(
                  borderRadius: BorderRadius.circular(50.h),
                  height: 100.h,
                  width: 100.h,
                  image: AppAssets.defaultImagePurple,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.035,
                ),
                Text(
                  '${model.secretary.user.firstName} ${model.secretary.user.lastName}',
                  style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 16.h,
                      fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                GestureDetector(
                  onTap: (){
                    cubit.deleteSecretaria(
                      user_id: model.secretary.userId,
                    );
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 160.w,
                    height: 46.h,
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.02),
                      borderRadius: BorderRadiusDirectional.all(Radius.circular(10.r)),
                      border: Border.all(width: 1,color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Delete Account',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.w,
                          ),
                        ),
                        const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                DefaultTextInfo(
                  caption: 'Email: ',
                  text: model.secretary.user.email,
                  icon: Icons.mail,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                DefaultTextInfo(
                  caption: 'Phone number: ',
                  text: model.secretary.user.phoneNum,
                  icon: Icons.call,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                DefaultTextInfo(
                  caption: 'Department name: ',
                  text: model.department.name,
                  icon: Icons.business_sharp,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}