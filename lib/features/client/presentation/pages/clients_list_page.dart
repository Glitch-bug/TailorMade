import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tailor_made/core/theme/app_pallete.dart';
import 'package:tailor_made/features/client/presentation/pages/add_client_page.dart';

class ClientsListPage extends StatelessWidget {
  const ClientsListPage({super.key});

  static route() => MaterialPageRoute(
    builder: (BuildContext context) => const ClientsListPage()
  );

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: (){
                Navigator.push(context, const AddClientPage().route());
              },
              icon: const Icon(CupertinoIcons.add_circled)
            )
          ]
        ),
        body: Row(
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
        ),
      ),
    );
  }
}
