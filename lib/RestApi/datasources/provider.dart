import 'dart:async';

import 'package:machinetest_intellect/Model/product_model.dart';
import 'package:machinetest_intellect/Model/register_model.dart';

import '../config/serveraddress.dart';
import '../domain/entities/Restapi.dart';
import '../domain/entities/app_exceptions.dart';

class Provider {

  FutureOr<RegisterModel> getregister(username,email,password) async {
    try {
      print("Loading from api");
      var requestBody = {

        'username':username,
        'email':email,
        'password':password
      };
      var res = await RestAPI().post(ServerAddresses.register,params:requestBody );

      print(res);
      return registerModelFromMap(res);
    } on RestException catch (e) {
      throw e.message;
    }
  }
}
