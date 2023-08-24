import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../styles/colors/colors.dart';
import '../../widgets/component.dart';
import 'widgets/secretaria_list_view_item.dart';
import '../register_secretaria/register_secretaria_screen.dart';

class SecretariaScreen extends StatelessWidget {
  const SecretariaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedManageCubit, MedManageStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is IndexSecretariaListLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }else if (state is IndexSecretariaListSuccssesState){
          return SecretariaListViewItem(
            context,
            profImage: 'assets/images/undraw_Female_avatar_efig.png',
            model: MedManageCubit.get(context).indexSecretariaModel,
          );
        }else if (state is IndexSecretariaListErrorState)
        {
          return Scaffold(
            // floatingActionButtonLocation:
            //     FloatingActionButtonLocation.miniEndFloat,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                navigateTo(context, RegisterSecretaria());
              },
              child: const Icon(
                Icons.add,
                size: 40,
              ),
            ),
            body: const Center(
              child: Text(
                'There is some thing error',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          );
        }else
        {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
