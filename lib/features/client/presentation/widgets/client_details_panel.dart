import 'package:flutter/material.dart';
import 'package:tailor_made/features/client/domain/entities/client.dart';

class ClientDetailsPanel extends StatelessWidget {
  final Client client;
  const ClientDetailsPanel({required this.client, super.key});

  @override
  Widget build(BuildContext context){
    return Container(color: Colors.blue, height: 40, width: 40, child: Text(client.firstName));
  }

}