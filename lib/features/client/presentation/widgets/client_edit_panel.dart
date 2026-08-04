import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_made/core/constants/strings.dart';
import 'package:tailor_made/core/constants/enums.dart';
import 'package:tailor_made/features/client/domain/entities/client.dart';
import 'package:tailor_made/features/client/presentation/widgets/form_input.dart';
import 'package:tailor_made/features/client/presentation/widgets/form_dropdown_menu.dart';
import 'package:tailor_made/features/client/presentation/bloc/client_bloc.dart';

class ClientEditPanel extends StatefulWidget {
  final Client? client;
  final VoidCallback onClose;
  const ClientEditPanel(
      {required this.client, required this.onClose, super.key});

  @override
  State<ClientEditPanel> createState() => ClientEditPanelState();
}

class ClientEditPanelState extends State<ClientEditPanel> {
  var phoneNumber = TextEditingController();
  var address = TextEditingController();
  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var email = TextEditingController();
  var gender = TextEditingController();
  ClientEditPanelState();

  @override
  void initState() {
    super.initState();
    phoneNumber.text = widget.client?.phoneNumber ?? "";
    address.text = widget.client?.address ?? "";
    firstName.text = widget.client?.firstName ?? "";
    lastName.text = widget.client?.lastName ?? "";
    email.text = widget.client?.email ?? "";
    gender.text = widget.client?.gender.value ?? "";
  }

  @override
  void dispose() {
    phoneNumber.dispose();
    email.dispose();
    firstName.dispose();
    lastName.dispose();
    address.dispose();
    super.dispose();
  }

  void editClient() {
    context.read<ClientBloc>().add(ClientEdit(
          id: widget.client?.id ?? "",
          firstName: firstName.text,
          lastName: lastName.text,
          address: address.text,
          email: email.text,
          gender: Gender.fromTitle(gender.text),
          phoneNumber: phoneNumber.text,
        ));
  }

  // final phoneNumber = TextEditingController(text: client.phoneNumber);
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = TextTheme.of(context);
    return Column(
      children: [
        Row(
          // alignment: Alignment.topLeft,
          children: [
            IconButton(
              onPressed: widget.onClose,
              icon: const Icon(Icons.close),
            ),
            const Spacer(
              flex: 1,
            ),
            Text(
              "Edit Client Details",
              style: textTheme.bodyMedium,
            ),
            const Spacer(
              flex: 3,
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(radius: 35),
              SizedBox(
                width: 205,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(130, 30),
                          maximumSize: const Size(130, 35),
                          backgroundColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          shape: const BeveledRectangleBorder(
                              side: BorderSide(color: Colors.grey, width: 0.4))
                          // border
                          ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Icon(Icons.file_upload_outlined,
                              size: 14, color: Colors.white),
                          Text("Upload image", style: textTheme.bodySmall),
                        ],
                      ),
                    ),
                    Text(
                      AppStrings.supportImages,
                      style: textTheme.bodySmall?.copyWith(
                        // fontWeight: FontWeight.w200,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        FormInput(
          label: "First Name",
          controller: firstName,
        ),
        FormInput(
          label: "Last Name",
          controller: lastName,
        ),
        FormInput(
          label: "Phone Number",
          controller: phoneNumber,
        ),
        FormDropDownMenu(
            label: "Gender", items: Gender.values, controller: gender),
        FormInput(
          label: "Email",
          controller: email,
        ),
        FormInput(
          label: "Address",
          controller: address,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
              ),
              onPressed: widget.onClose,
              child: const Text("Discard"),
            ),
            ElevatedButton(
              onPressed: () {
                editClient();
                widget.onClose();
              },
              child: const Text("Save"),
            ),
          ],
        )
      ],
    );
  }
}
