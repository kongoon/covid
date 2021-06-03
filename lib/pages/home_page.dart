import 'dart:async';
import 'package:covid/models/country_stats.dart';
import 'package:covid/models/world_stats.dart';
import 'package:covid/pages/country_page.dart';
import 'package:covid/services/covid_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class Debouncer {
  final int miliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.miliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(microseconds: miliseconds), action);
  }
}
class _HomePageState extends State<HomePage> {
  final _debouncer = Debouncer(miliseconds: 500);
  final formater = NumberFormat();
  Future<WorldStats> worldStats;

  List<CountryStats> summaryCountryStats = List();
  List<CountryStats> filterCountry;

  int filterCountryCount = 0;

  int worldCases = 0;
  int worldDeaths = 0;
  int worldRecovered = 0;

  @override
  void initState() {
    CovidService.fetchWorldStats().then((stats) {
      setState(() {
        worldCases = stats.cases;
        worldDeaths = stats.deaths;
        worldRecovered = stats.recovered;
      });
    });
    CovidService.fetchSummaryCountryStats().then((countryStats) {
      setState(() {
        summaryCountryStats = countryStats;
        filterCountry = summaryCountryStats;
        filterCountryCount = summaryCountryStats.length > 0 ? summaryCountryStats.length : 0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("COVID-19", style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900), textAlign: TextAlign.center,)),
        elevation: 0.0,
      ),
      backgroundColor: Colors.red,
      body: SafeArea(
        minimum: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Wrap(
              children: <Widget>[
                Card(
                  color: Colors.orange,
                  child: Container(
                    width: (MediaQuery.of(context).size.width),
                    //height: 100.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                           ListTile(
                            leading: Icon(Icons.supervised_user_circle, size: 70, color: Colors.white,),
                            title: Text((formater.format(worldCases.toInt())).toString(), style: TextStyle(fontSize: 50.0, color: Colors.white, fontWeight: FontWeight.w900)),
                            subtitle: Text("World Infections", style: TextStyle(fontSize: 20.0, color: Colors.white),),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.redAccent,
                  child: Container(
                    width: (MediaQuery.of(context).size.width * 0.5)-16,
                    //height: 100.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ListTile(
                          leading: FaIcon(FontAwesomeIcons.dizzy, color: Colors.white, size: 40,),
                          title: Text((formater.format(worldDeaths.toInt())).toString(), style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w900)),
                          subtitle: Text("Deaths", style: TextStyle(fontSize: 14.0, color: Colors.white),),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  color: Colors.green,
                  child: Container(
                    width: (MediaQuery.of(context).size.width * 0.5)-16,
                    //height: 100.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ListTile(
                          leading: FaIcon(FontAwesomeIcons.headSideMask, color: Colors.white, size: 40,),
                          title: Text((formater.format(worldRecovered.toInt())).toString(), style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w900)),
                          subtitle: Text("Recovered", style: TextStyle(fontSize: 14.0, color: Colors.white),),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                autocorrect: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15.0),
                  hintText: 'Search Country',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white70,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                  )
                ),
                onChanged: (string) {
                  _debouncer.run((){
                    setState(() {
                      filterCountry = summaryCountryStats.where((u) => (u.country.toLowerCase().contains(string.toLowerCase()))).toList();
                      filterCountryCount = filterCountry.length;
                    });
                  });

                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                 //padding: EdgeInsets.all(10.0),
                itemCount: filterCountryCount,
                itemBuilder: (BuildContext context, int index){
                   return GestureDetector(
                     child: Card(
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                           ListTile(
                             leading: FaIcon(FontAwesomeIcons.viruses, color: Colors.red, size: 40,),
                             title: Text(filterCountry[index].country.toString(), style: TextStyle(fontSize: 20.0, color: Colors.red)),
                             subtitle: Text((formater.format(filterCountry[index].cases != null ? filterCountry[index].cases : 0).toString()) + " Cases +" + (formater.format(filterCountry[index].todayCases != null ? filterCountry[index].todayCases : 0).toString())),
                           ),
                         ],
                       ),
                     ),
                     onTap: () {
                       Navigator.push(context, CupertinoPageRoute(builder: (context) {
                         return CountryPage(data: filterCountry[index]);
                       }));
                     },
                   );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
