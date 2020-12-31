


import 'package:c4d/module_init/model/package/packages.model.dart';

class InitAccountState{ }

class InitAccountInitState extends InitAccountState{}

class InitAccountFetchingDataState extends InitAccountState{}

class InitAccountFetchingDataSuccessState extends InitAccountState{
   List<PackageModel>  data;

  InitAccountFetchingDataSuccessState(
      this.data,
      );
}

class InitAccountFetchingDataErrorState extends InitAccountState{}
///-------------------------------------------------------------------------

class InitAccountCreateProfileSuccessState extends InitAccountState{}

class InitAccountCreateProfileErrorState extends InitAccountState{}
///-------------------------------------------------------------------------

class InitAccountSubscribeSuccessState extends InitAccountState{}

class InitAccountSubscribeErrorState extends InitAccountState{}
