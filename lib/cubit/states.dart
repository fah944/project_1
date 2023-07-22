
abstract class MedManageStates{}

class MedManageInitialState extends MedManageStates{}
class MedManageChangeBottomNavState extends MedManageStates{}


class MedManageLoadHomeDepDataState extends MedManageStates{}
class MedManageSuccessHomeDepDataState extends MedManageStates
{
  /*final DepartmentHomeModel depHomeModel;
  MedManageSuccessHomeDepDataState(this.depHomeModel);*/
}
class MedManageErrorHomeDepDataState extends MedManageStates
{
  final String error;
  MedManageErrorHomeDepDataState(this.error);

}


class MedManageAddSuccessState extends MedManageStates{}
class MedManageAddErrorState extends MedManageStates{}


class MedManageDeleteSuccessState extends MedManageStates{}
class MedManageDeleteErrorState extends MedManageStates{}

class MedManageUpdateSuccessState extends MedManageStates{}
class MedManageUpdateErrorState extends MedManageStates{}

//Secritary AND Patient*********************************************************************************************************************

class MedManageLoadingSecretariaListState extends MedManageStates{}
class MedManageSuccssesSecretariaListState extends MedManageStates{}
class MedManageErrorSecretariaListState extends MedManageStates{}

class MedManageLoadingSecretariaProfState extends MedManageStates{}
class MedManageSuccssesSecretariaProfState extends MedManageStates{}
class MedManageErrorSecretariaProfState extends MedManageStates{}

class MedManageLoadingSecretariaProfEditState extends MedManageStates{}
class MedManageSuccssesSecretariaProfEditState extends MedManageStates{}
class MedManageErrorSecretariaProfEditState extends MedManageStates{}

class MedManageLoadingSecretariaProfDeleteState extends MedManageStates{}
class MedManageSuccssesSecretariaProfDeleteState extends MedManageStates{}
class MedManageErrorSecretariaProfDeleteState extends MedManageStates{}

class MedManageLoadingSecretariaRegisterState extends MedManageStates{}
class MedManageSuccssesSecretariaRegisterState extends MedManageStates{}
class MedManageErrorSecretariaRegisterState extends MedManageStates{}

class MedManageLoadingPatientsListState extends MedManageStates{}
class MedManageSuccssesPatientsListState extends MedManageStates{}
class MedManageErrorPatientsListState extends MedManageStates{}

class MedManageLoadingPatientsProfState extends MedManageStates{}
class MedManageSuccssesPatientsProfState extends MedManageStates{}
class MedManageErrorPatientsProfState extends MedManageStates{}

class MedManageLoadingPatientsDeleteState extends MedManageStates{}
class MedManageSuccssesPatientsDeleteState extends MedManageStates{}
class MedManageErrorPatientsDeleteState extends MedManageStates{}
