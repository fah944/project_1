import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/app_assets.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import '../../../layout/med_manage_layout.dart';
import '../../../models/patient/view_patient_model.dart';

import '../../../widgets/component.dart';
import '../../../widgets/custome_image.dart';
import '../../../widgets/default_text_info.dart';

class PatientProfileItem extends StatelessWidget {
  final ViewPatientModel? model;
  final int? index;
  final String? profImage;

  const PatientProfileItem({
    super.key,
    required this.model,
    this.index,
    this.profImage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedManageCubit, MedManageStates>(
      listener: (context, state) {},
      builder: (context, state) {
        MedManageCubit cubit = MedManageCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ),
              onPressed: () {
                cubit.indexPatientsList();
                navigateAndReplacement(context, const MedManageLayout());
              },
            ),
            title: Text(
              model!.patient.user.firstName,
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
                  image: profImage!,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.035,
                ),
                Text(
                  '${model!.patient.user.firstName} ${model!.patient.user.lastName}',
                  style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 16.h,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                GestureDetector(
                  onTap: () {
                    cubit.deleteSecretaria(
                      user_id: model!.patient.userId,
                    );
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 160.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.02),
                      borderRadius:
                          BorderRadiusDirectional.all(Radius.circular(10.r)),
                      border: Border.all(width: 1, color: Colors.grey.shade200),
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
                  caption: 'Address: ',
                  text: model!.patient.address,
                  icon: Icons.location_on,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                DefaultTextInfo(
                  caption: 'Email: ',
                  text: model!.patient.user.email,
                  icon: Icons.mail,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                DefaultTextInfo(
                  caption: 'Phone number: ',
                  text: model!.patient.user.phoneNum,
                  icon: Icons.call,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                DefaultTextInfo(
                  caption: 'Date of birth: ',
                  text: model!.patient.birthDate,
                  icon: Icons.cake,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                DefaultTextInfo(
                  caption: 'Gender: ',
                  text: model!.patient.gender,
                  icon: CupertinoIcons.person_2_fill,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
