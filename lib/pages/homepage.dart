import 'package:flutter/material.dart';
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
                        child:  const Icon(
                          Icons.image,
                          size: 32,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text("WelCome Shubham"),
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
                  child: Text("Recent Expenses",
                    style: TextStyle(
                    fontSize: 32,
                    color: Vx.black,
                    fontWeight: FontWeight.w900
                    )
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      // physics: const NeverScrollableScrollPhysics(),
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
                  ),
                )

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