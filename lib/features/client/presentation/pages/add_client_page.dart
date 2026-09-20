import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_made/core/theme/app_pallete.dart';
import 'package:tailor_made/core/utils/show_snackbar.dart';
import 'package:tailor_made/core/validators/app_validators.dart';
import 'package:tailor_made/features/client/presentation/widgets/form_input.dart';
import 'package:tailor_made/features/client/presentation/bloc/client_bloc.dart';
import 'package:tailor_made/features/client/presentation/widgets/form_dropdown_menu.dart';
import 'package:tailor_made/core/constants/enums.dart';
import 'package:tailor_made/features/client/presentation/pages/clients_list_page.dart';

class AddClientPage extends StatefulWidget {
  const AddClientPage({super.key});

  Route route() => MaterialPageRoute(
      builder: (BuildContext context) => const AddClientPage());

  @override
  State<AddClientPage> createState() => _AddClientPageState();
}

class _AddClientPageState extends State<AddClientPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final genderController = TextEditingController();
  String gender = "";
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void saveClient() {
    context.read<ClientBloc>().add(
          ClientSave(
            firstName: firstNameController.text.trim(),
            lastName: lastNameController.text.trim(),
            email: emailController.text.trim(),
            address: addressController.text.trim(),
            phoneNumber: phoneController.text.trim(),
            gender: gender,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create New Client",
        ),
      ),
      body: BlocListener<ClientBloc, ClientState>(
        listenWhen: (previous, current) {
          return previous != current;
        },
        listener: (context, state) {
          if (state is ClientFailure) {
            showSnackBar(
              context: context,
              text: state.error,
              color: Colors.red,
            );

            context.read<ClientBloc>().add(ClientReset());
          } else if (state is ClientSaveSuccess) {
            Navigator.push(
              context,
              const ClientsListPage().route(),
            );
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            // child: Card(
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const CircleAvatar(
                          maxRadius: 125,
                          backgroundColor: AppPallete.greyColor,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: FormInput(
                                controller: firstNameController,
                                label: "First Name",
                                hintText: "Anne",
                                validator: AppValidators.requiredField,
                              ),
                            ),
                            Expanded(
                              child: FormInput(
                                controller: lastNameController,
                                label: "Last Name",
                                hintText: "Yiadom",
                                validator: AppValidators.requiredField,
                              ),
                            ),
                          ],
                        ),
                        FormInput(
                          controller: phoneController,
                          label: "Phone Number",
                          hintText: "0243456789",
                          inputType: TextInputType.number,
                          validator: AppValidators.requiredField,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: FormDropDownMenu(
                                label: "Gender",
                                hintText: "--Select Client Gender--",
                                controller: genderController,
                                onSelected: (value) {
                                  setState(() {
                                    gender = value;
                                  });
                                },
                                items: Gender.values,
                              ),
                            ),
                            Expanded(
                              child: FormInput(
                                controller: emailController,
                                label: "Email",
                                hintText: "AnneAtoubi@gmail.com",
                                validator: AppValidators.requiredField,
                              ),
                            )
                          ],
                        ),
                        FormInput(
                          controller: addressController,
                          label: "Address",
                          hintText: "Maame Sekune, Community 1, Tema",
                          validator: AppValidators.requiredField
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 60),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              saveClient();
                            }
                          },
                          child: const Text("Save"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // ),
          ),
        ),
      ),
    );
  }
}
