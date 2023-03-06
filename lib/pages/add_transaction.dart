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
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                    const Expanded(
                     child: TextField(
                      decoration: InputDecoration(
                        hintText: "Note on Transaction",
                        border: InputBorder.none
                      ),
                      style: TextStyle(
                        fontSize: 24,
                      ),
                     
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
                  const ChoiceChip(
                    label: Text("Income"), 
                    selectedColor: Vx.blue500,
                    selected: true
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  const ChoiceChip(
                    label: Text("Expence"), 
                    selected: false
                  ),
              ],
            ),
          const SizedBox(
            height: 20,
          ),
          TextButton(onPressed: (){}, child: "Date".text.make(),),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: (){}, child: "Add".text.make()),
        ],
      )
    );
  }
}