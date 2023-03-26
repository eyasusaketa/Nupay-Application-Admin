import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'forgotpassword.dart';
class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  final _emailcontroller=TextEditingController();
  final _passwordcontroller=TextEditingController();
  Future signIn() async{
    try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailcontroller.text.trim(),
        password: _passwordcontroller.text.trim()
    );}
        on FirebaseAuthException catch (e){

      showDialog(context: context, builder:(context){
        return AlertDialog(
          content: Text('Incorrect Email or Password'),
        );
      });
        }
  }

  @override
  void dispose(){
    super.dispose();
    _passwordcontroller.dispose();
    _emailcontroller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            Text("Welcome to",style: TextStyle(fontSize: 22),),
            Text("Nupay admin app",style: TextStyle(color: Colors.grey[800],fontSize: 22),),

            SizedBox(height: 35,),
            Padding(

              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextField(

                    controller: _emailcontroller,
                    decoration: InputDecoration(

                        border: InputBorder.none,
                        hintText:'Email'
                    ),

                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(

              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white)
                ),

                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextField(
                    controller: _passwordcontroller,
                    obscureText: true,
                    decoration: InputDecoration(

                        border: InputBorder.none,
                        hintText:'Password'
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  GestureDetector(
                      onTap:(){
                        Navigator.push(context,MaterialPageRoute(builder:(context){

                         return forgotpassword();
                        }) );

                      },
                      child: Text(" Forgot Password?",style: TextStyle(color:Colors.blue,fontWeight:FontWeight.bold,fontSize:17),)),

                ],
              ),
            ),
            SizedBox(height: 15,),
            GestureDetector(
              onTap: signIn,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(

                  padding: EdgeInsets.all(17),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(12)
                  ),

                  child: Center(
                      child: Text("Sign in",
                        style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),
                      )),
                ),
              ),
            ),
            SizedBox(height: 10,),



          ],
        ),
      ),

    );
  }
}

