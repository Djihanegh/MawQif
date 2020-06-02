import 'package:flutter/material.dart';
import 'package:mawqif/src/models/user.dart';
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
  //final _imageUrlController = TextEditingController();
  //final _imageUrlFocusNode = FocusNode();
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
    'immatriculations':'',
    'password':''
  };
  var _isInit = true;
  var _isLoading = false;
  
     

  @override
  void initState() {
   // _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  /*@override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          // 'imageUrl': _editedProduct.imageUrl,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }*/

 /* @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }*/

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
      /*try {
        await Provider.of<Users>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (error) {*/
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
     // }
      // finally {
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   Navigator.of(context).pop();
      // }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
    // Navigator.of(context).pop();
  }

  

  @override
  Widget build(BuildContext context) {

   /* FirebaseAuth.instance.currentUser().then((val) {
      UserUpdateInfo updateUser = UserUpdateInfo();
      updateUser.displayName = myFullName;
      updateUser.photoUrl = picURL;
      val.updateProfile(updateUser);
    });*/
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blueGrey[800],),
        title: Text('Modifier le profile' , style: TextStyle(color: Colors.blueGrey[800]),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            color: Colors.blueGrey[800],
            onPressed: 
            _saveForm,
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
                            password:  _editedProduct.password
                            );
                            //: _editedProduct.isFavorite);
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
                       /* if (double.tryParse(value) == null) {
                          return 'Please enter a valid number.';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Please enter a number greater than zero.';
                        }*/
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = User(
                            nom: _editedProduct.nom,
                            prenom: value,
                            email: _editedProduct.email,
                            immatriculations: _editedProduct.immatriculations,
                            telephone: _editedProduct.telephone,
                            password:  _editedProduct.password);
                           
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
                            password: _editedProduct.password );
 
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
                        /*if (value.length < 10) {
                          return 'Email d.';
                        }*/
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = User(
                             nom: _editedProduct.nom,
                            prenom: _editedProduct.prenom,
                            email: _editedProduct.email,
                            immatriculations: _editedProduct.immatriculations,
                            telephone: value,
                            password: _editedProduct.password );
 
                      },
                    ),
                     /*TextFormField(
                      initialValue: _initValues['immatriculation'],
                      decoration: InputDecoration(labelText: 'N° immatriculation de votre véhicule'),
                      maxLines: 1,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Entrez un numéro dimmatriculation.';
                        }
                        /*if (value.length < 10) {
                          return 'Email d.';
                        }*/
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = User(
                             nom: _editedProduct.nom,
                            prenom: _editedProduct.prenom,
                            email: _editedProduct.email,
                            immatriculations: value,
                            telephone: value,
                            password: _editedProduct.password );
 
                      },
                    ),*/
                  /*  Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Text('Enter a URL')
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onFieldSubmitted: (_) {
                              //_saveForm();
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter an image URL.';
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'Please enter a valid URL.';
                              }
                              if (!value.endsWith('.png') &&
                                  !value.endsWith('.jpg') &&
                                  !value.endsWith('.jpeg')) {
                                return 'Please enter a valid image URL.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                             /* _editedProduct = Product(
                                title: _editedProduct.title,
                                price: _editedProduct.price,
                                description: _editedProduct.description,
                                imageUrl: value,
                                id: _editedProduct.id,
                                isFavorite: _editedProduct.isFavorite,
                              );*/
                            },
                          ),
                        ),
                      ],
                    ),*/
                  ],
                ),
              ),
            ),
    );
  }
}
