import 'package:flutter/material.dart';
import 'package:tailor_made/features/client/domain/entities/client.dart';


class ClientCard extends StatelessWidget {
  const ClientCard({
    super.key,
    required this.client,
  });

  final Client client;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      color: Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle)),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                    "${client.firstName} ${client.lastName}")
              ],
            ),
          ],
        ),
      ),
    );
  }
}