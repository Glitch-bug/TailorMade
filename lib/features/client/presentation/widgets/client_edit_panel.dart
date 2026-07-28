import 'package:flutter/material.dart';
import 'package:tailor_made/core/constants/strings.dart';
import 'package:tailor_made/features/client/domain/entities/client.dart';
import 'package:tailor_made/features/client/presentation/widgets/form_input.dart';

class ClientEditPanel extends StatelessWidget {
  final Client? client;
  final VoidCallback onClose;
  const ClientEditPanel(
      {required this.client, required this.onClose, super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = TextTheme.of(context);
    return Column(children: [
      Row(
        // alignment: Alignment.topLeft,
        children: [
          IconButton(
            onPressed: onClose,
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
                        shape: BeveledRectangleBorder(
                            side: BorderSide(color: Colors.grey, width: 0.4))
                        // border
                        ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.file_upload_outlined,
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
        label: "Full Name",
      )
    ]);
  }
}
