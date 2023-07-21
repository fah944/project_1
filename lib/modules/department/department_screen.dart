import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:med_manage_app/cubit/cubit.dart';
import 'package:med_manage_app/cubit/states.dart';
import 'package:med_manage_app/models/department/index_department_model.dart';
import 'package:med_manage_app/styles/colors/colors.dart';

class DepartmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedManageCubit, MedManageStates>(
      builder: (context, state) {
        MedManageCubit cubit = MedManageCubit.get(context);

        return ConditionalBuilder(
            condition: state is! MedManageLoadHomeDepDataState,
            builder: (context) => departmentBuilder(cubit.departmentHomeModel),
            fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));
      },
      listener: (context, state) {},
    );
  }
}

Widget departmentBuilder(DepartmentHomeModel model) => SingleChildScrollView(
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
                children: List.generate(model.Department!.length,
                    (index) => buildGridDepartment(model.Department![index]))),
          ],
        ),
      ),
    );

Widget buildGridDepartment(DepartmentModel model) => Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 12.0,
                ),
              ),
            ],
          ),
          Image(
            image:
                AssetImage('assets/images/undraw_Female_avatar_efig (1).png'),
            //image: NetworkImage(model.img),
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
                // 'Department name',
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: defaultColor, fontSize: 12.0, height: 1),
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
                      //'date of create',
                      '${DateFormat.yMMMd().format(DateTime.parse((model.created_at)))}',
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
                      },
                      icon: const Icon(
                        Icons.delete,
                        size: 18.0,
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
