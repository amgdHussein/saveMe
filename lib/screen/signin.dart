import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:save_me/shared/styles/colors.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    bool secure = true;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            child: Row(
              children: [
                Icon(Icons.arrow_back_ios),
                Text("Back")
              ],
            ),
            onTap: (){
              Navigator.pop(context);
            },
          ),
        ),

        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(                      
                      children: [
                        TextSpan(text: "save", style: Theme.of(context).textTheme.headline1.copyWith(color: GRAY_CHATEAU),),
                        TextSpan(text: "Me", style: Theme.of(context).textTheme.headline1),
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  Text("Proceed with your", style: Theme.of(context).textTheme.headline2),
                  Text("Sing In", style: Theme.of(context).textTheme.headline2.copyWith(fontWeight: FontWeight.bold),),
                  SizedBox(height: 70,),

                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,

                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.person_rounded),
                            labelText: "Email Address",
                            
                          ),

                          validator: (email) {
                            if (email.isEmpty)
                              return "Email address is required.";
                            return null;
                          },

                          onChanged: (email) {
                            _emailController.text = email;
                            _emailController.selection = TextSelection.fromPosition(TextPosition(offset: _emailController.text.length));
                          },
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: secure,

                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.vpn_key_rounded),
                            labelText: "Password",
                          ),

                          validator: (password) {
                            if (password.isEmpty)
                              return "Password is required.";
                            return null;
                          },

                          onChanged: (password) {
                            _passwordController.text = password;
                            _passwordController.selection = TextSelection.fromPosition(TextPosition(offset: _passwordController.text.length));
                          },
                        ),
                        SizedBox(height: 30,),
                        SizedBox(
                          width: double.infinity,
                          child: FloatingActionButton(
                            child: Text("Sign In"),
                            onPressed: () {
                              if(_formKey.currentState.validate())
                                print("${_emailController.text} \n${_passwordController.text}");
                            },
                          ),
                        ),
                        SizedBox(height: 20,),
                        GestureDetector(
                          onTap: () {
                            print("${_emailController.text} \n${_passwordController.text}");
                          },
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "New to ",
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                TextSpan(
                                  text: "save",
                                  style: Theme.of(context).textTheme.button.copyWith(color: GRAY_CHATEAU),
                                ),
                                TextSpan(
                                  text: "Me",
                                  style: Theme.of(context).textTheme.button,
                                ),
                                TextSpan(
                                  text: "? Sign up now.",
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}