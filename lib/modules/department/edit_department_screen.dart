import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:med_manage_app/cubit/cubit.dart';
import 'package:med_manage_app/cubit/states.dart';
import 'package:med_manage_app/styles/colors/colors.dart';
import 'package:med_manage_app/widgets/component.dart';

import '../../layout/med_manage_layout.dart';
import '../../models/department/index_department_model.dart';


class EditDepartmentScreen extends StatelessWidget {

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  final DepartmentHomeModel? model;
  final int index;

  EditDepartmentScreen({
    required this.model,
    required this.index,
  });
  var nameController = TextEditingController();


  @override
  Widget build(BuildContext context) {


    return BlocConsumer<MedManageCubit,MedManageStates>(
        builder: (context, state)
        {
          nameController.text = model!.Department![index].name;
          //var updateDepartmentModel  =  MedManageCubit.get(context).updateDepartmentModel;
          //MedManageCubit cubit =  MedManageCubit.get(context);
          //var departmentImage  =  MedManageCubit.get(context).departmentImage;

          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Edit Department',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              titleSpacing: 5.0,
              actions: [
                ConditionalBuilder(
                    condition: state is! MedManageLoadingUpdateDepartmentState,
                    builder: (context)=> defTextButton(
                      text:'update' ,
                      color: color4,

                      function: ()
                      {
                        // MedManageCubit.get(context).uploadImage(departmentImage!);

                        if(formKey.currentState!.validate())
                        {
                          MedManageCubit.get(context).updateDepartment(
                            id:model!.Department![index].id,
                            name: nameController.text,
                            // name: model!.Department![index].name,
                          );
                          MedManageCubit.get(context).getHomeDepData();
                          navigateAndReplacement(context,MedManageLayout());
                        }
                      },
                    ),
                    fallback: (context)=> const Center(
                      child:CircularProgressIndicator() ,
                    )),
                const SizedBox(width: 10.0,),
              ],
            ),
            body:Padding(
              padding:const EdgeInsets.all(25.0),
              child:  SingleChildScrollView(
                child: Column(
                  children:
                  [
                    Container(
                      color: Colors.white,
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Align(
                              child:Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children:
                                [
                                  const Image(
                                    image: AssetImage('assets/images/undraw_Female_avatar_efig (1).png'),
                                    // image: departmentImage == null ? AssetImage('assets/images/undraw_About_me_re_82bv (1).png'): FileImage(departmentImage!),
                                    // image:NetworkImage('http://192.168.1.10:8000/upload/${model.img}') ,
                                    //uploads/${model!.Department![index].img}
                                    //image: (departmentImage == null) ? FileImage(departmentImage!) as ImageProvider : AssetImage('assets/images/undraw_Female_avatar_efig (1).png'),
                                    width: double.infinity,
                                    height: 170.0,
                                    fit: BoxFit.contain,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: defaultColor,
                                    radius: 18.0,
                                    child:IconButton(
                                      onPressed: ()
                                      {
                                        MedManageCubit.get(context).getImage();
                                      },
                                      icon:const Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                        size: 20.0,
                                      ),),
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
                              onFieldSubmitted: (String value)
                              {

                              },
                              onChanged: (String value)
                              {
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
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  'created at ${DateFormat.yMMMd().format(DateTime.parse((model!.Department![index].created_at)))}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'updated at ${DateFormat.yMMMd().format(DateTime.parse((model!.Department![index].updated_at)))}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context ,state){}
    );
  }
}