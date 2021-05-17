import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:teamup/contract/LoginContract.dart';
import 'package:teamup/module/LoginRequestModel.dart';
import 'package:teamup/presenter/LoginPresenter.dart';
import 'package:teamup/screen/DashboardScreen.dart';
import 'package:teamup/screen/ForgotPasswordScreen.dart';
import 'package:teamup/screen/SelectLoginScreen.dart';
import 'package:teamup/screen/SignUpScreen.dart';
import 'package:teamup/screen/organizationscreens/OrganizationRegistration.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/SnackBar.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/Toast.dart';
import 'package:teamup/utils/Dialogs/orgRegistrationSuccessHelper.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> implements LoginContract {
  LoginRequestModel loginRequestModel;

  LoginPresenter loginPresenter;

  bool isLoggedIn = false;
  bool _emailValidate = false;
  bool _passwordValidate = false;

  checkInternet _checkInternet;

  bool isApiCallProcess = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String name = "";
  String emailId;
  String profilePicUrl;
  bool _passwordVisible = true;

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  _LoginState() {
    loginPresenter = new LoginPresenter(this);
  }

  void callLoginAPI(String Username, String Password, BuildContext context) {
    loginRequestModel.isStudent = Preference.getIsStudent() ? 'true' : 'null';
    loginRequestModel.isOrganzation =
        Preference.getIsOrganization() ? 'true' : 'null';
    loginRequestModel.userName = Username;
    loginRequestModel.password = Password;
    loginRequestModel.isFaculty = 'null';
    loginRequestModel.email = 'null';
    loginRequestModel.contactNp = 'null';
    loginRequestModel.smsCode = 'null';
    loginRequestModel.emailCode = 'null';
    loginRequestModel.fcm = Preference.getFcmToken();
    _checkInternet.check().then((value) {
      if (value != null && value) {
        //login(loginRequestModel, context);
        loginPresenter.loginAPI(loginRequestModel, 'Login/Login');
        setState(() {
          isApiCallProcess = true;
        });
      } else {
        toast().showToast('Please check your internet connection..');
      }
    });
  }

  Future<void> _handleGoogleSignIn() async {
    try {
//      _googleSignIn.disconnect();
      await _googleSignIn.signIn();
      _googleSignIn.clientId;
      print("${_googleSignIn.currentUser.email}");
      print("${_googleSignIn.currentUser.displayName}");
      print("${_googleSignIn.currentUser.photoUrl}");
      print("${_googleSignIn.clientId}");
      // if(_googleSignIn.currentUser.email!=null){
      //   loginBloc.add(SocialMediaLoginEvent(postSocialMediaLoginRequest: PostSocialMediaLoginRequest(
      //     email: _googleSignIn.currentUser.email,
      //     name: _googleSignIn.currentUser.displayName,
      //     image: _googleSignIn.currentUser.photoUrl,
      //     id: "",
      //   )));
      // }
      // Toast.show("${_googleSignIn.currentUser.email}", context,
      //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    } catch (error) {
      print(error);
    }
  }

  Future<void> _loginWithFacebook() async {
    var facebookLogin = FacebookLogin();
    // var facebookLoginResult = await facebookLogin.logInWithReadPermissions(['email']);
    var facebookLoginResult = await facebookLogin.logIn(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Error");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${facebookLoginResult.accessToken.token}');

        var profile = json.decode(graphResponse.body);
        print(profile.toString());

        onLoginStatusChanged(true);
        break;
    }
  }

  // Future<void> login(
  //     LoginRequestModel loginRequestModel, BuildContext context) async {
  //   String newUrl = "https://teamup.sdaemon.com/api/" + "Login/Login";
  //   Map<String, String> header = {"Content-Type": "application/json"};
  //   final response = await http.post(newUrl,
  //       headers: header, body: loginRequestModel.toJson());
  //   final Response = json.decode(response.body.toString());
  //   if (Response['Status'] == 0) {
  //     setState(() {
  //       isApiCallProcess = false;
  //       Preference.setUserId(Response['Student'][0]['ID']);
  //       Preference.setUserFirstName(Response['Student'][0]['Firstname']);
  //       Preference.setUserLastName(Response['Student'][0]['Lastname']);
  //       Preference.setUserEmail(Response['Student'][0]['Email']);
  //       Preference.setUserMobile(Response['Student'][0]['Phone']);
  //       Preference.setIsLogin(true);
  //     });
  //     toast().showToast(Response['Message']);
  //     Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: (context) => Dashboard()));
  //   } else {
  //     toast().showToast(Response['Message']);
  //     setState(() {
  //       isApiCallProcess = false;
  //     });
  //   }
  // }

  void onLoginStatusChanged(bool isLoggedIn) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Preference.init();
    loginRequestModel = new LoginRequestModel();
    _checkInternet = new checkInternet();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _MainUI(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  @override
  Widget _MainUI(BuildContext context) {
    return Scaffold(body: Builder(
      builder: (context) {
        return getBody();
      },
    ));
  }

  Widget getBody() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          image: DecorationImage(
            image: AssetImage('assets/art/Vector_Art_Full_Page.png'),
            fit: BoxFit.cover,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50.0,
          ),
          Image.asset('assets/splashscreen/icon.png'),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Welcome Back !',
            style: TextStyle(
                color: Colors.white,
                fontSize: 28.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 40.0,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60.0),
                        bottomRight: Radius.circular(60.0))),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context).primaryColor,
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                    bottom: BorderSide(color: Colors.grey[200]),
                                  )),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8.0, top: 8.0, bottom: 8.0),
                                    child: TextField(
                                      style: TextStyle(color: Colors.black),
                                      controller: emailController,
                                      decoration: InputDecoration(
                                          errorText: _emailValidate
                                              ? 'Please enter valid email'
                                              : null,
                                          hintText: "Username",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400]),
                                          border: InputBorder.none,
                                          prefixIcon:
                                              Icon(Icons.account_circle)),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        // bottom: BorderSide(color: Colors.grey[200]),
                                        )),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    style: TextStyle(color: Colors.black),
                                    obscureText: _passwordVisible,
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                      errorText: _passwordValidate
                                          ? 'Please enter password'
                                          : null,
                                      hintText: "Password",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400]),
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.lock),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                        onPressed: () {
                                          // Update the state i.e. toogle the state of passwordVisible variable
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      loginButton(emailController, passwordController, context),
                      SizedBox(
                        height: 20.0,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            //orgRegSuccessDailogHelper.Ok(context);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ForgotPassword()));
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'or',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      socialLogin(),
                      SizedBox(
                        height: 10.0,
                      ),
                      widgetRegister(context),
                      SizedBox(
                        height: 50.0,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget loginButton(TextEditingController emailController,
      TextEditingController passwordController, BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          emailController.text.isEmpty
              ? _emailValidate = true
              : _emailValidate = false;
          passwordController.text.isEmpty
              ? _passwordValidate = true
              : _passwordValidate = false;
        });
        if (_passwordValidate == false && _emailValidate == false) {
          callLoginAPI(emailController.text.trim(),
              passwordController.text.trim(), context);
        }
      },
      child: Container(
        height: 50.0,
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(20.0)),
        child: Center(
          child: Text(
            'Login',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
        ),
      ),
    );
  }

  @override
  void showLoginError(FetchException exception) {
    toast().showToast('Something went wrong, Please try again later..');
    setState(() {
      isApiCallProcess = false;
    });
  }

  @override
  void showLoginSuccess(LoginResponseModel success) {
    LoginResponseModel loginResponseModel;
    setState(() {
      isApiCallProcess = false;
      loginResponseModel = success;
    });
    if (loginResponseModel.status == 0) {
      toast().showToast(loginResponseModel.message);
      setState(() {
        isApiCallProcess = false;
        Preference.setUserId(loginResponseModel.student[0].id);
        Preference.setUserFirstName(loginResponseModel.student[0].firstname);
        Preference.setUserLastName(loginResponseModel.student[0].lastname);
        Preference.setUserEmail(loginResponseModel.student[0].email);
        Preference.setUserMobile(loginResponseModel.student[0].phone);
        Preference.setUserImage(loginResponseModel.student[0].profilePic);
        Preference.setIsLogin(true);
      });
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Dashboard()));
    } else {
      toast().showToast(loginResponseModel.message);
    }
  }
}

Widget socialLogin() {
  return Container(
    child: Padding(
      padding: const EdgeInsets.only(left: 50.0, right: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
              height: 60.0,
              width: 60.0,
              child: IconButton(
                onPressed: () {
                  _LoginState()._handleGoogleSignIn();
                },
                icon: new Image.asset('assets/socialMedia/google.png'),
              )),
          SizedBox(
              height: 60.0,
              width: 60.0,
              child: IconButton(
                onPressed: () {
                  _LoginState()._loginWithFacebook();
                },
                icon: new Image.asset('assets/socialMedia/fb.png'),
              )),
        ],
      ),
    ),
  );
}

Widget widgetRegister(BuildContext context) {
  return GestureDetector(
    onTap: () {
      if (Preference.getIsStudent()) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUp()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OrganizationSignUp()),
        );
      }
    },
    child: Text.rich(
      TextSpan(
        text: 'Not a member ?',
        style: TextStyle(fontSize: 16, color: Colors.black),
        children: <TextSpan>[
          TextSpan(
            text: ' Register here.',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
          // can add more TextSpans here...
        ],
      ),
    ),
  );
}
