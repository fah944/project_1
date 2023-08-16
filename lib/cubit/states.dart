abstract class MedManageStates {}

class MedManageInitialState extends MedManageStates {}

class MedManageChangeBottomNavState extends MedManageStates {}

class MedManageChangePassVisibilityState extends MedManageStates {}

class MedManageSuccssesPatientsListState extends MedManageStates {}

class MedManageLoadHomeDepDataState extends MedManageStates {}

class MedManageSuccessHomeDepDataState extends MedManageStates {
  /*final DepartmentHomeModel depHomeModel;
  MedManageSuccessHomeDepDataState(this.depHomeModel);*/
}

class MedManageErrorHomeDepDataState extends MedManageStates {
  final String error;
  MedManageErrorHomeDepDataState(this.error);
}

class MedManageLoadingAddDepartmentState extends MedManageStates {}

class MedManageAddDepartmentSuccessState extends MedManageStates {}

class MedManageAddDepartmentErrorState extends MedManageStates {}

class MedManageDeleteDepartmentSuccessState extends MedManageStates {}

class MedManageDeleteDepartmentErrorState extends MedManageStates {}

class MedManageLoadingUpdateDepartmentState extends MedManageStates {}

class MedManageUpdateDepartmentSuccessState extends MedManageStates {}

class MedManageUpdateDepartmentErrorState extends MedManageStates {}

class MedManageDepImagePickedSuccessState extends MedManageStates {}

class MedManageDepImagePickedErrorState extends MedManageStates {}

//Secritary AND Patient*********************************************************************************************************************

class IndexSecretariaListLoadingState extends MedManageStates {}

class IndexSecretariaListSuccssesState extends MedManageStates {}

class MedManageLoadingSecretariaListState extends MedManageStates {}

class IndexSecretariaListErrorState extends MedManageStates {}

class SecretariaProfLoadingState extends MedManageStates {}

class SecretariaProfSuccssesState extends MedManageStates {}

class SecretariaProfErrorState extends MedManageStates {}

class SecretariaProfEditLoadingState extends MedManageStates {}

class SecretariaProfEditSuccssesState extends MedManageStates {}

class SecretariaProfEditErrorState extends MedManageStates {}

class SecretariaDeleteLoadingState extends MedManageStates {}

class SecretariaDeleteSuccssesState extends MedManageStates {}

class SecretariaDeleteErrorState extends MedManageStates {}

class SecretariaRegisterLoadingState extends MedManageStates {}

class SecretariaRegisterSuccssesState extends MedManageStates {}

class SecretariaRegisterErrorState extends MedManageStates {}

class IndexPatientListLoadingState extends MedManageStates {}

class IndexPatientListSuccssesState extends MedManageStates {}

class IndexPatientListErrorState extends MedManageStates {}

class PatientProfLoadingState extends MedManageStates {}

class PatientProfSuccssesState extends MedManageStates {}

class PatientProfErrorState extends MedManageStates {}

class PatientDeleteLoadingState extends MedManageStates {}

class PatientDeleteSuccssesState extends MedManageStates {}

class PatientDeleteErrorState extends MedManageStates {}

class IndexDepartmentListLoadingState extends MedManageStates {}

class IndexDepartmentListSuccssesState extends MedManageStates {}

class IndexDepartmentListErrorState extends MedManageStates {}
