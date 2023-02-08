import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pokedex_flutter/controllers/shared_preferences_controller.dart';

import '../bloc/cubit/register_user_cubit.dart';

class SignUpUserPage extends StatefulWidget {
  @override
  State<SignUpUserPage> createState() => _SignUpUserPageState();
}

class _SignUpUserPageState extends State<SignUpUserPage> {
  final TextEditingController
    _emailController = TextEditingController(),
    _passwordController = TextEditingController(),
    _nameController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterUserCubit(RegisterUserState.initial),
      child: BlocConsumer<RegisterUserCubit, RegisterUserState>(
        listener: (context, state){
          switch (state) {
            case RegisterUserState.success:
              SharedPreferencesController.setUserId(FirebaseAuth.instance.currentUser?.uid);
              Navigator.of(context).pushNamed("/Home");
              break;
            case RegisterUserState.userExists:
              ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
                SnackBar(
                  content: Text('User exists with these credentials'),
                ),
              );
              break;
            case RegisterUserState.weakPassword:
              ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
                SnackBar(
                  content: Text('Please use a stronger password'),
                ),
              );
              break;
            case RegisterUserState.failed:
              ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
                SnackBar(
                  content: Text('Something went wrong, try again'),
                ),
              );
              break;
            case RegisterUserState.initial:
              print("User currently signed out");
              break;
          }
        },
        builder: (context, state) {

          // if (state == RegisterUserState.failed){
          //   return Scaffold(
          //     body: Center(
          //       child: Text("Something went wrong"),
          //     ),
          //   );
          // }

          return FormBuilder(
            key: _formKey,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/pokeball.png', height: 25, width: 25),
                      Text(" Pokedex", style: Theme.of(context).textTheme.headline2)
                    ],
                  ),
                ),
              ),
              body: Padding(
                padding: EdgeInsets.all(32),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Sign up", style: Theme.of(context).textTheme.headline3?.copyWith(color: Theme.of(context).primaryColor),),
                      SizedBox(height: 30,),
                      FormBuilderTextField(
                        name: 'name',
                        controller: _nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                        ),
                        validator: (input){
                          if (input == "" || input == null) return "Please enter name";
                          if (RegExp(r'[0-9]').hasMatch(input)) return "Please enter letters only";
                          return null;
                        }
                      ),
                      SizedBox(height: 30,),
                      FormBuilderTextField(
                        name: 'email',
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                        validator: (input){
                          if (input == "" || input == null) return "Please enter email";
                          if (!RegExp(r'\b[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}\b').hasMatch(input)) return "Please enter valid email address";
                          return null;
                        }
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      FormBuilderTextField(
                        name: 'password',
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                        validator: (input){
                          if (input == "" || input == null) return "Please enter email";
                          if (input.length < 8) return "Please enter password of at least 8 characters";
                          return null;
                        }
                      ),
                      SizedBox(height: 30,),
                      TextButton(
                        child: Text("Register", style: Theme.of(context).textTheme.headline2?.copyWith(color: Theme.of(context).primaryColor),),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false)
                            context.read<RegisterUserCubit>().registerUser(email: _emailController.text, password: _passwordController.text, name: _nameController.text);
                        },
                      ),
                      SizedBox(height: 20,),
                      TextButton(
                        child: Text("Log in instead", style: Theme.of(context).textTheme.headline3?.copyWith(color: Theme.of(context).primaryColor),),
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed("/Login");
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}