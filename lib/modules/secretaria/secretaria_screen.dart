import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../styles/colors/colors.dart';
import '../../widgets/secretaria_list_view_item.dart';

class SecretariaScreen extends StatelessWidget {
  const SecretariaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedManageCubit,MedManageStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 1.0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: color5,
              ),
              onPressed: (){
                //navigateAndReplacement(context, const MedManageLayout());
              },
            ),
            title: const Text(
              'Secretary',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: defaultColor,
                letterSpacing: .3,
              ),
            ),
          ),
          body: SecretariaListViewItem(context,profImage: 'assets/images/default_photo.jpg', model: MedManageCubit.get(context).indexSecretariaModel,),
        );
      },
    );
  }
}
