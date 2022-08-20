import 'package:animation/pie_chart/page/pie_chart_page.dart';
import 'package:flutter/material.dart';





class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Task'), centerTitle: false),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: PageView(
            children: [
              PieChartPage(),
            ],
          ),
        ),
      );
}
