// main.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'clod_segmented_control.dart';

const TextStyle _textStylePobre = TextStyle(
  fontWeight: FontWeight.bold,
  color: CupertinoColors.destructiveRed,
);
const TextStyle _textStyleInterm = TextStyle(
  fontWeight: FontWeight.bold,
  color: CupertinoColors.activeOrange,
);
const TextStyle _textStyleIdeal = TextStyle(
  fontWeight: FontWeight.bold,
  color: CupertinoColors.activeGreen,
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
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
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
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
        middle: Text('Score de Salud Cardiovascular Infantil'),
      ),
      child: Center(
        // width: 800,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
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
                    child: const Text(
                      '> 30 días',
                      textAlign: TextAlign.center,
                      style: _textStylePobre,
                    ),
                  ),
                  '2': Container(
                    width: 130,
                    child: const Text(
                      'Interm.',
                      textAlign: TextAlign.center,
                      style: _textStyleInterm,
                    ),
                  ),
                  '1': Container(
                    width: 130,
                    child: const Text(
                      'Nunca',
                      textAlign: TextAlign.center,
                      style: _textStyleIdeal,
                    ),
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
                    child: const Text('BMI',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.black)),
                  ),
                  '3': Container(
                    width: 130,
                    child: const Text(
                      '>percentilo95',
                      textAlign: TextAlign.center,
                      style: _textStylePobre,
                    ),
                  ),
                  '2': Container(
                    width: 130,
                    child: const Text(
                      '85-90 pc',
                      textAlign: TextAlign.center,
                      style: _textStyleInterm,
                    ),
                  ),
                  '1': Container(
                    width: 130,
                    child: const Text('<85', textAlign: TextAlign.center,
                      style: _textStyleIdeal,),
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
                    child: const Text('Actividad física',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.black)),
                  ),
                  '3': Container(
                    width: 130,
                    child: const Text(
                      'Ninguna',
                      textAlign: TextAlign.center,
                      style: _textStylePobre,
                    ),
                  ),
                  '2': Container(
                    width: 130,
                    child: const Text(
                      '0 a 60 min dia',
                      textAlign: TextAlign.center,
                      style: _textStyleInterm,
                    ),
                  ),
                  '1': Container(
                    width: 130,
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text('>60min', textAlign: TextAlign.center,
                        style: _textStyleIdeal,),
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
                    child: const Text('Score dieta sana',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.black)),
                  ),
                  '3': Container(
                    width: 130,
                    child: const Text(
                      '0-1 componentes',
                      textAlign: TextAlign.center,
                      style: _textStylePobre,
                    ),
                  ),
                  '2': Container(
                    width: 130,
                    child: const Text(
                      '2-3 componentes',
                      textAlign: TextAlign.center,
                      style: _textStyleInterm,
                    ),
                  ),
                  '1': Container(
                    width: 130,
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child:
                          Text('4-5 componentes', textAlign: TextAlign.center,
                            style: _textStyleIdeal,),
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
                    child: const Text('Colesterol total',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.black)),
                  ),
                  '3': Container(
                    width: 130,
                    child: const Text(
                      '>200mg/dl',
                      textAlign: TextAlign.center,
                      style: _textStylePobre,
                    ),
                  ),
                  '2': Container(
                    width: 130,
                    child: const Text(
                      '170-190 mg/dl',
                      textAlign: TextAlign.center,
                      style: _textStyleInterm,
                    ),
                  ),
                  '1': Container(
                    width: 130,
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text('<200mg/dl', textAlign: TextAlign.center,
                        style: _textStyleIdeal,),
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
                    child: const Text('Presion arterial',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.black)),
                  ),
                  '3': Container(
                    width: 130,
                    child: const Text(
                      '>percentilo95',
                      textAlign: TextAlign.center,
                      style: _textStylePobre,
                    ),
                  ),
                  '2': Container(
                    width: 130,
                    child: const Text(
                      '90-95 pc',
                      textAlign: TextAlign.center,
                      style: _textStyleInterm,
                    ),
                  ),
                  '1': Container(
                    width: 130,
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text('<90pc', textAlign: TextAlign.center,
                        style: _textStyleIdeal,),
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
                    child: const Text('Glucemia',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.black)),
                  ),
                  '3': Container(
                    width: 130,
                    child: const Text(
                      '>126 mg/dl',
                      textAlign: TextAlign.center,
                      style: _textStylePobre,
                    ),
                  ),
                  '2': Container(
                    width: 130,
                    child: const Text(
                      '100-125 mg/dl',
                      textAlign: TextAlign.center,
                      style: _textStyleInterm,
                    ),
                  ),
                  '1': Container(
                    width: 130,
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text('<100 mg/dl', textAlign: TextAlign.center,
                        style: _textStyleIdeal,),
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
                      style: const TextStyle(
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
