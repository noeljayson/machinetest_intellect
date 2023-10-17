

import 'dart:async';


import 'package:machinetest_intellect/Model/register_model.dart';

import '../../datasources/provider.dart';

class Repository {
  Provider startScreenProviders = Provider();

  FutureOr<RegisterModel> getregister(username,email,password) =>
      startScreenProviders.getregister(username,email,password);
}
