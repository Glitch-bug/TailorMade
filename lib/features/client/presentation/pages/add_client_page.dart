import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_made/core/theme/app_pallete.dart';
import 'package:tailor_made/features/client/presentation/widgets/form_input.dart';
import 'package:tailor_made/features/client/presentation/bloc/client_bloc.dart';
import 'package:tailor_made/features/client/presentation/widgets/form_dropdown_menu.dart';
import 'package:tailor_made/core/constants/enums.dart';
import 'package:tailor_made/features/client/presentation/pages/clients_list_page.dart';


class AddClientPage extends StatefulWidget {
  const AddClientPage({super.key});

  route() => MaterialPageRoute(
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
        gender: Gender.fromValue(gender),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shadowColor: AppPallete.greyColor,
            child: SizedBox(
              width: 900,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  child: Column(
                    children: [
                      Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(500),
                          color: AppPallete.greyColor,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: FormInput(
                              controller: firstNameController,
                              label: "First Name",
                              hintText: "Anne",
                            ),
                          ),
                          Expanded(
                            child: FormInput(
                              controller: lastNameController,
                              label: "Last Name",
                              hintText: "Yiadom",
                            ),
                          ),
                        ],
                      ),
                      FormInput(
                        controller: phoneController,
                        label: "Phone Number",
                        hintText: "0243456789",
                        inputType: TextInputType.number,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: FormDropDownMenu(
                              label: "Gender",
                              hintText: "--Select Client Gender--",
                              controller: genderController,
                              onSelected: (value){
                                setState(() {
                                  gender = value;
                                });

                                print(gender);
                              },
                              items: [
                                {
                                  "label": Gender.male.title,
                                  "value": Gender.male.value,
                                },
                                {
                                  "label":Gender.female.title,
                                  "value": Gender.female.value,
                                }
                              ],
                            ),
                          ),
                          Expanded(
                            child: FormInput(
                              controller: emailController,
                              label: "Email",
                              hintText: "AnneAtoubi@gmail.com",
                            ),
                          )
                        ],
                      ),
                      FormInput(
                        controller: addressController,
                        label: "Address",
                        hintText: "Maame Sekune, Community 1, Tema",
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 60),
                        ),
                        onPressed: () {
                          
                          saveClient();

                          Navigator.push(
                            context,
                            ClientsListPage.route(),
                          );
                        },
                        child: const Text("Save"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
