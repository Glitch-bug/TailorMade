import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_made/features/client/presentation/bloc/client_bloc.dart';
import 'package:tailor_made/features/client/domain/entities/client.dart';
import 'package:tailor_made/features/client/presentation/widgets/form_input.dart';

class ClientMeasurements extends StatefulWidget {
  final VoidCallback close;
  final Client? client;
  const ClientMeasurements({
    required this.close,
    required this.client,
    super.key,
  });

  @override
  State<ClientMeasurements> createState() => ClientMeasurementsState();
}

class ClientMeasurementsState extends State<ClientMeasurements> {
  Map<String, dynamic>? measurements;
  Map<String, dynamic> newMeasurements = {};
  List<String> keys = [];
  List<TextEditingController> controllers = [];
  var edit = false;

  @override
  void initState() {
    super.initState();
    measurements = widget.client?.measurements;
    keys = measurements?.keys.toList() ?? [];
    controllers = keys.map((key) {
      return TextEditingController(text: measurements?[key]);
    }).toList();
    // .cast<TextEditingController>();
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void resetMeasurements() {
    for (var i = 0; i < keys.length; i++) {
      controllers[i].text = measurements?[keys[i]];
    }
  }

  void updateMeasurements() {
    for (var i = 0; i < keys.length; i++) {
      newMeasurements?[keys[i]] = controllers[i].text;
    }
  }

  void editMeasurements() {
    updateMeasurements();

    context.read<ClientBloc>().add(ClientMeasurementsEdit(
          id: widget.client?.id ?? "",
          measurements: newMeasurements,
        ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<ClientBloc, ClientState>(
        listener: (context, state) {
          switch(state) {
            case ClientMeasurementsEditSuccess _:
              setState(() {
                edit = !edit;
                measurements = newMeasurements;
              });
            default: 
              (){};
          }
        },
        builder: (context, state) {
          return SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: widget.close,
                      ),
                      Visibility(
                        visible: !edit,
                        child: IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          onPressed: () {
                            edit = !edit;
                            resetMeasurements();
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  (!edit)
                      ? SizedBox(
                          height: size.height * 0.85,
                          width: size.width,
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(keys[index]),
                                subtitle: Text(measurements?[keys[index]]),
                              );
                            },
                            separatorBuilder: (context, index) {
                              // (!edit){}
                              return Visibility(
                                visible: !edit,
                                child: Divider(
                                  indent: size.width * 0.04,
                                  endIndent: size.width * 0.04,
                                ),
                              );
                            },
                            itemCount: keys.length,
                          ),
                        )
                      : Form(
                          child: SizedBox(
                            height: size.height * 0.85,
                            child: ListView.builder(
                              itemCount: keys.length,
                              itemBuilder: (contex, index) {
                                return FormInput(
                                  label: keys[index],
                                  controller: controllers[index],
                                );
                              },
                            ),
                          ),
                        ),
                  Visibility(
                    visible: edit,
                    child: Row(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              edit = !edit;
                              resetMeasurements();
                              setState(() {});
                            },
                            child: const Text("Discard"),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                editMeasurements();
                              },
                              child: const Text("Save"))
                        ]),
                  ),
                ]),
          );
        });
  }
}
