import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:machinetest_intellect/bloc/product_bloc/product_bloc.dart';
import 'package:machinetest_intellect/bloc/product_bloc/product_event.dart';
import 'package:machinetest_intellect/bloc/product_bloc/product_state.dart';
import 'package:machinetest_intellect/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProductBloc, ProductState>(
          listener: (context, state) async {
            if (state is ProductLoadedState) {
              if (state.productlistmodel.message ==
                  "User registered successfully") {
                Fluttertoast.showToast(msg: state.productlistmodel.message);

                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.setString("user", "User registered successfully");

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HomeScreen()));
              } else {
                Fluttertoast.showToast(msg: "Already registered");
              }
            }
          },
        ),
      ],
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(title: const Text("User Registration")),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            controller: namecontroller,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter  name';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                hintText: 'Enter first Name',
                                labelText: 'Name',
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.blue,
                                ),
                                errorStyle: TextStyle(fontSize: 12.0),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(9.0)))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: emailcontroller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the email';
                              }

                              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                return "Please enter a valid email address";
                              }

                              return null;
                            },
                            decoration: const InputDecoration(
                                hintText: 'Email',
                                labelText: 'Email',
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.lightBlue,
                                ),
                                errorStyle: TextStyle(fontSize: 12.0),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(9.0)))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: passwordcontroller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the password';
                              }

                              return null;
                            },
                            decoration: const InputDecoration(
                                hintText: 'Password',
                                labelText: 'Password',
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.lightBlue,
                                ),
                                errorStyle: TextStyle(fontSize: 12.0),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(9.0)))),
                          ),
                        ),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: ElevatedButton(
                              child: const Text(
                                'Save',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              ),
                              onPressed: () async {
                                if (_formkey.currentState!.validate()) {
                                  print('form submiitted');

                                  final registerBloc =
                                      BlocProvider.of<ProductBloc>(context);
                                  registerBloc.add(FetchProductEvent(
                                      namecontroller.text,
                                      emailcontroller.text,
                                      passwordcontroller.text));
                                }
                              },
                            ),
                          ),
                        )),
                      ],
                    )),
              ),
            )),
      ),
    );
  }
}
