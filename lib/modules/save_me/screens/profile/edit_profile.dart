import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants/assest_path.dart';

import 'cubit/profile_cubit.dart';
import '../../../../utils/mixins/validation_mixins.dart';

class ProfileEditScreen extends StatelessWidget {
  ProfileEditScreen({Key key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        _userNameController.text = state.user.displayName;
        return Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 200,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(state.user.photoURL),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 125,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<ProfileCubit>(context)
                            .showPicker(context);
                      },
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage(state.user.photoURL),
                          ),
                          CircleAvatar(
                            child: state is UploadingPhoto
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  )
                                : Icon(Icons.add_a_photo),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _userNameController,
                              keyboardType: TextInputType.name,
                              autocorrect: false,
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.person_rounded),
                                labelText: "Username",
                              ),
                              validator: Validators.isValidUserName,
                              onChanged: (name) {
                                _userNameController.text = name;
                                _userNameController.selection =
                                    TextSelection.fromPosition(
                                  TextPosition(
                                    offset: _userNameController.text.length,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 50,
                left: 20,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      BlocProvider.of<ProfileCubit>(context).updateName(
                        name: _userNameController.text,
                      );

                      if (state.user.photoURL == null)
                        BlocProvider.of<ProfileCubit>(context).updatePhoto(
                          url: defaultPhotoURL,
                        );
                    }
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
