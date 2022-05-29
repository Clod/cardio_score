import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

// Si hay que calcular el percentilo incluir el cálculo en Javascript mediante
// https://pub.dev/packages/flutter_js
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter FormBuilder Demo',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: FormBuilderLocalizations.delegate.supportedLocales,
      home: const CompleteForm(),
    );
  }
}

class CompleteForm extends StatefulWidget {
  const CompleteForm({Key? key}) : super(key: key);

  @override
  CompleteFormState createState() {
    return CompleteFormState();
  }
}

class CompleteFormState extends State<CompleteForm> {
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final _formKey = GlobalKey<FormBuilderState>();
  bool _ageHasError = false;
  bool _genderHasError = false;

  var genderOptions = ['Male', 'Female', 'Other'];

  void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Builder Example')),
      body: FormBuilder(
        key: _formKey,
        // enabled: false,
        onChanged: () {
          _formKey.currentState!.save();
          debugPrint(_formKey.currentState!.value.toString());
        },
        autovalidateMode: AutovalidateMode.disabled,
        initialValue: const {
          'movie_rating': 5,
          'best_language': 'Dart',
          'age': '13',
          'gender': 'Male'
        },
        skipDisabled: true,
        child: ListView(
          children: [
            LimitedBox(
              maxHeight: 80,
              maxWidth: 500,
              child: FormBuilderSegmentedControl(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                ),
                name: 'movie_rating',
                // initialValue: 1,
                // textStyle: TextStyle(fontWeight: FontWeight.bold),
                options: List.generate(5, (i) => i + 1)
                    .map((number) => FormBuilderFieldOption(
                          value: number,
                          child: Text(
                            number.toString(),
                            style:
                                const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ))
                    .toList(),
                onChanged: _onChanged,
              ),
            ),
            LimitedBox(
              maxHeight: 80,
              maxWidth: 500,
              child: FormBuilderSegmentedControl(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                ),
                name: 'movie_rating',
                // initialValue: 1,
                // textStyle: TextStyle(fontWeight: FontWeight.bold),
                options: List.generate(5, (i) => i + 1)
                    .map((number) => FormBuilderFieldOption(
                          value: number,
                          child: Text(
                            number.toString(),
                            style:
                                const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ))
                    .toList(),
                onChanged: _onChanged,
              ),
            ),
            LimitedBox(
              maxHeight: 80,
              maxWidth: 500,
              child: FormBuilderSegmentedControl(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                name: 'movie_rating',
                // initialValue: 1,
                // textStyle: TextStyle(fontWeight: FontWeight.bold),
                options: List.generate(5, (i) => i + 1)
                    .map((number) => FormBuilderFieldOption(
                          value: number,
                          child: Text(
                            number.toString(),
                            style:
                                const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ))
                    .toList(),
                onChanged: _onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
