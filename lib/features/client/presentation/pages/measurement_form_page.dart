import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_made/core/extensions/iterable_extension.dart';
import 'package:tailor_made/core/extensions/string_extension.dart';
import 'package:tailor_made/features/client/domain/entities/client.dart';
import 'package:tailor_made/features/client/presentation/bloc/client_bloc.dart';
import 'package:tailor_made/features/client/presentation/widgets/form_input.dart';
import 'package:tailor_made/features/client/presentation/pages/clients_list_page.dart';

class MeasurementFormPage extends StatefulWidget {
  final Client client;
  const MeasurementFormPage({required this.client, super.key});

  @override
  State<MeasurementFormPage> createState() => _MeasurementFormPageState();
}

class _MeasurementFormPageState extends State<MeasurementFormPage> {
  late Client client;
  Map<String, dynamic> measurementForm = {};
  List<TextEditingController> controllers = [];
  List<String> keys = [];

  @override
  void initState() {
    super.initState();
    client = widget.client;
    measurementForm = client.gender.measurementForm;
    controllers = [
      for (String item in measurementForm["keys"]) TextEditingController()
    ];
    keys = measurementForm["keys"];
  }


  void saveMeasurement(Map<String, dynamic> measurements) {
    context.read<ClientBloc>().add(
      ClientMeasurementsSave(
        id: client.id,
        measurements: measurements,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Measurement Form"),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return MainBody(
            client: client,
            measurementForm: measurementForm,
            keys: keys,
            controllers: controllers,
            height: constraints.maxHeight,
            save: saveMeasurement,
          );
      }),
    );
  }
}

class MainBody extends StatelessWidget {
  const MainBody({
    super.key,
    required this.client,
    required this.measurementForm,
    required this.keys,
    required this.controllers,
    required this.height,
    required this.save
  });

  final Client client;
  final Map<String, dynamic> measurementForm;
  final List<String> keys;
  final List<TextEditingController> controllers;
  final double height;
  final Function save;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("${client.firstName} ${client.lastName}"),
        Column(
            children: measurementForm.entries.map((entry) {
          if (entry.key.startsWith("_")) {
            return Container();
          } else if (entry.key.startsWith("@")) {
            return Text(
                "${entry.key.substring(1).toTitleCase()}: ${entry.value}");
          } else {
            return const SizedBox();
          }
        }).toList()),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: height - 100,
            child: ListView.builder(
              itemCount: keys.length + 1,
              itemBuilder: (context, i) {
                if (i < keys.length) {
                  return FormInput(
                    label: keys[i],
                    controller: controllers[i],
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Map<String, dynamic>measurements = {};
                        keys.forEachIndexed((index, key){
                          measurements[key] = controllers[index].value.text;
                        });                      
                        save(measurements);
                        Navigator.push(
                          context,
                          ClientsListPage.route()
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("Save"),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        )
      ],
    );
  }
}
