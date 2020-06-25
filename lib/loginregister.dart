import 'package:blogger/Authentication.dart';
import 'package:flutter/material.dart';

class LoginRegister extends StatefulWidget {
  @override
  _LoginRegisterState createState() => _LoginRegisterState();
  final AuthImplementation auth;
  final VoidCallback onSignedIn;

  LoginRegister({
    this.auth,
    this.onSignedIn,
});

}

enum FormType{
  login,
  register
}

class _LoginRegisterState extends State<LoginRegister> {
  final formkey =new GlobalKey<FormState>();
  FormType _formType=FormType.login;
  String _formtype="";
  String _email="";
  String _password="";

  //methods
  bool verifyandsave(){
    final form=formkey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    else{
      return false;
    }

  }

  void validateAndSubmit() async{

    if(verifyandsave()){
      try{
        if(_formType==FormType.login){
          String userId = await widget.auth.SignIn(_email, _password);
          print("login userId = "+userId);
        }else{
          String userId = await widget.auth.SignUp(_email, _password);
          print("Register userId = "+userId);
        }

        widget.onSignedIn();
      }catch(e){
          print("Error = "+e.toString());
      }
    }

  }

  void movetoregister(){
    formkey.currentState.reset();
    setState(() {
      _formType= FormType.register;
    });
  }
  void movetoLogin(){
    formkey.currentState.reset();
    setState(() {
      _formType= FormType.login;
    });
  }



  //Design
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Flutter blog app"),
      ),
      body: new Container(
        margin: EdgeInsets.all(15.0),
        child: new Form(
          key:formkey,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: createwidget() + createButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> createwidget() {
    return [
      SizedBox(
        height: 10.0,
      ),
      SizedBox(
        height: 20.0,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: "Email"),
        validator: (value){
          return value.isEmpty?'Email is required':null;
        },

        onSaved: (value){
          return _email=value;
        },
      ),
      SizedBox(
        height: 20.0,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: "Password"),
        obscureText: true,
        validator: (value){
          return value.isEmpty?'Password is required':null;
        },

        onSaved: (value){
          return _password =value;
        },
      ),
      SizedBox(
        height: 20.0,
      ),
    ];
  }

  List<Widget> createButtons() {
    if(_formType==FormType.login){
      return [
        new RaisedButton(
          child: new Text(
            "Login",
            style: new TextStyle(fontSize: 20.0),
          ),
          textColor: Colors.white,
          color: Colors.red,
          onPressed: validateAndSubmit,
        ),
        new FlatButton(
          child: new Text(
            "Don't have an account? Create a new one",
            style: new TextStyle(fontSize: 10.0),
          ),
          textColor: Colors.white,
          color: Colors.orange,
          onPressed: movetoregister,
        )
      ];
    }

    else{
      return [
        new RaisedButton(
          child: new Text(
            "Create an Account",
            style: new TextStyle(fontSize: 20.0),
          ),
          textColor: Colors.white,
          color: Colors.red,
          onPressed: validateAndSubmit,
        ),
        new FlatButton(
          child: new Text(
            "Already have an account? Login",
            style: new TextStyle(fontSize: 10.0),
          ),
          textColor: Colors.white,
          color: Colors.orange,
          onPressed: movetoLogin,
        )
      ];
    }
  }

  Widget logo() {
    return new Hero(
      child: new CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 110.0,
      ),
    );
  }
}
