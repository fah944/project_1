import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../widgets/edit_secretaria_prof_item.dart';

class EditSecretariaProfScreen extends StatelessWidget {

  final int? index;

  EditSecretariaProfScreen({
    super.key,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedManageCubit,MedManageStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! MedManageLoadingSecretariaProfEditState,
          builder: (context) => EditSecretariaProfItem(
            model: MedManageCubit.get(context).viewSecretariaModel,
            modelIn: MedManageCubit.get(context).indexSecretariaModel,
            index: index,
          ),
          fallback: (context) => Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
