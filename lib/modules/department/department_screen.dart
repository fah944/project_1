import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:med_manage_app/cubit/cubit.dart';
import 'package:med_manage_app/cubit/states.dart';
import 'package:med_manage_app/models/department/index_department_model.dart';
import 'package:med_manage_app/modules/department/add_department_screen.dart';
import 'package:med_manage_app/styles/colors/colors.dart';

import '../../widgets/component.dart';
import 'edit_department_screen.dart';

class DepartmentScreen extends StatelessWidget {
  /*var formKey = GlobalKey<FormState>();
  var alignKey = GlobalKey<ScaffoldState>();
  var nameController = TextEditingController();
*/
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedManageCubit, MedManageStates>(
      builder: (context, state) {
        MedManageCubit cubit = MedManageCubit.get(context);
        return Align(
          //key: alignKey,
          child: Stack(
            children: [
              ConditionalBuilder(
                  condition: state is! MedManageLoadHomeDepDataState,
                  builder: (context) => departmentBuilder(cubit.departmentHomeModel, context),
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 300, top: 450),
                child: CircleAvatar(
                  backgroundColor: color5,
                  radius: 22.0,
                  child: IconButton(
                    onPressed: () {
                      // int index;
                      navigateTo(context, AddDepartmentScreen());

                      /* showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context)
                          {
                            return Container(
                              padding:const EdgeInsets.all(25.0),
                              height: 500,
                              color: Colors.white,
                              child: Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    Align(
                                      child: Stack(
                                        alignment: AlignmentDirectional.topEnd,
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                'assets/images/undraw_Female_avatar_efig (1).png'),
                                            // image: departmentImage == null ? AssetImage('assets/images/undraw_About_me_re_82bv (1).png'): FileImage(departmentImage!),

                                            // image: departmentImage == null ? FileImage(departmentImage!) as ImageProvider : AssetImage('assets/images/undraw_Female_avatar_efig (1).png'),
                                            width: double.infinity,
                                            height: 170.0,
                                            fit: BoxFit.contain,
                                          ),
                                          CircleAvatar(
                                            backgroundColor: defaultColor,
                                            radius: 18.0,
                                            child: IconButton(
                                              onPressed: () {
                                                MedManageCubit.get(context)
                                                    .getImage();
                                              },
                                              icon: const Icon(
                                                Icons.camera_alt,
                                                color: Colors.white,
                                                size: 20.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      cursorColor: defaultColor,
                                      controller: nameController,
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                        hintText: 'name of department',
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: defaultColor,
                                          ),
                                        ),
                                        hintStyle: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      onFieldSubmitted: (String value) {},
                                      onChanged: (String value) {
                                        print(value);
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'name mustn\'t be empty';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });*/


                      /*  if (cubit.isBottomSheetShown)
                      {

                        //cubit.addDepartment(
                          //name: nameController.text,
                          //img:
                        //);
                      //  cubit.getHomeDepData();
                        cubit.isBottomSheetShown = false;
                      }else
                      {
                        alignKey.currentState!.showBottomSheet(
                          (context) => Container(
                              padding: const EdgeInsets.all(20.0),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Align(
                                      child: Stack(
                                        alignment: AlignmentDirectional.topEnd,
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                'assets/images/undraw_Female_avatar_efig (1).png'),
                                            // image: departmentImage == null ? AssetImage('assets/images/undraw_About_me_re_82bv (1).png'): FileImage(departmentImage!),

                                            // image: departmentImage == null ? FileImage(departmentImage!) as ImageProvider : AssetImage('assets/images/undraw_Female_avatar_efig (1).png'),
                                            width: double.infinity,
                                            height: 170.0,
                                            fit: BoxFit.contain,
                                          ),
                                          CircleAvatar(
                                            backgroundColor: defaultColor,
                                            radius: 18.0,
                                            child: IconButton(
                                              onPressed: () {
                                                MedManageCubit.get(context)
                                                    .getImage();
                                              },
                                              icon: const Icon(
                                                Icons.camera_alt,
                                                color: Colors.white,
                                                size: 20.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      cursorColor: defaultColor,
                                      controller: nameController,
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                        hintText: 'name of department',
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: defaultColor,
                                          ),
                                        ),
                                        hintStyle: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      onFieldSubmitted: (String value) {},
                                      onChanged: (String value) {
                                        print(value);
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'name mustn\'t be empty';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),

                                    defTextButton(function: ()
                                    {
                                      if (formKey.currentState!.validate())
                                      {

                                      }
                                    }, text: 'add', color: defaultColor)

                                  ],
                                ),
                              ),
                            ),
                          elevation: 10.0,
                        );
                        cubit.isBottomSheetShown = false;
                      }*/
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 22.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
                  Icons.arrow_forward_ios,
                  size: 12.0,
                ),
              ),
            ],
          ),
          const Image(
            image: AssetImage('assets/images/undraw_Female_avatar_efig (1).png'),
            //NetworkImage(model.img, scale: 10.0),
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
