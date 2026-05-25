import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_made/core/theme/app_pallete.dart';
import 'package:tailor_made/features/client/domain/entities/client.dart';
import 'package:tailor_made/features/client/presentation/widgets/client_card.dart';
import 'package:tailor_made/features/client/presentation/widgets/client_details_panel.dart';
import 'package:tailor_made/features/client/presentation/bloc/client_bloc.dart';
import 'package:tailor_made/features/client/presentation/pages/add_client_page.dart';

class ClientsListPage extends StatefulWidget {
  const ClientsListPage({super.key});

  static route() => MaterialPageRoute(
      builder: (BuildContext context) => const ClientsListPage());

  @override
  State<ClientsListPage> createState() => _ClientsListPageState();
}

class _ClientsListPageState extends State<ClientsListPage> {
  Client? selected;

  void deleteClient({required String id}) {
    context.read<ClientBloc>().add(ClientErase(id: id));
  }

  void selectClient({required Client client}) {
    selected = client;
    setState((){});
  }

  void getClients() {
    context.read<ClientBloc>().add(ClientFetchAllClients());
  }

  @override
  void initState() {
    super.initState();
    context.read<ClientBloc>().add(ClientFetchAllClients());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false, actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, const AddClientPage().route());
            },
            icon: const Icon(CupertinoIcons.add_circled),
          ),
        ]),
        body: BlocConsumer<ClientBloc, ClientState>(
          listener: (context, state) {
            if (state is ClientDeleteSucces) {
              context.read<ClientBloc>().add(ClientFetchAllClients());
            } else if (state is ClientSaveSuccess) {
              context.read<ClientBloc>().add(ClientFetchAllClients());
            }
          },
          builder: (context, state) {
            if (state is ClientDisplaySuccess && state.clients.isEmpty) {
              return Row(
                children: [
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      color: AppPallete.backgroundColor2,
                    ),
                  ),
                  const Expanded(
                    flex: 2,
                    child: Text(
                      "Your client list is empty",
                    ),
                  ),
                ],
              );
            } else if (state is ClientDisplaySuccess) {
              return Row(
                children: [
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      color: AppPallete.backgroundColor2,
                      child: (selected != null)? ClientDetailsPanel(client: selected!): const SizedBox(),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ListView.builder(
                      itemCount: state.clients.length,
                      itemBuilder: (context, index) {
                        final client = state.clients[index];
                        return ClientCard(
                          client: client,
                          delete: () {
                            deleteClient(id: client.id);
                          },
                          onTap: () {
                            selectClient(client: client);
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
