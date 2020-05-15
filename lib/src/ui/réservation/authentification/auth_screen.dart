import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mawqif/src/models/user.dart';
import 'package:mawqif/src/providers/connection_provider/authh.dart';
import 'package:mawqif/src/ui/réservation/réservation_screen.dart';
import 'package:mawqif/src/utils/animations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/Exceptions.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';
  static int codeP = 0;
  static User user = User(uid: null);
  static List<User> usersIn = new List();

  AuthScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  AuthScreenState createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    if (value != '0') {
      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new Reservation(),
      ));
    }
  }

  @override
  initState()  {
   // read();
  }

  @override
  Widget build(BuildContext context) {
    //final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    /* return Scaffold(
        // resizeToAvoidBottomInset: false,
        //appBar: AppBar(actions: <Widget>[ IconButton(icon:Icon(Icons.cancel), onPressed: () {},)],),
        body: SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Text(
              "Pour accéder à vos réservations, veuillez vous connecter ou créer un compte.",
              style: TextStyle(color: Colors.blueGrey[300], fontSize: 15),
            ),
          ),
          Container(
            height: 5,
          ),
          SingleChildScrollView(
            child: Container(
              height: 350,
              width: deviceSize.width,
              child: Column(
                children: <Widget>[
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));*/

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: AuthCard());
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  var authHandler = new Auth();

  String error = '';
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  Map<String, String> _userData = {
    'telephone': '',
    'nom': '',
    'prenom': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  final emailController = TextEditingController();

  Auth _auth = Auth();

  Future<void> addUser(User user) async {
    //AuthScreen.codeP++;

    try {
      Firestore.instance.collection("users").add({
        "codeP": user.codePersonnel,
        "userInfo": user.uid,
        "nom": user.nom,
        "prenom": user.prenom,
        "telephone": user.telephone,
        "email": user.email,
        "password": user.password,
      });
    } catch (erro) {
      print(erro);
    }
    final newProduct = User(
      codePersonnel: user.codePersonnel,
      uid: user.uid,
    );
    print(newProduct.codePersonnel);
    print(newProduct.uid);
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
      if (_isLoading) {
        CircularProgressIndicator(
          backgroundColor: Colors.blue,
        );
      }
    });
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false).login(
          _authData['email'],
          _authData['password'],
        );
        
       /* Navigator.push(
            context, new MaterialPageRoute(builder: (context) => new MyApp()));*/
      } else {
        // Sign user up
        await Provider.of<Auth>(context, listen: false).signup(
          _authData['email'],
          _authData['password'],
        );
         
          setState(() {
            _switchAuthMode();
          });
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            child: Container(
              child: Image.asset("assets/images/mawqiff.png"),
            ),
            padding: EdgeInsets.only(top: 50, left: 10),
          ),
          Stack(
            children: <Widget>[
              Padding(
                child: Column(
                  children: <Widget>[
                    //  Expanded(child:

                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[100]))),
                      child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "E-mail",
                              hintStyle: TextStyle(color: Colors.grey[400])),
                          validator: (value) {
                            if (value.isEmpty || !value.contains('@')) {
                              return 'Invalid email!';
                            }
                          },
                          onSaved: (value) {
                            _authData['email'] = value;
                            print(_authData['email']);
                          }),
                    ),
//),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                          obscureText: true,
                          controller: _passwordController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Mot de passe",
                              hintStyle: TextStyle(color: Colors.grey[400])),
                          onSaved: (value) {
                            _authData['password'] = value;
                            print(_authData['password']);
                          }),
                    ),
                    if(AuthMode.Signup == _authMode)
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                          enabled: _authMode == AuthMode.Signup,
                          obscureText: true,
                          //controller: _passwordController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Confirmer le mot de passe",
                              hintStyle: TextStyle(color: Colors.grey[400])),
                          validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                          }
                        : null,),
                    )
                  ],
                ),
                padding: EdgeInsets.only(top: 60, left: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                child: FadeAnimation(
                  2,
                  Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue),
                      child: FlatButton(
                        child: Center(child: Text(_authMode == AuthMode.Login
                        ? 'Se connecter'
                        : "S'enregistrer",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onPressed: _submit,
                      )),
                ),
                padding: EdgeInsets.only(top: 300),
              ),
              SizedBox(
                height: 70,
              ),
              Padding(
                child: _isLoading? Center(child:CircularProgressIndicator(backgroundColor: Colors.blue,)): FadeAnimation(
                    1.5,
                    FlatButton(
                        child: Center(
                            child: Text(
                      '${_authMode == AuthMode.Login ? "S'enregistrer" : 'Se connecter'} ',
                          style: TextStyle(color: Colors.blue),
                        )),
                        onPressed: () {
                                    setState(() {
                                      _switchAuthMode();
                                    });
                                    
                        }
                        // },
                        )),
                padding: EdgeInsets.only(top: 380, left: 10),
              )
            ],
          )
        ],
      ),
    );

    /*
    Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.Signup ? 700 : 260,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Nom'),
                    keyboardType: TextInputType.text,
                    onSaved: (value) {
                      _userData['nom'] = value;
                      print(_authData['nom']);
                    },
                  ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Prénom'),
                    keyboardType: TextInputType.text,
                    onSaved: (value) {
                      _userData['prenom'] = value;
                      print(_authData['prenom']);
                    },
                  ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                  },
                  onSaved: (value) {
                    _authData['email'] = value;
                    print(_authData['email']);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Mot de passe'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration:
                        InputDecoration(labelText: 'Confirmer le mot de passe'),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                          }
                        : null,
                  ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                      enabled: _authMode == AuthMode.Signup,
                      decoration:
                          InputDecoration(labelText: 'Numéro de télephone'),
                      //obscureText: true,
                      validator: (value) {
                        if (value.isEmpty || value.length < 10) {
                          return 'Numéro de télephone invalid';
                        }
                      },
                      onSaved: (value) {
                        _userData['telephone'] = value;
                      }),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  RaisedButton(
                    child: Text(_authMode == AuthMode.Login
                        ? 'Se connecter'
                        : "S'enregistrer"),
                    onPressed:
                        /*if (_authMode == AuthMode.Login) {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();

                          setState(() {
                            _isLoading = true;
                            if (_isLoading) {
                              CircularProgressIndicator();
                            }
                          });

                          authHandler
                              .handleSignInEmail(emailController.text,
                                  _passwordController.text)
                              .then((FirebaseUser user) {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new MyApp()));
                          }).catchError((e) => print(e));
                        }
                      } else {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          authHandler
                              .handleSignUp(emailController.text,
                                  _passwordController.text)
                              .then((FirebaseUser user) {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new MyApp()));
                          }).catchError((e) => print(e));
                        }
                      }*/
                        _submit,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryTextTheme.button.color,
                  ),
                FlatButton(
                  child: Text(
                      '${_authMode == AuthMode.Login ? "S'enregistrer" : 'Se connecter'} '),
                  onPressed: _switchAuthMode,
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );*/
  }
}
