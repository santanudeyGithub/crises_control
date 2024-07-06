import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'models/company.dart';

class CompaniesPage extends StatelessWidget {
  const CompaniesPage({super.key, required this.companies});
  final List<Company> companies;

  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(language!.companies),
      ),
      body: CompaniesBody(companies: companies),
    );
  }
}

class CompaniesBody extends StatelessWidget {
  final List<Company> companies;
  const CompaniesBody({super.key, required this.companies});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: companies.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.network(companies[index].companyLogo),
          title: Text(companies[index].customerId),
          subtitle: Text(companies[index].companyName),
          trailing: const Icon(Icons.navigate_next),
          onTap: () {},
        );
      },
    );
  }
}
