
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'databring.dart';


class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);


  @override
  State<homepage> createState() => _homepageState();
}
var currentindex=0;
final List<String> docIDS=[];
List<String> AID=[];
List<String> PID=[];
List<String> RID=[];
Future getdocid() async{
  await FirebaseFirestore.instance.collection('banktransferdata').get().then(
          (snapshot)=>snapshot.docs.forEach((document) {
            print("444444444444444444444444444");
        if(!docIDS.contains(document.reference.id))
          docIDS.add(document.reference.id);
        print("7777777777777777777777777777");
        print(docIDS);
      }));
}

Future positivenum() async{
    getdocid();
  var len=docIDS.length;

  CollectionReference collection1 = await FirebaseFirestore.instance.collection('banktransferdata');
  var k=0;

  print(len);
  for( var i=0;i<len ;i++){
    var docSnapshot =await collection1.doc(docIDS[i]).get();

    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      var value = data?['status'];

      if(value=="dept")
      {
        if(!AID.contains(docIDS[i]))
          AID.add(docIDS[i]);

      }
      if(value=='paid'){
        if(!PID.contains(docIDS[i]))
          PID.add(docIDS[i]);
      }
      if(value =='request'){
        if(!RID.contains(docIDS[i]))
          RID.add(docIDS[i]);
      }
    }
  }
}

CollectionReference users=FirebaseFirestore.instance.collection("banktransferdata");
List<Widget> pages=[
  Container(
    child: FutureBuilder(
        future: positivenum(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemBuilder:(context,int index){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5),

                child: Container(

                    height: 100,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child:getuser(documentId:AID[index] ,cl: Colors.green,)
                ),
              );
            },
            itemCount:AID.length,
          );
        }
    ),
  ),
  Container(
    child: FutureBuilder(
        future: positivenum(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemBuilder:(context,int index){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5),

                child: Container(

                    height: 100,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child:getuser(documentId:PID[index] ,cl: Colors.deepOrange)
                ),
              );
            },
            itemCount:PID.length,
          );
        }
    ),
  ),
  Container(
    child: FutureBuilder(
        future: positivenum(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemBuilder:(context,int index){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5),

                child: Container(

                    height: 100,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child:getuser(documentId:RID[index] ,cl: Colors.red,)
                ),
              );
            },
            itemCount:RID.length,
          );
        }
    ),
  ),

];

class _homepageState extends State<homepage> {


  void initState(){
    super.initState();

  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(

        backgroundColor: Colors.grey[200],
        elevation: 0,
        title:Text("Welcome to Nupay Admin App",style: TextStyle(color: Colors.deepPurpleAccent),),

        actions: [
          IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();

          }, icon:Icon(Icons.logout,color: Colors.deepPurpleAccent,))
        ],
      ),

      backgroundColor: Colors.grey[200],
      body:pages[currentindex],
      bottomNavigationBar: Container(

        color: Colors.deepPurple,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 15),
          child: GNav(
              selectedIndex: currentindex,
              onTabChange:(index){
                setState(
                        ()
                    {
                      currentindex=index;
                    }
                );
              },
              backgroundColor: Colors.deepPurple,
              color: Colors.grey,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.deepPurple.shade400,
              padding: EdgeInsets.all(14),
              gap: 8,
              tabs:const[
                GButton(icon: Icons.online_prediction,
                  text: 'Active',
                ),
                GButton(icon: Icons.money,
                  text: 'payed',
                ),
                GButton(icon: Icons.request_page,
                  text: 'requested',)
              ]),),),);
  }
}
