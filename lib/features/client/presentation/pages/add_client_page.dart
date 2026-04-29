import 'package:flutter/material.dart';
import 'package:tailor_made/core/theme/app_pallete.dart';
import 'package:tailor_made/features/client/presentation/widgets/form_input.dart';
import 'package:tailor_made/features/client/presentation/widgets/form_dropdown_menu.dart';
import 'package:tailor_made/features/client/presentation/pages/clients_list_page.dart';

class AddClientPage extends StatelessWidget {
  const AddClientPage({super.key});

  route() => MaterialPageRoute(
      builder: (BuildContext context) => const AddClientPage());

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
                              label: "First Name",
                              hintText: "Anne",
                            ),
                          ),
                          Expanded(
                            child: FormInput(
                              label: "Last Name",
                              hintText: "Yiadom",
                            ),
                          ),
                        ],
                      ),
                      FormInput(
                        label: "Phone Number",
                        hintText: "0243456789",
                        inputType: TextInputType.number,
                      ),
                      Row(
                        children: [
                          const Expanded(
                            child: FormDropDownMenu(
                                label: "Gender",
                                items: [{"label":"Male", "value":"Male"}, {"label":"Female", "value":"Female"}]
                            ),
                          ),
                          Expanded(
                            child: FormInput(
                              label: "Email",
                              hintText: "AnneAtoubi@gmail.com",
                            ),
                          )
                        ],
                      ),
                      FormInput(
                        label: "Address",
                        hintText: "Maame Sekune, Community 1, Tema",
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 40),
                        ),
                        onPressed: (){
                          Navigator.push(
                            context,
                            ClientsListPage.route(),
                          );
                        },
                        child: Text("Save")
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
