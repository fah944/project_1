
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:med_manage_app/constant.dart';
import 'package:med_manage_app/cubit/cubit.dart';
import 'package:med_manage_app/cubit/states.dart';
import 'package:med_manage_app/models/department/index_department_model.dart';
import 'package:med_manage_app/modules/department/add_department_screen.dart';
import 'package:med_manage_app/styles/colors/colors.dart';
import '../../widgets/component.dart';
import 'edit_department_screen.dart';

class DepartmentScreen extends StatelessWidget {


  const DepartmentScreen({super.key,
   });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedManageCubit, MedManageStates>(
      builder: (context, state) {
        MedManageCubit cubit = MedManageCubit.get(context);
        if (state is MedManageErrorHomeDepDataState) {
          return const Center(
            child: Text('Error Occurred '),
          );
        }
        if (state is MedManageLoadHomeDepDataState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if(cubit.departmentHomeModel.Department!.isEmpty)
          {
            return  const Center(
              child: Text(
                'Please add a department',
              ),
            );

          }
          else{
            return  ConditionalBuilder(
                condition: state is! MedManageLoadHomeDepDataState,
                builder: (context) =>
                    departmentBuilder(cubit.departmentHomeModel, context),
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));

          }

        }
      },
      listener: (context, state) {},
    );
  }
}

Widget departmentBuilder(DepartmentHomeModel model, BuildContext context) =>
    SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.all(3.7),
        color: Colors.grey[300],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.count(
                clipBehavior: Clip.none,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 3.7,
                crossAxisSpacing: 3.7,
                childAspectRatio: 1 / 1.70,
                children: List.generate(
                    model.Department!.length,
                        (index) => buildGridDepartment(
                        model.Department![index], context, index))),
          ],
        ),
      ),
    );

Widget buildGridDepartment(
    DepartmentModel model, BuildContext context, int index) =>
    Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            //mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              IconButton(
                onPressed: () {
                  navigateTo(
                      context,
                      EditDepartmentScreen(
                        model: MedManageCubit.get(context).departmentHomeModel,
                        index: index,
                        //MedManageCubit.get(context).updateDepartmentModel;
                      ));
                },
                icon: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 14.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Image(
            image: //AssetImage('assets/images/undraw_Female_avatar_efig (1).png'),
            NetworkImage('http://$ipAddress:8000/upload/${model.img}',
                scale: 10.0),
            width: double.infinity,
            height: 170.0,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                model.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: defaultColor, fontSize: 14.0, height: 1,fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      DateFormat.yMMMd()
                          .format(DateTime.parse((model.created_at))),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        MedManageCubit.get(context)
                            .deleteDepartment(id: model.id);
                      },
                      icon: const Icon(
                        Icons.delete,
                        size: 18.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
