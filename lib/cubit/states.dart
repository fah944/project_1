
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
