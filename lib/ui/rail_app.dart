import 'package:flutter/material.dart';
import 'package:parry_front/ui/collector/collector.dart';
import 'package:parry_front/ui/colors_app.dart';
import 'package:parry_front/ui/dashboard/dashboard.dart';
import 'package:parry_front/ui/rapporteur_generator.dart';

class RailApp extends StatefulWidget{
  const RailApp({super.key});

  @override
  State<RailApp> createState()=> _RailApp();
}

class _RailApp extends State<RailApp> {
  static const double _width_left = 80;

  int _index = 0;
  final List<List<Widget>> _actions_buttons = List.empty(growable: true);
  final List<String> _title_context = List.from(<String>{'Dashboard','Coleta de currículos','Gerar relatório'});
  final _page_controller = PageController(initialPage: 0);
  late PageView _page_view;

  @override
  void initState() {
    super.initState();

    _page_view = PageView(
      controller: _page_controller,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[Dashboard(),Collector(),RapporteurGenerator()],
    );

    _actions_buttons.addAll(
      [
        [],
        [
          IconButton(onPressed: (){}, icon: Icon(Icons.search))
        ],
        []
      ]
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu)),
        leadingWidth: _width_left,
        actions: _actions_buttons[_index],
        //foregroundColor: ColorsApp.grey1.color,
        title: Text(_title_context[_index]),

      ),
      body: SafeArea(
        child: Row(
          children: [
            NavigationRail(
              backgroundColor: ColorsApp.grey1.color,
              minWidth: _width_left,
              selectedIndex: _index,
              labelType: NavigationRailLabelType.all,
              groupAlignment: -1,
              onDestinationSelected: (int index) {
                setState(() {
                  _index = index;
                });
                _page_controller.jumpToPage(index);
              },
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  selectedIcon: Icon(Icons.dashboard),
                  label: Text('Dashboard')
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.cloud_upload_outlined),
                  selectedIcon: Icon(Icons.cloud_upload),
                  label: Text('Coleta')
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.analytics_outlined),
                  selectedIcon: Icon(Icons.analytics),
                  label: Text('Relatório')
                ),
              ],
            ),
            VerticalDivider(
              width: 2,
              color: ColorsApp.grey2.color,
              thickness: 1,
            ),
            Expanded(
              child: Container(
                color: ColorsApp.white.color,
                width: double.infinity,
                height: double.infinity,
                child: _page_view,
              )
            )
          ],
        ), 
      ),
    );
  }
}