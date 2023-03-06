import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:velocity_x/velocity_x.dart';

class Add_transaction extends StatefulWidget {
  const Add_transaction({super.key});

  @override
  State<Add_transaction> createState() => _Add_transactionState();
}

class _Add_transactionState extends State<Add_transaction> {


  int? amount;
  String note = "Some Expense";
  String type = "Income";
  DateTime selectedDate = DateTime.now();
    List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];


  Future<void> _selectDate(BuildContext context) async{
    final DateTime? picked = await showDatePicker(context: context, initialDate: selectedDate, firstDate: DateTime(2020,12), lastDate: DateTime(2100,01));
    if(picked != null && picked != selectedDate){
      setState(() {
        selectedDate = picked;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
        ),
        body: ListView(
          padding: const EdgeInsets.all(12),
          children:  [
             const Text("Add Transaction", 
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                        height: 20,
                    ),
              Row(
                children: [
                  Container(
                    decoration:  BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(16,),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: const Icon(
                      Icons.attach_money,
                      size: 24, 
                      color: Colors.white,
                      ),
                    
                    ),

                    const SizedBox(
                      width: 12,
                    ),
                      Expanded(
                       child: TextField(
                        decoration: const InputDecoration(
                          hintText: "0",
                          border: InputBorder.none
                        ),
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                        onChanged: (value){
                          try{
                            amount = int.parse(value);
                          }
                          catch(e){}
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                        ),
                     ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
    
               Row(
                children: [
                  Container(
                    decoration:  BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(16,),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: const Icon(
                      Icons.note,
                      size: 24, 
                      color: Colors.white,
                      ),
                    
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                     Expanded(
                       child: TextField(
                        decoration: const InputDecoration(
                          hintText: "Note on Transaction",
                          border: InputBorder.none
                        ),
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                       onChanged: ((value) {
                         note = value;
                       }),
                        ),
                     ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                   Container(
                    decoration:  BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(16,),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: const Icon(
                      Icons.moving_sharp,
                      size: 24, 
                      color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width:12,
                    ),
                     ChoiceChip(
                      label:  Text("Income",
                      style: TextStyle(
                        fontSize: 18,
                        color: type == "Income" ? Colors.white :Colors.black,
                      ),
                      ), 
                      selectedColor: Vx.blue500,
                      selected: type=="Income" ? true :false,
                      onSelected: (value) {
                        if(value){
                          setState(() {
                            type = "Income";
                          });
                        }
                      },
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    ChoiceChip(
                      label:  Text("Expense",
                      style: TextStyle(
                        fontSize: 18,
                        color: type == "Expense" ? Colors.white :Colors.black,
                      ),
                      ), 
                      selectedColor: Vx.blue500,
                      selected: type=="Expense" ? true :false,
                      onSelected: (value) {
                        if(value){
                          setState(() {
                            type = "Expense";
                          });
                        }
                      },
                    ),
                ],
              ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: (){
                _selectDate(context);
              }, 
              child: Row(
                children: [
                    Container(
                    decoration:  BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(16,),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: const Icon(
                      Icons.date_range,
                      size: 24, 
                      color: Colors.white,
                      ),
                    
                    ),
                    const SizedBox(width: 12,),
                    Text("${selectedDate.day} ${months[selectedDate.month -1]}",
                    style: const TextStyle(
                      fontSize: 20
                    ),),
                ],
              ),
              ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(height:50,
            child: ElevatedButton(onPressed: (){}, child: "Add".text.make())),
          ],
        )
      ),
    );
  }
}