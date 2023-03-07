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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 0.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder:(context)=>Add_transaction()),);
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
                        padding:  EdgeInsets.all(12),
                        child:  Icon(
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
                  margin:  EdgeInsets.all(12),
                  child: Container(
                    decoration:  BoxDecoration(
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
                        children: const [
                          Text(
                            "Total Balance",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                           Text(
                            "Rs. 34000",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
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
}