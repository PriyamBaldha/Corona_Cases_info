import 'package:corona_cases_app/helpers/covid_data_api.dart';
import 'package:corona_cases_app/models/covid.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List country = [];
  dynamic selectedCountry;
  dynamic i;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Covid Cases"),
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 30,
        ),
        // backgroundColor: Colors.teal,
        body: FutureBuilder(
          future: CovidApi.covidAPI.fetchCovidDataAPI(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Eror:${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              List<CovidData> data = snapshot.data as List<CovidData>;

              country = data.map((e) => e.name).toList();

              return Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 200,
                          child: Image.asset(
                            "assets/images/covid.png",
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(width: 10),
                            const Icon(Icons.location_on,
                                size: 40, color: Colors.blue),
                            const Spacer(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.70,
                              child: DropdownButtonFormField(
                                hint: const Text("Select Country..."),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                value: selectedCountry,
                                onChanged: (val) {
                                  setState(() {
                                    selectedCountry = val;
                                    i = country.indexOf(val);
                                  });
                                },
                                items: country.map((e) {
                                  return DropdownMenuItem(
                                    value: e,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.50,
                                      child: Text(e),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        (i != null)
                            ? Container(
                                // color: Colors.purple,
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Spacer(),
                                      Container(
                                        height: 215,
                                        width: 120,
                                        alignment: Alignment.topLeft,
                                        color: Colors.teal,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(height: 55),
                                            const Text(
                                              " Today",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "          Confirmed : ${data[i].todayConfirmed}",
                                              style: const TextStyle(
                                                color: Colors.lightGreen,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              "           Deaths : ${data[i].todayDeaths}",
                                              style: const TextStyle(
                                                color: Colors.lightGreen,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 19,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        height: 215,
                                        width: 190,
                                        alignment: Alignment.topLeft,
                                        color: Colors.teal,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(height: 35),
                                            const Text(
                                              "      Over all Cases",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            const SizedBox(height: 5),
                                            Text(
                                              "       Deaths : ${data[i].todayDeaths}",
                                              style: const TextStyle(
                                                color: Colors.lightGreen,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 19,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              "       Critical : ${data[i].totalCritical}",
                                              style: const TextStyle(
                                                color: Colors.lightGreen,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 19,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              "       Recovered : ${data[i].totalRecovered}",
                                              style: const TextStyle(
                                                color: Colors.lightGreen,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "     Confirmed : ${data[i].totalConfirmed}",
                                              style: const TextStyle(
                                                color: Colors.lightGreen,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 19,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                  (data[i].recoveryRate != null)
                                      ? Container(
                                          // decoration: containerDecoration,
                                          padding: const EdgeInsets.all(20),
                                          child: Column(
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                color: Colors.teal,
                                                height: 100,
                                                width: 310,
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                      "  Recovery Rate :",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    Text(
                                                      " ${data[i].recoveryRate}",
                                                      style: const TextStyle(
                                                        color:
                                                            Colors.lightGreen,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(),
                                  const SizedBox(height: 40),
                                ]),
                              )
                            : Column(
                                children: const [
                                  SizedBox(height: 160),
                                  Text(
                                    "No Data Found",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
