import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ussd_advanced/ussd_advanced.dart';
class getuser extends StatelessWidget {
  const getuser({Key? key,required this.cl, required this.documentId}) : super(key: key);
final String documentId;
final Color cl;

  @override
  Widget build(BuildContext context) {
    CollectionReference users=FirebaseFirestore.instance.collection("banktransferdata");
    void paid(){
    users.doc(documentId).update({"status":"paid"}).then((value) => null);}
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(documentId).get(),
        builder:( (context,snapshot){
          if(snapshot.connectionState==ConnectionState.done){
            Map<String,dynamic> data=snapshot.data!.data() as Map<String,dynamic>;
            String dia='*806*'+data['phone']+'*'+data['amount']+'#';
            print(dia);
            return Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [

                    Text('phone: '+ data['phone'] ,style: TextStyle(fontSize: 17),),
                    Text('Balance: '+data['ammount'],style: TextStyle(color: Colors.grey),),
                    Text('Bank: '+ data['bank'] ,style: TextStyle(color: Colors.grey),),
                    Text('fullname:'+data['Name'] ,style: TextStyle(color: Colors.grey),),

                  ],
                ),

                GestureDetector(
                  onTap:(){
                    paid();
                    UssdAdvanced.sendUssd(
                      code: dia, subscriptionId: 1);

                  },
                  child: Container(
                      height: 45,
                      width: 100,
                      decoration: BoxDecoration(
                          color: cl,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child:Center(
                        child:Text("Pay",style:TextStyle(color:Colors.white)),
                      )),
                )
              ],
            );
          }
        return Center(child: Text('loading'));
    }),
    );
  }
}
