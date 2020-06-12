import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController controladorAltura = TextEditingController();
  TextEditingController controladorPeso = TextEditingController();

  String _infotext = 'Insira seus dados!!';

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _reset(){
    setState(() {
      controladorAltura.text = '';
      controladorPeso.text = '';
      formKey = GlobalKey<FormState>();
      _infotext = 'Insira seus dados!!';
    });
  }

  void _calcular(){
    setState(() {
      double peso = double.parse(controladorPeso.text);
      double altura = double.parse(controladorAltura.text) / 100;
      double imc = peso / (altura * altura);
      if (imc < 18.5){
        _infotext = "Abaixo do peso, seu imc é ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 18.5 && imc < 25){
        _infotext = "Peso ideal, seu imc é ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 25 && imc < 30){
        _infotext = "Sobrepeso, seu imc é ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 30 && imc < 35){
        _infotext = "Obesidade grau I, seu imc é ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 35 && imc < 40){
        _infotext = "Obesidade grau II, seu imc é ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 40){
        _infotext = "Obesidade grau III, seu imc é ${imc.toStringAsPrecision(3)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          "Calculadora de IMC"
        ),
        actions: <Widget>[
          IconButton(
            onPressed: _reset,
            icon: Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person,
                size: 150.0,
                color: Colors.green,
              ),
              TextFormField(
                validator: (value){
                  if (value.isEmpty){
                    return "Insira o seu peso!";
                  }
                },
                controller: controladorPeso,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (Kg)",
                  labelStyle: TextStyle(
                    color: Colors.green,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25.0
                ),
              ),
              TextFormField(
                validator: (value){
                  if (value.isEmpty){
                    return "Insira sua altura!";
                  }
                },
                controller: controladorAltura,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (Cm)",
                  labelStyle: TextStyle(
                    color: Colors.green
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25.0
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    color: Colors.green,
                    onPressed: (){
                      if (formKey.currentState.validate()){
                        _calcular();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                _infotext,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25.0
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
