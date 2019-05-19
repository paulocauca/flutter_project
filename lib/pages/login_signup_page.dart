import 'package:apportho/pages/auth_provider.dart';
import 'package:flutter/material.dart';



class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

enum FormType {
  login,
  register
}

class _LoginPageState extends State<LoginPage>{

  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave(){
    final form = formKey.currentState;
    if (form.validate()){
      form.save();
      return true;
    }else{
      return false;
    }
  }

  void validateAndSubmit() async {
      if (validateAndSave()){
        try {
          var auth = AuthProvider.of(context).auth;

          if(_formType == FormType.login){
              String userId = await auth.signInWithEmailAndPassword(_email, _password);
              print('Signed user ${userId}');
          }else{
              String userId = await auth.createUserWithEmailAndPassword(_email, _password);
              print('User ${userId}');
          }
        }
        catch(e){
          print('Error: $e');
        }
      }
  }

  void moveToRegister(){
      formKey.currentState.reset();
      setState(() {
        _formType = FormType.register;
      });
      
  }

  void moveToLogin(){
    formKey.currentState.reset();
    setState(() {
        _formType = FormType.login;
      });
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Realize seu login'),
      ),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildInputs() + buildSubmitButtons(),
          ),
        )

      )
    );
  }

  List<Widget> buildInputs() {
    return [
        new TextFormField(
          decoration: new InputDecoration(labelText: 'Email'),
          validator: (value) => value.isEmpty ? 'Favor inserir e-mail' : null,
          onSaved: (value) => _email = value,
        ),
        new TextFormField(
          decoration: new InputDecoration(labelText: 'Senha'),
          obscureText: true,
          validator: (value) => value.isEmpty ? 'Favor inserir a senha' : null,
          onSaved: (value) => _password = value,
        ),
    ];
  }

  List <Widget> buildSubmitButtons(){
    if(_formType == FormType.login){
      return [
        new RaisedButton(
          child: new Text('Login', style: new TextStyle(fontSize: 20.0)),
          onPressed: validateAndSubmit,
        ),
        new FlatButton(
          child: new Text('Criar Login', style: new TextStyle(fontSize: 20.0)),
          onPressed: moveToRegister,
        )
      ];
    }else {
      return [
        new RaisedButton(
          child: new Text('Crie seu Login', style: new TextStyle(fontSize: 20.0)),
          onPressed: validateAndSubmit,
        ),
        new FlatButton(
          child: new Text('Já possui Login? Login', style: new TextStyle(fontSize: 20.0)),
          onPressed: moveToLogin,
        )
      ];

    }
  }
}