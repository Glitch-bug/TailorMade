import 'package:flutter/material.dart';
import 'package:tailor_made/features/client/domain/entities/client.dart';
import 'package:tailor_made/features/client/presentation/widgets/client_card.dart';

class ClientList extends StatelessWidget {
  final List<Client> clients;
  final void Function(Client client) edit;
  final void Function(String id) delete;
  final void Function(Client client) select;
  const ClientList(
      {required this.clients,
      required this.edit,
      required this.delete,
      required this.select,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.zero,
      itemCount: clients.length,
      itemBuilder: (context, index) {
        final client = clients[index];
        return Column(children: [
          ClientCard(
            client: client,
            edit: () {
              edit(client);
            },
            delete: () {
              delete(client.id);
            },
            onTap: () {
              select(client);
            },
          ),
          const Divider(
            height: 1,
            indent: 50,
            endIndent: 50,
            // endIndent: 10,
          )
        ]);
      },
    );
  }
}
