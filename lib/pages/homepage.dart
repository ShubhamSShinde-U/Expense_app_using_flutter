import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:myexpence/controllers/db_helper.dart';
import 'package:velocity_x/velocity_x.dart';
import 'add_transaction.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DbHelper dbHelper = DbHelper();
  // dbHelper.openBox();
  int totalBalence = 0;
  int totalIncome = 0;
  int totalExpense = 0;

  DateTime today = DateTime.now();
  List<FlSpot> dataset = [];
  List<FlSpot> getPlotPoints(Map entiredata){
    dataset = [];
    entiredata.forEach((key, value) {
      if(value['type']=="Expense" && (value['date']as DateTime).month == today.month){
        dataset.add(FlSpot((value['date']as DateTime).day.toDouble(), (value['amount'] as int).toDouble()));
      }
    });
    return dataset;
  }


  getTotalBalence(Map entireData){
      totalBalence = 0;
      totalIncome = 0;
      totalExpense = 0;
      entireData.forEach((key, value) {
      print(key);
      if(value['type'] == "Income"){
        totalBalence += (value['amount'] as int);
        totalIncome += (value['amount'] as int);
      }
      else{
        totalBalence -= (value['amount'] as int);
         totalExpense += (value['amount'] as int);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 0.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder:(context)=>const Add_transaction()
              ),
            ).whenComplete(() {
              setState(() {
        
              });
            });

        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, size: 32,),
        ),
      body:  FutureBuilder<Map>(
        future: dbHelper.fetch(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return const Center(
              child: Text("UnExpected Error !!!"),
            );
          }
          if (snapshot.hasData){
            if(snapshot.data!.isEmpty){
              return const Center(
               child: Text("No values found"),
               );
            }
            getTotalBalence(snapshot.data!);
            getPlotPoints(snapshot.data!);
            return ListView(
              children:  [
                 Padding(
                   padding: const EdgeInsets.all(12.0),
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Row(
                        children: [
                            Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        // color: Colors.white70,
                        padding:  const EdgeInsets.all(12),
                        // child:  const Icon(
                        //   Icons.image,
                        //   size: 32,
                        // ),
                       child: CircleAvatar(child: Image.asset("assets/images/shubham1.png"), ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text("WelCome Shubham", 
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily:AutofillHints.birthdayDay
                        ),
                        ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        // color: Colors.white70,
                        padding: const EdgeInsets.all(12),
                        child: const Icon(
                          Icons.settings,
                          size: 32,
                        ),
                      ),
                    ],
                   ),
                 ),
                 Container(
                  width: MediaQuery.of(context).size.width*0.9,
                  margin:  const EdgeInsets.all(12),
                  child: Container(
                    decoration:  const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Vx.blue500,
                          Vx.pink500]
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      child: Column(
                        children:  [
                          const Text(
                            "Total Balance",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height:20
                          ),
                            Text(
                            'Rs. $totalBalence',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height:20
                          ),
                          Padding (
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                  cardIncome(totalIncome.toString(),),
                                  cardExpense(totalExpense.toString())
                              ]
                            )
                          ),
                          
                        ],
                      ),
                  ),

                 ),

                 const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("Graphical Data",
                    style: TextStyle(
                    fontSize: 32,
                    color: Vx.black,
                    fontWeight: FontWeight.w900
                    )
                  ),
                ),
                    //

                dataset.length <2 ? Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow:  [BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 5,
                      blurRadius: 6,
                      offset: Offset(0, 4)
                    ),
                    ]
                  ),
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.all(12),
                  // height: 100,
                  child: Text("No enough data to show",
                  style: TextStyle(
                    fontSize: 22,
                    color: Vx.black,
                    fontWeight: FontWeight.w900
                    )
                    ),
                )
                : Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow:  [BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 5,
                      blurRadius: 6,
                      offset: Offset(0, 4)
                    ),
                    ]
                  ),
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.all(12),
                  height: 300,
                  child: LineChart(
                    LineChartData(
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: getPlotPoints(snapshot.data!),
                          isCurved: false,
                          barWidth: 2.5,
                          color: Colors.blue
                        )
                      ]
                    )
                  ),
                ),


                 const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("Recent Expenses",
                    style: TextStyle(
                    fontSize: 32,
                    color: Vx.black,
                    fontWeight: FontWeight.w900
                    )
                  ),
                ),
                    // SingleChildScrollView(
                    
                      SingleChildScrollView(
                        // physics: ScrollPhysics(),
                        child: Column(
                          // height: 500,
                          children:<Widget>[ ListView.builder(
                                // shrinkWrap: true,
                                // physics: const NeverScrollableScrollPhysics(),
                                // physics: Scrollable(viewportBuilder: (BuildContext context, ViewportOffset position) {  },),
                                itemCount: snapshot.data!.length,
                                itemBuilder: ((context, index) {
                                  Map dataAtIndex = snapshot.data![index];
                                  if(dataAtIndex['type']=="Expense"){
                                    return expenceTile(dataAtIndex['amount'], dataAtIndex['note']);
                                  }
                                  else{
                                    return incomeTile(dataAtIndex['amount'], dataAtIndex['note']);
                                  }
                                })),
                              ]
                        ),
                      ),
                      
              ],
            );
          }
          else{
            return const Center(
          child: Text("UnExpected Error"),
          );
          }
        },
       
      ),
    );
  }

  Widget cardIncome(String value){
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Vx.white,
            borderRadius: BorderRadius.circular(20)
          ),
          padding: const EdgeInsets.all(6),
          child:  Icon(
            Icons.arrow_upward,
            size: 28,
            color: Colors.green,
          ),
          margin: const EdgeInsets.only(
          right:8.0),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Income",
              style: TextStyle(
                fontSize: 14,
                color: Vx.white
              ),
            ),
             Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Vx.white
              ),
            )
          ],
        )
      ],
    );



  

  }



  
  Widget cardExpense(String value){
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Vx.white,
            borderRadius: BorderRadius.circular(20)
          ),
          padding: EdgeInsets.all(6),
          child: Icon(
            Icons.arrow_downward,
            size: 28,
            color: Colors.red,
          ),
          margin: const EdgeInsets.only(
          right:8.0),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Expense",
              style: TextStyle(
                fontSize: 14,
                color: Vx.white
              ),
            ),
             Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Vx.white
              ),
            )
          ],
        )
      ],
    );
  }

  Widget incomeTile(int value , String note){

    return Container(
      margin: const EdgeInsets.all(8),
      padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:Vx.amber200,
          borderRadius:BorderRadius.circular(8)
        ),
        child:Column(
          children:[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                children: const [
                    Icon(
                      Icons.arrow_circle_up_outlined,
                      size: 29,
                      color: Vx.green500,
                    ),
                    SizedBox(width: 4,),
                    Text("Income"),
                ],
              ),
              Text("Rs. $value",
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700
                ),
              )
            ],
            )
          ],
          
        )
      );
  }


  Widget expenceTile(int value , String note){

    return Container(
      margin: const EdgeInsets.all(8),
      padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:Vx.amber200,
          borderRadius:BorderRadius.circular(8)
        ),
        child:Column(
          children:[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                children: const [
                    Icon(
                      Icons.arrow_circle_down_outlined,
                      size: 29,
                      color: Vx.red600,
                    ),
                    SizedBox(width: 4,),
                    Text("Expense"),
                ],
              ),
              Text("Rs. $value",
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700
                ),
              )
            ],
            )
          ],
          
        )
      );
  }
}