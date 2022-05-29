// main.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'clod_segmented_control.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(fontSize: 12.0),
        ),
      ),
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Score',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _selectedValueFuma;
  String? _selectedValueBMI;
  String? _selectedValueActiFis;
  String? _selectedValueDieta;
  String? _selectedValueColesterol;
  String? _selectedValuePresion;
  String? _selectedValueGlucemia;

  double _puntaje = 0.0;
  String _score = '';
  Color _colorScore = CupertinoColors.black;
  bool _scoreVisible = false;

  _computeScore() {
    debugPrint('***************** Calculando el score *****************');

    if (_selectedValueFuma != null &&
        _selectedValueBMI != null &&
        _selectedValueActiFis != null &&
        _selectedValueDieta != null &&
        _selectedValueColesterol != null &&
        _selectedValuePresion != null &&
        _selectedValueGlucemia != null) {
      _puntaje = (double.parse(_selectedValueFuma!) +
              double.parse(_selectedValueBMI!) +
              double.parse(_selectedValueActiFis!) +
              double.parse(_selectedValueDieta!) +
              double.parse(_selectedValueColesterol!) +
              double.parse(_selectedValuePresion!) +
              double.parse(_selectedValueGlucemia!)) /
          7;
      if (_puntaje == 1) {
        _score = "Ideal";
        _colorScore = CupertinoColors.systemTeal;
      } else if (_puntaje > 1.0 && _puntaje < 1.5) {
        _score = "Leve";
        _colorScore = CupertinoColors.activeGreen;
      } else if (_puntaje >= 1.5 && _puntaje <= 2.0) {
        _score = "Intermedia";
        _colorScore = CupertinoColors.activeOrange;
      } else {
        _score = "Pobre";
        _colorScore = CupertinoColors.destructiveRed;
      }
      _scoreVisible = true;
    }
    debugPrint('Puntaje: $_puntaje');
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Score'),
      ),
      child: Center(
        // width: 800,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20.0,
              ),
              // Header de la tabla
              AbsorbPointer(
                // Encabezado
                child: ClodSegmentedControl(
                  unselectedColor: CupertinoColors.inactiveGray,
                  // selectedColor: CupertinoColors.activeOrange,
                  children: {
                    '0': Container(
                      width: 130,
                      child: const Text('Métrica',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CupertinoColors.black)),
                    ),
                    '3': Container(
                      width: 130,
                      child: const Text('Pobre',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CupertinoColors.black)),
                    ),
                    '2': Container(
                      width: 130,
                      child: const Text('Intermedia',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CupertinoColors.black)),
                    ),
                    '1': Container(
                      width: 130,
                      child: const Text('Ideal',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CupertinoColors.black)),
                    ),
                  },
                  onValueChanged: (String value) {
                    setState(() {
                      _selectedValueFuma = value;
                    });
                  },
                ),
              ),
              // Fuma
              ClodSegmentedControl(
                selectedColor: CupertinoColors.link,
                groupValue: _selectedValueFuma,
                children: {
                  '0': Container(
                    width: 130,
                    child: const Text(
                      'Fuma',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: CupertinoColors.black),
                    ),
                  ),
                  '3': Container(
                    width: 130,
                    child: Text('> 30 días', textAlign: TextAlign.center),
                  ),
                  '2': Container(
                    width: 130,
                    child: Text('Interm.', textAlign: TextAlign.center),
                  ),
                  '1': Container(
                    width: 130,
                    child: Text('Nunca', textAlign: TextAlign.center),
                  ),
                },
                onValueChanged: (String value) {
                  setState(() {
                    _selectedValueFuma = value;
                  });
                  _computeScore();
                },
              ),
              // BMI
              ClodSegmentedControl(
                selectedColor: CupertinoColors.link,
                groupValue: _selectedValueBMI,
                children: {
                  '0': Container(
                    width: 130,
                    child: Text('BMI',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.black)),
                  ),
                  '3': Container(
                    width: 130,
                    child: Text('>percentilo95', textAlign: TextAlign.center),
                  ),
                  '2': Container(
                    width: 130,
                    child: Text('85-90 pc', textAlign: TextAlign.center),
                  ),
                  '1': Container(
                    width: 130,
                    child: Text('<85', textAlign: TextAlign.center),
                  ),
                },
                onValueChanged: (String value) {
                  setState(() {
                    _selectedValueBMI = value;
                  });
                  _computeScore();
                },
              ),
              //Actividad física
              ClodSegmentedControl(
                selectedColor: CupertinoColors.link,
                groupValue: _selectedValueActiFis,
                children: {
                  '0': Container(
                    width: 130,
                    child: Text('Actividad física',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.black)),
                  ),
                  '3': Container(
                    width: 130,
                    child: Text('Ninguna', textAlign: TextAlign.center),
                  ),
                  '2': Container(
                    width: 130,
                    child: Text('0 a 60 min dia', textAlign: TextAlign.center),
                  ),
                  '1': Container(
                    width: 130,
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text('>60min', textAlign: TextAlign.center),
                    ),
                  ),
                },
                onValueChanged: (String value) {
                  setState(() {
                    _selectedValueActiFis = value;
                  });
                  _computeScore();
                },
              ),
              // Dieta sanda
              ClodSegmentedControl(
                selectedColor: CupertinoColors.link,
                groupValue: _selectedValueDieta,
                children: {
                  '0': Container(
                    width: 130,
                    child: Text('Score dieta sana',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.black)),
                  ),
                  '3': Container(
                    width: 130,
                    child:
                        Text('0-1 compononetes', textAlign: TextAlign.center),
                  ),
                  '2': Container(
                    width: 130,
                    child:
                        Text('2-3 compononetes', textAlign: TextAlign.center),
                  ),
                  '1': Container(
                    width: 130,
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child:
                          Text('4-5 componentes', textAlign: TextAlign.center),
                    ),
                  ),
                },
                onValueChanged: (String value) {
                  setState(() {
                    _selectedValueDieta = value;
                  });
                  _computeScore();
                },
              ),
              // Colesterol
              ClodSegmentedControl(
                selectedColor: CupertinoColors.link,
                groupValue: _selectedValueColesterol,
                children: {
                  '0': Container(
                    width: 130,
                    child: Text('Colesterol total',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.black)),
                  ),
                  '3': Container(
                    width: 130,
                    child: Text('>200mg/dl', textAlign: TextAlign.center),
                  ),
                  '2': Container(
                    width: 130,
                    child: Text('170-190 mg/dl', textAlign: TextAlign.center),
                  ),
                  '1': Container(
                    width: 130,
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text('>200mg/dl', textAlign: TextAlign.center),
                    ),
                  ),
                },
                onValueChanged: (String value) {
                  setState(() {
                    _selectedValueColesterol = value;
                  });
                  _computeScore();
                },
              ),
              // Presión
              ClodSegmentedControl(
                selectedColor: CupertinoColors.link,
                groupValue: _selectedValuePresion,
                children: {
                  '0': Container(
                    width: 130,
                    child: Text('Presion arterial',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.black)),
                  ),
                  '3': Container(
                    width: 130,
                    child: Text('>percentilo95', textAlign: TextAlign.center),
                  ),
                  '2': Container(
                    width: 130,
                    child: Text('90-95 pc', textAlign: TextAlign.center),
                  ),
                  '1': Container(
                    width: 130,
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text('<90pc', textAlign: TextAlign.center),
                    ),
                  ),
                },
                onValueChanged: (String value) {
                  setState(() {
                    _selectedValuePresion = value;
                  });
                  _computeScore();
                },
              ),
              // Glucemia
              ClodSegmentedControl(
                selectedColor: CupertinoColors.link,
                groupValue: _selectedValueGlucemia,
                children: {
                  '0': Container(
                    width: 130,
                    child: Text('Glucemia',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.black)),
                  ),
                  '3': Container(
                    width: 130,
                    child: Text('>126 mg/dl', textAlign: TextAlign.center),
                  ),
                  '2': Container(
                    width: 130,
                    child: Text('100-125 mg/dl', textAlign: TextAlign.center),
                  ),
                  '1': Container(
                    width: 130,
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text('<100 mg/dl', textAlign: TextAlign.center),
                    ),
                  ),
                },
                onValueChanged: (String value) {
                  setState(() {
                    _selectedValueGlucemia = value;
                  });
                  _computeScore();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Puntaje
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 10.0, 10.0, 0.0),
                    child: Text(
                      'Puntaje: ${_puntaje.toStringAsFixed(1)}',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.black,
                      ),
                    ),
                  ),
                  // Score
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
                    child: Text(
                      'Score: ',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: _scoreVisible
                            ? CupertinoColors.black
                            : CupertinoColors.systemBackground,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0.0),
                    child: Text(
                      _score,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: _colorScore,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
