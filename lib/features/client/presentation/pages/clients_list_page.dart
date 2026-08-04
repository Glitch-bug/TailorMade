import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_made/core/constants/enums.dart';
import 'package:tailor_made/core/theme/app_pallete.dart';
import 'package:tailor_made/features/client/domain/entities/client.dart';
import 'package:tailor_made/features/client/presentation/widgets/client_details_panel.dart';
import 'package:tailor_made/features/client/presentation/bloc/client_bloc.dart';
import 'package:tailor_made/features/client/presentation/pages/add_client_page.dart';
import 'package:tailor_made/features/client/presentation/widgets/client_list.dart';
import 'package:tailor_made/features/client/presentation/widgets/client_edit_panel.dart';

class ClientsListPage extends StatefulWidget {
  const ClientsListPage({super.key});

  static route() => MaterialPageRoute(
      builder: (BuildContext context) => const ClientsListPage());

  @override
  State<ClientsListPage> createState() => _ClientsListPageState();
}

class _ClientsListPageState extends State<ClientsListPage> {
  Client? selected;
  List<Client> rawClients = [];
  List<Client> clients = [];
  final searchController = TextEditingController();
  AppState appState = AppState.list;
  PanelState? panelState;

  void _filterClients({required String query}) {
    clients = rawClients.where((client) {
      bool match = query.isEmpty ||
          "${client.firstName.toLowerCase()} ${client.lastName.toLowerCase()}"
              .contains(query) ||
          client.address.toLowerCase().contains(query) ||
          client.email.toLowerCase().contains(query) ||
          client.phoneNumber.toLowerCase().contains(query);
      return match;
    }).toList();
  }

  void _updateSelected({required Client? select}) {
    selected = rawClients.cast<Client?>().firstWhere(
      (client){
        return  select?.id == client?.id;
      },
      orElse: () => null,
    );
  }

  void deleteClient({required String id}) {
    context.read<ClientBloc>().add(ClientErase(id: id));
  }

  void selectClient({required Client client}) {
    selected = client;
    setState(() {});
  }

  void goToList() {
    appState = AppState.list;
    setState(() {});
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
    Size window = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: SizedBox(
            width: window.width * 0.7,
            // height: 40,
            child: TextField(
                decoration: const InputDecoration(
                  hintText: "Search Client",
                ),
                onChanged: (value) {
                  _filterClients(query: value.toLowerCase());
                  setState(() {});
                }),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, const AddClientPage().route());
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: BlocConsumer<ClientBloc, ClientState>(
          listener: (context, state) {
            if (state is ClientChangeSuccess) {
              context.read<ClientBloc>().add(ClientFetchAllClients());
            } else if (state is ClientDisplaySuccess) {
              rawClients = state.clients;
              _updateSelected(select: selected);
              _filterClients(query: searchController.text);
              setState(() {});
            }
          },
          builder: (context, state) {
            if (state is ClientDisplaySuccess && state.clients.isEmpty) {
              return Row(
                children: [
                  SizedBox(
                    width: 300,
                    child: Container(
                      height: double.infinity,
                      color: AppPallete.secondary,
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
                  Container(
                    width: 300,
                    clipBehavior: Clip.antiAlias,
                    height: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: AppPallete.secondary,
                      border: Border(
                        top: BorderSide(
                          color: ThemeData().dividerColor,
                          width: 0.4,
                        ),
                        right: BorderSide(
                          color: ThemeData().dividerColor,
                          width: 0.4,
                        ),
                      ),
                    ),
                    child: (selected != null)
                        ? switch (panelState) {
                            null => ClientDetailsPanel(
                                client: selected!,
                                measurements: () {
                                  appState = AppState.measurements;
                                  setState(() {});
                                },
                              ),
                            PanelState.editClient => ClientEditPanel(
                                client: selected,
                                onClose: () {
                                  panelState = null;
                                  // selected = null;
                                  setState(() {});
                                },
                              )
                          }
                        : SizedBox(),
                  ),
                  Expanded(
                      flex: 4,
                      child: switch (appState) {
                        AppState.list => ClientList(
                            edit: (client) {
                              panelState = PanelState.editClient;
                              selectClient(client: client);
                            },
                            delete: (id) {
                              deleteClient(id: id);
                            },
                            select: (client) {
                              selectClient(client: client);
                            },
                            clients: clients,
                          ),
                        AppState.measurements =>
                          ClientMeasurements(close: goToList, client: selected),
                        AppState.editMeasurements => SizedBox(),
                        AppState.saveClient => SizedBox(),
                        AppState.saveMeasurements => SizedBox(),
                      })
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class ClientMeasurements extends StatelessWidget {
  final VoidCallback close;
  final Client? client;
  const ClientMeasurements(
      {required this.close, required this.client, super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Map<String, dynamic>? measurements = client?.measurements;
    List<String> keys = measurements?.keys.toList() ?? [];
    return Container(
      height: size.height,
      width: size.width,
      // decoration: const BoxDecoration(
      //   color: Colors.white,
      // ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(icon: const Icon(Icons.close), onPressed: close),
            SizedBox(
              height: size.height * 0.85,
              width: size.width,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(keys[index]),
                      subtitle: Text(measurements?[keys[index]]),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      indent: size.width * 0.04,
                      endIndent: size.width * 0.04,
                    );
                  },
                  itemCount: keys.length),
            )
          ]),
    );
  }
}
