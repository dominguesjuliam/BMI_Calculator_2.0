import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields(){
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
    });
  }

  void _calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / pow(height, 2);

      if(imc < 18.6){
        _infoText = "Abaixo do peso (IMC = ${imc.toStringAsPrecision(3)})";
      } else if(imc >= 18.7 && imc <= 24.9){
        _infoText = "Peso ideal (IMC = ${imc.toStringAsPrecision(3)})";
      } else if(imc >= 25 && imc <= 29.9){
        _infoText = "Levemente acimad o peso (IMC = ${imc.toStringAsPrecision(3)})";
      } else if(imc >= 30 && imc <= 34.9){
        _infoText = "Obesidade Grau I (IMC = ${imc.toStringAsPrecision(3)})";
      } else if(imc >= 35 && imc <= 39.9){
        _infoText = "Obesidade Grau II (IMC = ${imc.toStringAsPrecision(3)})";
      } else if(imc >= 40){
        _infoText = "Obesidade Grau III (IMC = ${imc.toStringAsPrecision(3)})";
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.purple.shade100,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
          onPressed: _resetFields,)  
        ], 
      ),
      backgroundColor: Colors.white, 
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.purple,),
              TextFormField(keyboardType: TextInputType.number,
                decoration: InputDecoration(
                labelText: "Peso (kg)",
                labelStyle: TextStyle(color: Colors.purple),),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.purple, fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return "Insira seu peso!";
                  }
                },
              ),
              TextFormField(keyboardType: TextInputType.number,
                decoration: InputDecoration(
                labelText: "Altura (cm)",
                labelStyle: TextStyle(color: Colors.purple),),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.purple, fontSize: 25.0),
                controller: heightController,
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return "Insira sua altura!";
                  }
                },
              ), 
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: SizedBox(
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: (){
                        if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                          _calculate();
                        }
                      },
                    style: ElevatedButton.styleFrom(primary: Colors.purple,),
                    child: Text("Calcular", 
                    style: TextStyle(color: Colors.white, fontSize: 25.0),), 
                  ),
                ),
              ),
              Text(_infoText,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.purple, fontSize: 25.0),)
            ],
          ), 
        )
      )
    );
  }
}