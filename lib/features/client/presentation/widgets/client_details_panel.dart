import 'package:flutter/material.dart';
import 'package:tailor_made/features/client/presentation/widgets/item_row.dart';
import 'package:tailor_made/features/client/presentation/pages/measurement_form_page.dart';
import 'package:tailor_made/features/client/domain/entities/client.dart';

class ClientDetailsPanel extends StatelessWidget {
  final Client client;
  final VoidCallback measurements;
  const ClientDetailsPanel(
      {required this.client, required this.measurements, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: const CircleAvatar(
            radius: 70,
            backgroundColor: Colors.white,
          ),
        ),
        SizedBox(
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Item(
                label: "First Name: ",
                item: client.firstName,
              ),
              Item(
                label: "Last Name: ",
                item: client.lastName,
              ),
              Item(
                label: "Phone Number: ",
                item: client.phoneNumber,
              ),
              Item(
                label: "Address: ",
                item: client.address,
              ),
              Item(
                label: "Email: ",
                item: client.email,
              ),
              Item(
                label: "Gender: ",
                item: client.gender.title,
              ),
            ],
          ),
        ),
        SizedBox(height: 30),

  
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              (client.measurements == null)
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MeasurementFormPage(client: client);
                        },
                      ),
                    )
                  : measurements();
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 45)),
            child: (client.measurements == null)
                ? const Text("Enter Measurments")
                : const Text("Measurements"),
          ),
        ),
      ],
    );
  }
}
