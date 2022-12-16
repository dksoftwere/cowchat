import 'package:cowchat/constants.dart';
import 'package:cowchat/screen/DashboardScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:twitter_login/twitter_login.dart';

import '../services/SharedPreferenceHelper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

//new
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  UserCredential? user;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Welcome back',
          style: boldTextStyle(size: 16),
        ),
        leading: BackButton(
          color: Colors.black,
        ),
        elevation: 0.6,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Container(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 100,
                    width: 100,
                    fit: BoxFit.fill,
                  ),
                  padding: EdgeInsets.all(10.0),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              /*email*/ SizedBox(
                width: double.infinity,
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email or Phone number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    prefixIcon: const Icon(
                      Icons.email,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              /*password*/ SizedBox(
                width: double.infinity,
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    suffixIcon: const Icon(
                      Icons.remove_red_eye,
                    ),
                    prefixIcon: const Icon(
                      Icons.lock,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    child: Text(
                      'Forgot password?',
                      style: boldTextStyle(size: 16, color: CWPrimaryColor),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              Container(
                width: 350,
                decoration: boxDecorationRoundedWithShadow(
                  8,
                  backgroundColor: CWPrimaryColor,
                  shadowColor: Colors.grey.withOpacity(0.2),
                ),
                child: MaterialButton(
                  onPressed: () async {
                    if (!emailController.text.validateEmail()) {
                      Fluttertoast.showToast(msg: 'Enter valid email');
                      return;
                    }
                    try {
                      user = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: emailController.text.toString(),
                              password: passwordController.text.toString());
                      SharedPreferenceHelper()
                          .setName(user!.user!.displayName.toString());
                      SharedPreferenceHelper()
                          .setEmail(user!.user!.email.toString());
                      SharedPreferenceHelper()
                          .setImageUrl(user!.user!.photoURL.toString());
                      setState(() {});
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardScreen(0)),
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        Fluttertoast.showToast(
                            msg: 'No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        Fluttertoast.showToast(
                            msg: 'Wrong password provided for that user.');
                      }
                    }
                  },
                  child: Text(
                    'Log in',
                    style: boldTextStyle(
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Opacity(
                opacity: 0.5,
                child: Text(
                  'OR',
                  style: boldTextStyle(size: 16),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                        onTap: (() async {
                          user = await signInWithGoogle();
                          SharedPreferenceHelper()
                              .setName(user!.user!.displayName.toString());
                          SharedPreferenceHelper()
                              .setEmail(user!.user!.email.toString());
                          SharedPreferenceHelper()
                              .setImageUrl(user!.user!.photoURL.toString());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DashboardScreen(0)),
                          );
                        }),
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: const BoxDecoration(
                              color: CWPrimaryColor, shape: BoxShape.circle),
                          child: const Image(
                            image: AssetImage('assets/images/google.png'),
                            color: Colors.white,
                          ),
                        )),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                        onTap: (() async {
                          user = await signInWithFacebook();
                          print(user!.additionalUserInfo!.username);
                          print(user!.additionalUserInfo!.profile!);
                          print(user!.additionalUserInfo!.isNewUser);
                          print(user!.additionalUserInfo!.providerId);
                          print(user!.user!.displayName);
                          print(user!.user!.uid);
                          print(user!.user!.email);
                          print(user!.user!.emailVerified);
                          print(user!.user!.photoURL);
                          print(user!.user!.phoneNumber);
                          SharedPreferenceHelper()
                              .setName(user!.user!.displayName.toString());
                          SharedPreferenceHelper()
                              .setEmail(user!.user!.email.toString());
                          SharedPreferenceHelper()
                              .setImageUrl(user!.user!.photoURL.toString());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DashboardScreen(0)),
                          );
                        }),
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: const BoxDecoration(
                              color: CWPrimaryColor, shape: BoxShape.circle),
                          child: const Image(
                            image: AssetImage('assets/images/facebook.png'),
                            color: Colors.white,
                          ),
                        )),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                        onTap: (() async {
                          user = await signInWithTwitter();
                          SharedPreferenceHelper()
                              .setName(user!.user!.displayName.toString());
                          SharedPreferenceHelper()
                              .setEmail(user!.user!.email.toString());
                          SharedPreferenceHelper()
                              .setImageUrl(user!.user!.photoURL.toString());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DashboardScreen(0)),
                          );
                        }),
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: const BoxDecoration(
                              color: CWPrimaryColor, shape: BoxShape.circle),
                          child: const Image(
                            image: AssetImage('assets/images/twitter.png'),
                            color: Colors.white,
                          ),
                        )),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: (() async {
                        user = await signInWithGitHub();
                        SharedPreferenceHelper()
                            .setName(user!.user!.displayName.toString());
                        SharedPreferenceHelper()
                            .setEmail(user!.user!.email.toString());
                        SharedPreferenceHelper()
                            .setImageUrl(user!.user!.photoURL.toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DashboardScreen(0)),
                        );
                      }),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: const BoxDecoration(
                            color: CWPrimaryColor, shape: BoxShape.circle),
                        child: const Image(
                          image: AssetImage(
                            'assets/images/github.png',
                          ),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: secondaryTextStyle(size: 16),
                  ),
                  TextButton(
                    child: Text(
                      'Sign up',
                      style: boldTextStyle(color: CWPrimaryColor, size: 14),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await firebaseAuth.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    // UserCredential
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();
    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return await firebaseAuth.signInWithCredential(facebookAuthCredential);
  }

  Future<UserCredential> signInWithTwitter() async {
    // Create a TwitterLogin instance
    final twitterLogin = TwitterLogin(
        apiKey: '5AHuYOIzmeiZIYphRL02YocMv',
        apiSecretKey: 'ziIWFWrv3hCNbSJCtHWWGWQx1W8nQyM60a1nfKSUlRdyXGFspy',
        redirectURI: 'cowchat://');

    // Trigger the sign-in flow
    final authResult = await twitterLogin.loginV2();
    print(authResult.errorMessage);
    print(authResult.status);
    print(authResult.user!.name);
    print(authResult.authToken);
    print(authResult.authTokenSecret);
    // Create a credential from the access token
    final twitterAuthCredential = TwitterAuthProvider.credential(
      accessToken: authResult.authToken!,
      secret: authResult.authTokenSecret!,
    );

    // Once signed in, return the UserCredential
    return await firebaseAuth.signInWithCredential(twitterAuthCredential);
  }

//github login
  Future<UserCredential> signInWithGitHub() async {
    // Create a GitHubSignIn instance
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
        clientId: 'd0ef9d1fa0452a10f21a',
        clientSecret: '0092d59d5fef32a22bee6b00efa090643266f4af',
        redirectUrl: 'https://cowchat-a4bf5.firebaseapp.com/__/auth/handler');

    // Trigger the sign-in flow
    final result = await gitHubSignIn.signIn(context);

    // Create a credential from the access token
    final githubAuthCredential = GithubAuthProvider.credential(result.token!);

    // Once signed in, return the UserCredential
    return await firebaseAuth.signInWithCredential(githubAuthCredential);
    ;
  }

  void signOut() async {
    await firebaseAuth.signOut().then((value) => {
          setState(() {
            user = null;
          })
        });
  }
}
