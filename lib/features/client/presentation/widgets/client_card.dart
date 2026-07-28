import 'package:flutter/material.dart';
import 'package:tailor_made/core/theme/app_pallete.dart';
import 'package:tailor_made/features/client/domain/entities/client.dart';

class ClientCard extends StatelessWidget {
  final VoidCallback delete;
  final VoidCallback? onTap;
  final VoidCallback? edit;
  const ClientCard({
    super.key,
    required this.client,
    required this.delete,
    required this.edit,
    this.onTap,
  });

  final Client client;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.zero,
        shape: const BeveledRectangleBorder(),
        // margin: const EdgeInsets.all(10),

        color: AppPallete.secondary,
        // const Color.fromARGB(255, 51, 54, 60),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                backgroundColor: AppPallete.greyColor,
                maxRadius: 50,
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("${client.firstName} ${client.lastName}"),
                ],
              ),
              const Spacer(),
              SizedBox(
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton(onPressed: edit, child: const Text("Edit")),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        showAdaptiveDialog(
                          context: context,
                          builder: (BuildContext con) {
                            return _DeleteClientDialog(onDelete: delete, clientName: client.firstName);
                          },
                        );
                      },
                      child: const Text("Delete"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeleteClientDialog extends StatelessWidget {
  final VoidCallback onDelete;
  final String clientName;
  const _DeleteClientDialog({required this.onDelete, required this.clientName});

  Widget build(BuildContext context) {
    Size window = MediaQuery.of(context).size;
    return Dialog(
        child: Container(
          width: window.width * 0.3,
          height: 100,
            child: Column(children: [
      Text(
          "Are you sure you want to delete all info on $clientName? This action cannot be undone"),
      Row(children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("No"),
        ),
        ElevatedButton(onPressed: (){
          onDelete();
          Navigator.pop(context);
        }, child: Text("Yes"))
      ])
    ])));
  }
}
