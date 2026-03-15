import 'package:flutter/material.dart';
import 'package:pascoa_scout/ui/tabs/job_scrapper_config_tab.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: JobScrapperConfigTab());
  }
}
