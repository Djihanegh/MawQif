import 'package:flutter/material.dart';
import 'package:mawqif/src/models/user/user.dart';
import 'package:mawqif/src/providers/connection_provider/authh.dart';
import 'package:mawqif/src/providers/users/users.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  Auth authh = new Auth();

  var _editedProduct = User(
    nom: '',
    prenom: '',
    email: '',
    telephone: '',
    immatriculations: '',
    password: '',
  );
  var _initValues = {
    'nom': '',
    'prenom': '',
    'email': '',
    'telephone': '',
    'immatriculations': '',
    'password': ''
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (authh.userId != null) {
      await Provider.of<Users>(context, listen: false)
          .updateProfile(authh.userId, _editedProduct);
    } else {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text('Something went wrong.'),
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
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.blueGrey[800],
        ),
        title: Text(
          'Modifier le profile',
          style: TextStyle(color: Colors.blueGrey[800]),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            color: Colors.blueGrey[800],
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['nom'],
                      decoration: InputDecoration(labelText: 'Nom'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Entrez un nom svp.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = User(
                            nom: value,
                            prenom: _editedProduct.prenom,
                            email: _editedProduct.email,
                            immatriculations: _editedProduct.immatriculations,
                            telephone: _editedProduct.telephone,
                            password: _editedProduct.password);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['Prénom'],
                      decoration: InputDecoration(labelText: 'Prénom'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Entrez un prénom svp.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = User(
                            nom: _editedProduct.nom,
                            prenom: value,
                            email: _editedProduct.email,
                            immatriculations: _editedProduct.immatriculations,
                            telephone: _editedProduct.telephone,
                            password: _editedProduct.password);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['email'],
                      decoration: InputDecoration(labelText: 'Email'),
                      maxLines: 1,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Entrez un email svp.';
                        }
                        if (value.length < 10) {
                          return 'Email doit etre au moins 10 caractères.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = User(
                            nom: _editedProduct.nom,
                            prenom: _editedProduct.prenom,
                            email: value,
                            immatriculations: _editedProduct.immatriculations,
                            telephone: _editedProduct.telephone,
                            password: _editedProduct.password);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['telephone'],
                      decoration: InputDecoration(labelText: 'Téléphone'),
                      maxLines: 1,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Entrez un numéro de téléphone.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = User(
                            nom: _editedProduct.nom,
                            prenom: _editedProduct.prenom,
                            email: _editedProduct.email,
                            immatriculations: _editedProduct.immatriculations,
                            telephone: value,
                            password: _editedProduct.password);
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
