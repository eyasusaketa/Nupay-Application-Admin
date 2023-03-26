
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class forgotpassword extends StatefulWidget {
  const forgotpassword({Key? key}) : super(key: key);

  @override
  State<forgotpassword> createState() => _forgotpasswordState();
}

class _forgotpasswordState extends State<forgotpassword> {
  @override
  Widget build(BuildContext context) {
    final _email=TextEditingController();
    void dispose(){
      _email.dispose();
      super.dispose();
    }
    Future passwordreset() async{
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
            email: _email.text.trim());
        showDialog(context: context, builder: (context){
          return AlertDialog(
            content: Text("Reset link is sent to "+ _email.text + "Check your email"),
          );
      });
      }on FirebaseAuthException catch (e){
         showDialog(context: context, builder: (context){
           return AlertDialog(
             content: Text(e.message.toString()),
           );

         });

      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[400],
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text("Please Enter Your Email and We will send you a passwod reset link",style: TextStyle(fontSize: 17),),
              SizedBox(height: 20,),
              TextField(
                controller: _email,
             decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple),
                borderRadius: BorderRadius.circular(15)
              ),
               hintText: "Email",
             ),
              ),
              SizedBox(height: 15,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.deepPurple[500],
                  borderRadius: BorderRadius.circular(20)

                ),
                child: MaterialButton(onPressed: (){
                      passwordreset();
                },
                child: Text("Reset Password",style: TextStyle(color: Colors.white),),
         

                ),
              )
            ],
          ),

        ),
      ),

    );
  }
}
