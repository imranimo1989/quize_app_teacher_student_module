import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {

  static const routeName = '/login-screen';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginScreen({super.key});

  Widget login(IconData icon) {
    return Container(
      height: 50,
      width: 115,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          TextButton(onPressed: () {}, child: const Text('Login')),
        ],
      ),
    );
  }

  Widget userInput(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return Container(
      height: 55,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(color: Colors.blueGrey.shade200, borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
        child: TextField(
          controller: userInput,
          autocorrect: false,
          enableSuggestions: false,
          autofocus: false,
          decoration: InputDecoration.collapsed(
            hintText: hintTitle,
            hintStyle: const TextStyle(fontSize: 18, color: Colors.white70, fontStyle: FontStyle.italic),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            fit: BoxFit.fill,
            image: NetworkImage(
              'https://d33x1o3gj9io8i.cloudfront.net/images/1583/ATR6g4zuSVi0eFWGB3xH',
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 510,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 45),
                    userInput(emailController, 'Email', TextInputType.emailAddress),
                    userInput(passwordController, 'Password', TextInputType.visiblePassword),
                    Container(
                      height: 55,
                      // for an exact replicate, remove the padding.
                      padding: const EdgeInsets.only(top: 5, left: 70, right: 70),
                      child: ElevatedButton(
                        style : ElevatedButton.styleFrom(
                          shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      backgroundColor: Colors.indigo.shade800,
                        ),


                        onPressed: () {
                          print(emailController);
                          print(passwordController);

                        },
                        child: const Text('Login', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white,),),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Center(child: TextButton(onPressed: null,
                    child: Text('Forgot password ?')),),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          login(Icons.add),
                          login(Icons.book_online),
                        ],
                      ),
                    ),
                    const Divider(thickness: 0, color: Colors.white),
                    /*
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Text('Don\'t have an account yet ? ', style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),),
                    TextButton(
                    onPressed: () {},
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  ],
                ),
                  */
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}