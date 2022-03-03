import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:movie_booking_app/data/modle/movie_booking_model.dart';
import 'package:movie_booking_app/data/modle/movie_booking_model_impl.dart';
import 'package:movie_booking_app/data/vos/user_vo/user_vo.dart';
import 'package:movie_booking_app/network/authentication/facebook_sigin.dart';
import 'package:movie_booking_app/network/authentication/google_sigin.dart';
import 'package:movie_booking_app/page/home_screen.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimension.dart';
import 'package:movie_booking_app/resources/strings.dart';
import 'package:movie_booking_app/widgets/button_text_widget.dart';
import 'package:movie_booking_app/widgets/button_widget.dart';
import 'package:movie_booking_app/widgets/text_form_field_input_widget.dart';

class LoginSiginScreen extends StatefulWidget {
  const LoginSiginScreen({Key? key}) : super(key: key);

  @override
  _LoginSiginScreenState createState() => _LoginSiginScreenState();
}

class _LoginSiginScreenState extends State<LoginSiginScreen> {
  MovieBookingModel movieBookingModel = MovieBookingModelImpl();

  final List<String> tabs = ['Login', 'Sigin'];

  final loginForm = GlobalKey<FormState>();
  final siginForm = GlobalKey<FormState>();

  final loginEmailCOntroller = TextEditingController();
  final loginPasswordCOntroller = TextEditingController();
  final siginNameCOntroller = TextEditingController();
  final siginPhoneCOntroller = TextEditingController();
  final siginEmailCOntroller = TextEditingController();
  final siginPasswordCOntroller = TextEditingController();
  bool isShowLogin = true;
  bool isShowSignin = false;
  bool isLoading = false;
  String googleAccessToken = '';
  String faceBookAccessToken = '';
  UserVO defaultUser = UserVO.normal();
  GoogleSiginAuthentication googleSiginAuthentication =
      GoogleSiginAuthentication();
  FaceBookSiginAuthentication faceBookSiginAuthentication =
      FaceBookSiginAuthentication();

  _loginCheck(context) {
    String message = "";
    String subMessage = "";
    if (loginForm.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      print(isLoading);
      movieBookingModel
          .getUserLoginStatus(
              loginEmailCOntroller.text, loginPasswordCOntroller.text)
          .then((status) {
        if (status?.token != null) {
          setState(() {
            print(status?.token ?? "");
            message = 'Success';
            subMessage = status?.message ?? "";
            isLoading = false;
            _showALertBox(context, message, subMessage, status ?? defaultUser);
          });
        } else {
          setState(() {
            message = 'Error';
            subMessage = status?.message ?? "";
            isLoading = false;
            _showALertBox(context, message, subMessage, defaultUser);
          });
        }
      }).catchError((error) {
        setState(() {
          message = 'Error';
          subMessage = 'Please check user action again';
          isLoading = false;
          _showALertBox(context, message, subMessage, defaultUser);
        });
      });
      print(isLoading);
    }
  }

  _changeonTap(val) {
    setState(() {
      isShowLogin = val == 0 ? true : false;
      isShowSignin = val == 1 ? true : false;
    });
  }

  _loginWithGoogle(context) {
    String message = "";
    String subMessage = "";
    googleSiginAuthentication.gooleSigin().then((value) {
      print('Google Login ID ${value?.id}');

      movieBookingModel.loginWithGoogle(value?.id ?? '').then((status) {
        if (status?.token != null) {
          setState(() {
            message = 'Success';
            subMessage = status?.message ?? "";
            isLoading = false;
            _showALertBox(context, message, subMessage, status ?? defaultUser);
          });
        } else {
          setState(() {
            message = 'Error';
            subMessage = status?.message ?? "";
            isLoading = false;
            _showALertBox(context, message, subMessage, defaultUser);
          });
        }
      }).catchError((error) => print(error));
    }).catchError((error) => print(error));
  }

  _loginWithFaceBook(context) {
    String message = "";
    String subMessage = "";
    faceBookSiginAuthentication.loginWithFacebook().then((result) {
      print('Facebook Login ID ${result.accessToken?.userId}');
      movieBookingModel
          .loginWithFacebook(result.accessToken?.userId ?? '')
          .then((status) {
        if (status?.token != null) {
          setState(() {
            message = 'Success';
            subMessage = status?.message ?? "";
            isLoading = false;
            _showALertBox(context, message, subMessage, status ?? defaultUser);
          });
        } else {
          setState(() {
            message = 'Error';
            subMessage = status?.message ?? "";
            isLoading = false;
            _showALertBox(context, message, subMessage, defaultUser);
          });
        }
      }).catchError((error) => print(error));
    }).catchError((error) => print(error));
  }

  _siginCheck(context) {
    UserVO defaultUsaer = UserVO.normal();
    String message = "";
    String subMessage = "";
    if (siginForm.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      movieBookingModel
          .getUserRegisterStatus(
              siginNameCOntroller.text,
              siginEmailCOntroller.text,
              siginPhoneCOntroller.text,
              siginPasswordCOntroller.text,
              googleAccessToken,
              faceBookAccessToken)
          .then((status) {
        if (status?.token != null) {
          setState(() {
            message = 'Success';
            subMessage = status?.message ?? "";
            isLoading = false;
            _showALertBox(context, message, subMessage, status ?? defaultUsaer);
          });
        } else {
          setState(() {
            message = 'Error';
            subMessage = status?.message ?? "";
            isLoading = false;
            _showALertBox(context, message, subMessage, defaultUsaer);
          });
        }
      }).catchError((error) {
        setState(() {
          message = 'Error';
          subMessage = 'Please check user action again';
          isLoading = false;
          _showALertBox(context, message, subMessage, defaultUsaer);
        });
      });
    }
  }

  _googleSigin() {
    googleSiginAuthentication.gooleSigin().then((value) {
      googleAccessToken = value?.id ?? '';
      print('Sigin Google ID ${value?.id}');
      setState(() {
        siginNameCOntroller.text = value?.displayName ?? '';
        siginEmailCOntroller.text = value?.email ?? '';
      });
    }).catchError((error) => print(error));
  }

  _faceBookSigin() async {
    faceBookSiginAuthentication.loginWithFacebook().then((result) {
      print('Facebook Sigin ID ${result.accessToken?.userId}');
      faceBookAccessToken = result.accessToken?.userId ?? '';
      FacebookAuth.i.getUserData().then((userData) {
        siginEmailCOntroller.text = userData['email'];
        siginNameCOntroller.text = userData['name'];
      }).catchError((error) => print(error));
    }).catchError((error) => print(error));
  }

  _showALertBox(
      context, String message, String subMessage, UserVO userVO) async {
    bool status = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message),
            content: Text(subMessage),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(message == 'Error' ? false : true);
                  },
                  child: const Text('OK'))
            ],
          );
        });

    if (status) {
      movieBookingModel.saveUserInfo(userVO);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return const HomeScreeen();
      }));
    }
  }

  @override
  void dispose() {
    loginEmailCOntroller.dispose();
    loginPasswordCOntroller.dispose();
    siginNameCOntroller.dispose();
    siginPhoneCOntroller.dispose();
    siginEmailCOntroller.dispose();
    siginPasswordCOntroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Visibility(
            visible: isLoading,
            child: Positioned.fill(
                child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black12.withOpacity(0.4),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            )),
          ),
          IgnorePointer(
            ignoring: isLoading,
            child: Container(
              margin: const EdgeInsets.only(
                  top: margin_large,
                  left: spacing_micro_1x,
                  right: spacing_micro_1x),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LoginSiginTitleSession(),
                  LoginSiginTabBarSession(
                    tabs: tabs,
                    loginForm: loginForm,
                    siginForm: siginForm,
                    loginEmailCOntroller: loginEmailCOntroller,
                    loginPasswordCOntroller: loginPasswordCOntroller,
                    siginNameCOntroller: siginNameCOntroller,
                    siginPhoneCOntroller: siginPhoneCOntroller,
                    siginEmailCOntroller: siginEmailCOntroller,
                    siginPasswordCOntroller: siginPasswordCOntroller,
                    loginClick: () => _loginCheck(context),
                    siginOnClick: () => _siginCheck(context),
                    isShowLogin: isShowLogin,
                    isShowSignIn: isShowSignin,
                    onTap: (val) => _changeonTap(val),
                    siginWithGoogle: () => _googleSigin(),
                    siginWithFaceBook: () => _faceBookSigin(),
                    loginWithGoogle: () => _loginWithGoogle(context),
                    loginWithFacebook: () => _loginWithFaceBook(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginSiginTabBarSession extends StatelessWidget {
  const LoginSiginTabBarSession({
    Key? key,
    required this.tabs,
    required this.loginForm,
    required this.siginForm,
    required this.loginEmailCOntroller,
    required this.loginPasswordCOntroller,
    required this.siginNameCOntroller,
    required this.siginPhoneCOntroller,
    required this.siginEmailCOntroller,
    required this.siginPasswordCOntroller,
    required this.loginClick,
    required this.siginOnClick,
    required this.isShowLogin,
    required this.isShowSignIn,
    required this.onTap,
    required this.siginWithGoogle,
    required this.siginWithFaceBook,
    required this.loginWithGoogle,
    required this.loginWithFacebook,
  }) : super(key: key);

  final List<String> tabs;
  final GlobalKey<FormState> loginForm;
  final GlobalKey<FormState> siginForm;
  final TextEditingController loginEmailCOntroller;
  final TextEditingController loginPasswordCOntroller;
  final TextEditingController siginNameCOntroller;
  final TextEditingController siginPhoneCOntroller;
  final TextEditingController siginEmailCOntroller;
  final TextEditingController siginPasswordCOntroller;
  final Function loginClick;
  final Function siginOnClick;
  final Function siginWithGoogle;
  final Function siginWithFaceBook;
  final bool isShowLogin;
  final bool isShowSignIn;
  final Function loginWithGoogle;
  final Function(int?) onTap;
  final Function loginWithFacebook;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: LoginSiginListView(
        tabs: tabs,
        loginForm: loginForm,
        siginForm: siginForm,
        loginEmailCOntroller: loginEmailCOntroller,
        loginPasswordCOntroller: loginPasswordCOntroller,
        siginNameCOntroller: siginNameCOntroller,
        siginPhoneCOntroller: siginPhoneCOntroller,
        siginEmailCOntroller: siginEmailCOntroller,
        siginPasswordCOntroller: siginPasswordCOntroller,
        loginClick: loginClick,
        siginOnClick: siginOnClick,
        isShowLogin: isShowLogin,
        isShowSignIn: isShowSignIn,
        onTap: (val) => onTap(val),
        siginWithGoogle: () => siginWithGoogle(),
        siginWithFacebook: () => siginWithFaceBook(),
        loginWithGoogle: () => loginWithGoogle(),
        loginWithFacebook: () => loginWithFacebook(),
      ),
    );
  }
}

class LoginSiginListView extends StatelessWidget {
  LoginSiginListView({
    Key? key,
    required this.tabs,
    required this.loginForm,
    required this.siginForm,
    required this.loginEmailCOntroller,
    required this.loginPasswordCOntroller,
    required this.siginNameCOntroller,
    required this.siginPhoneCOntroller,
    required this.siginEmailCOntroller,
    required this.siginPasswordCOntroller,
    required this.loginClick,
    required this.siginOnClick,
    required this.isShowLogin,
    required this.isShowSignIn,
    required this.onTap,
    required this.siginWithGoogle,
    required this.siginWithFacebook,
    required this.loginWithGoogle,
    required this.loginWithFacebook,
  }) : super(key: key);

  final List<String> tabs;
  final GlobalKey<FormState> loginForm;
  final GlobalKey<FormState> siginForm;
  final TextEditingController loginEmailCOntroller;
  final TextEditingController loginPasswordCOntroller;
  final TextEditingController siginNameCOntroller;
  final TextEditingController siginPhoneCOntroller;
  final TextEditingController siginEmailCOntroller;
  final TextEditingController siginPasswordCOntroller;
  final Function loginClick;
  final Function siginOnClick;
  final Function siginWithFacebook;
  final Function loginWithGoogle;
  final bool isShowLogin;
  final bool isShowSignIn;
  final Function siginWithGoogle;
  final Function loginWithFacebook;
  final Function(int?) onTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DefaultTabController(
            length: tabs.length,
            child: TabBar(
                labelPadding: const EdgeInsets.all(margin_small_1x),
                onTap: (val) => onTap(val),
                indicatorColor: main_screen_color,
                labelColor: main_screen_color,
                unselectedLabelColor: Colors.black,
                indicatorWeight: indicator_weight,
                tabs: tabs
                    .map((value) => Text(
                          value,
                          style: const TextStyle(
                            fontSize: regular_text_1x,
                          ),
                        ))
                    .toList())),
        Visibility(
            visible: isShowLogin,
            child: LoginView(
              form: loginForm,
              onClick: () => loginClick(),
              loginEmailCOntroller: loginEmailCOntroller,
              loginPasswordCOntroller: loginPasswordCOntroller,
              loginWithGoogle: () => loginWithGoogle(),
              loginWithFacebook: () => loginWithFacebook(),
            )),
        Visibility(
            visible: isShowSignIn,
            child: SiginView(
              form: siginForm,
              onClick: () => siginOnClick(),
              siginNameCOntroller: siginNameCOntroller,
              siginPasswordCOntroller: siginPasswordCOntroller,
              siginEmailCOntroller: siginEmailCOntroller,
              siginPhoneCOntroller: siginPhoneCOntroller,
              siginWithGoogle: () => siginWithGoogle(),
              siginWithFacebook: () => siginWithFacebook(),
            ))
      ],
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({
    Key? key,
    required this.onClick,
    required this.form,
    required this.loginEmailCOntroller,
    required this.loginPasswordCOntroller,
    required this.loginWithGoogle,
    required this.loginWithFacebook,
  }) : super(key: key);
  final GlobalKey<FormState> form;
  final Function onClick;
  final Function loginWithGoogle;
  final Function loginWithFacebook;
  final TextEditingController loginEmailCOntroller;
  final TextEditingController loginPasswordCOntroller;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: margin_medium_1x),
      height: MediaQuery.of(context).size.height * 0.8,
      child: Form(
        key: form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormFieldWidget(
              title: email_title,
              example: example_email,
              controller: loginEmailCOntroller,
              validation: (str) {
                if (str == null || str.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
            const SizedBox(
              height: margin_medium_1x,
            ),
            TextFormFieldWidget(
              title: password_title,
              example: example_password,
              isObscureText: true,
              controller: loginPasswordCOntroller,
              validation: (str) {
                if (str == null || str.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
            const SizedBox(
              height: margin_medium_3x,
            ),
            const FoegetPasswordView(),
            const SizedBox(
              height: margin_medium_3x,
            ),
            ButtonWidget(
              onClick: () => loginWithFacebook(),
              child: const FaceBookLogoView(),
              isGhostButton: true,
              backgroundColor: Colors.transparent,
              borderColor: Colors.black54,
            ),
            const SizedBox(
              height: margin_medium_1x,
            ),
            ButtonWidget(
              onClick: () => loginWithGoogle(),
              child: const GoogleLogoView(),
              isGhostButton: true,
              backgroundColor: Colors.transparent,
              borderColor: Colors.black54,
            ),
            const SizedBox(
              height: margin_medium_1x,
            ),
            ButtonWidget(
                onClick: () => onClick(), child: ButtonTextView(confirm)),
          ],
        ),
      ),
    );
  }
}

class SiginView extends StatelessWidget {
  SiginView({
    Key? key,
    required this.onClick,
    required this.form,
    required this.siginNameCOntroller,
    required this.siginPhoneCOntroller,
    required this.siginEmailCOntroller,
    required this.siginPasswordCOntroller,
    required this.siginWithGoogle,
    required this.siginWithFacebook,
  }) : super(key: key);
  final GlobalKey<FormState> form;
  final Function onClick;
  final Function siginWithGoogle;
  final Function siginWithFacebook;
  final TextEditingController siginNameCOntroller;
  final TextEditingController siginPhoneCOntroller;
  final TextEditingController siginEmailCOntroller;
  final TextEditingController siginPasswordCOntroller;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: margin_medium_1x),
      height: MediaQuery.of(context).size.height * 0.8,
      child: Form(
        key: form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormFieldWidget(
              title: name_title,
              example: name_example,
              controller: siginNameCOntroller,
              validation: (str) {
                if (str == null || str.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
            const SizedBox(
              height: margin_medium_1x,
            ),
            TextFormFieldWidget(
              title: phone_title,
              example: example_phone,
              controller: siginPhoneCOntroller,
              validation: (str) {
                if (str == null || str.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
            const SizedBox(
              height: margin_medium_1x,
            ),
            TextFormFieldWidget(
              title: email_title,
              example: example_email,
              controller: siginEmailCOntroller,
              validation: (str) {
                if (str == null || str.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
            const SizedBox(
              height: margin_medium_1x,
            ),
            TextFormFieldWidget(
              title: password_title,
              example: example_password,
              isObscureText: true,
              controller: siginPasswordCOntroller,
              validation: (str) {
                if (str == null || str.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
            const SizedBox(
              height: margin_medium_1x,
            ),
            ButtonWidget(
              onClick: () => siginWithFacebook(),
              child: const FaceBookLogoView(),
              isGhostButton: true,
              backgroundColor: Colors.transparent,
              borderColor: Colors.black54,
            ),
            const SizedBox(
              height: margin_medium_1x,
            ),
            ButtonWidget(
              onClick: () => siginWithGoogle(),
              child: const GoogleLogoView(),
              isGhostButton: true,
              backgroundColor: Colors.transparent,
              borderColor: Colors.black54,
            ),
            const SizedBox(
              height: margin_medium_1x,
            ),
            ButtonWidget(
                onClick: () => onClick(), child: ButtonTextView(confirm)),
          ],
        ),
      ),
    );
  }
}

class FoegetPasswordView extends StatelessWidget {
  const FoegetPasswordView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      padding: const EdgeInsets.only(top: margin_medium),
      child: const Text(
        forget_password,
        style: TextStyle(fontSize: text_medium_2x, color: Colors.black38),
      ),
    );
  }
}

class GoogleLogoView extends StatelessWidget {
  const GoogleLogoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: margin_medium,
        ),
        Image.asset('images/google.png'),
        const SizedBox(
          width: margin_medium,
        ),
        const Text(
          signin_with_google,
          style: TextStyle(color: Colors.black54, fontSize: regular_text),
        ),
      ],
    );
  }
}

class FaceBookLogoView extends StatelessWidget {
  const FaceBookLogoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: margin_medium,
        ),
        Image.asset('images/fb.png'),
        const SizedBox(
          width: margin_medium,
        ),
        const Text(
          signin_with_faceBook,
          style: TextStyle(color: Colors.black54, fontSize: regular_text),
        ),
      ],
    );
  }
}

class LoginSiginTitleSession extends StatelessWidget {
  const LoginSiginTitleSession({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          main_screen_welcome_title,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: regular_text_2x),
        ),
        Text(
          login_scrren_sub_title,
          style: TextStyle(
              color: Colors.black26,
              fontWeight: FontWeight.w300,
              fontSize: text_medium_1x),
        ),
      ],
    );
  }
}
