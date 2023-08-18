import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_assets.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import '../../../models/patient/index_patient_model.dart';
import '../../patient_profile/patient_profile_screen.dart';
import '../../../widgets/component.dart';
import '../../../widgets/custome_image.dart';

class PatientsListViewItem extends StatelessWidget {
  final String? profImage;
  final IndexPatientModel model;

  const PatientsListViewItem(
    BuildContext? context, {
    super.key,
    this.profImage,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedManageCubit, MedManageStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: state is! IndexPatientListLoadingState,
            builder: (context) => model.patient.isNotEmpty
            ? Padding(
              padding: const EdgeInsets.all(5.0),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: 3.w,
                    end: 3.w,
                    top: 3.h,
                    bottom: 3.h,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      MedManageCubit.get(context).viewPatient(
                        user_id: model.patient[index].userId,
                      );
                      navigateTo(context, const PatientProfileScreen());
                    },
                    child: Material(
                      shadowColor: Colors.grey.shade50,
                      elevation: 5.0,
                      borderRadius: BorderRadiusDirectional.all(Radius.circular(10.r)),
                      color: Colors.white,
                      child: Container(
                        height: 60.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.all(Radius.circular(10.r)),
                          border: const Border.fromBorderSide(BorderSide.none),
                        ),
                        padding: EdgeInsetsDirectional.only(
                          start: 6.h,
                          end: 6.h,
                          top: 5.h,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional.center,
                          child: Column(
                            children: [
                              CustomeImage(
                                image: 'assets/images/undraw_Female_avatar_efig (1).png'/*AppAssets.defaultImage*/,
                                width: 190.w,
                                height: 160.h,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                              Container(
                                height: .6.h,
                                color: Colors.grey.shade500,
                              ),
                              SizedBox(
                                height: 8.w,
                              ),
                              Expanded(
                                child: Text(
                                  '${model.patient[index].user.firstName} ${model.patient[index].user.lastName}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.w,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              /*SizedBox(
                              height: 5.w,
                            ),*/
                              Expanded(
                                child: Text(
                                  model.patient[index].user.phoneNum,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12.w,
                                      fontWeight: FontWeight.bold
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.w,
                    mainAxisSpacing: 5.h,
                    childAspectRatio: 3/2,
                    mainAxisExtent: 230.h
                ),
                itemCount: model.patient.length,
              ),
            )
            /*ListView.separated(
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        MedManageCubit.get(context).viewPatient(
                          user_id: model.patient[index].userId,
                        );
                        navigateTo(context, const PatientProfileScreen());
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * .14,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadiusDirectional.all(
                              Radius.circular(10.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                            top: 15.0,
                            end: 8.0,
                            bottom: 15.0,
                          ),
                          child: Row(
                            children: [
                              CustomeImage(
                                image:
                                    'assets/images/undraw_Female_avatar_efig (1).png',
                                width: MediaQuery.of(context).size.height * .13,
                                height:
                                    MediaQuery.of(context).size.height * .13,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    top: 15.0,
                                    bottom: 0.0,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${model.patient[index].user.firstName} ${model.patient[index].user.lastName}',
                                          style: const TextStyle(
                                            color: defaultColor,
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          model.patient[index].user.phoneNum,
                                          style: TextStyle(
                                              color: Colors.grey[400],
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w400),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  MedManageCubit.get(context).deletePatient(
                                    user_id: model.patient[index].userId,
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: color5,
                                  size: 35.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => myDivider(),
                    itemCount: model.patient.length,
                  )*/
                : Container(
                    width: double.infinity,
                    padding: const EdgeInsetsDirectional.all(45.0),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'No patient to show',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
            fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }
}
