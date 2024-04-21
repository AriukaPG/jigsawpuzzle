import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';

class MyAccountScreen extends StatefulWidget {

  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen>{

  @override
  void initState() {
    super.initState();
  }

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/login');
    } catch (e) {
      if (kDebugMode) {
        print('Error signing out: $e');
      }
    }
  }
  
  @override
  Widget build(BuildContext context){
    String firstAlphabet = name.isNotEmpty ? name[0] : '';
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset('assets/images/background.png'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 95, 0, 0),
                  child: Row(
                    children: [
                      InkWell(
                        child: const Icon(Icons.chevron_left,
                          color: Colors.white,
                          size: 30,
                        ),
                        onTap: () => Navigator.pushNamed(context, '/wallet'),
                      )
                    ],
                  ),
                ),


                const Positioned(
                  top: 95,
                  left: 130,
                  child: Text("Миний профайл",
                    style: TextStyle(color: Colors.white,
                        fontSize: 20),),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(140, 200, 0, 0),
                  child: Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                        color: const Color(0xff429EBD),
                        borderRadius: BorderRadius.circular(130)
                    ),
                    child: Center(child: Text('whyy $name', style: const TextStyle(
                        fontSize: 10,
                        color: Colors.red
                    ),)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                name, style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22
              ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const InkWell(
                    child: ListTile(
                      title: Text("Хувийн мэдээлэл",
                        style: TextStyle(fontSize: 20),),
                      leading: Icon(Icons.person,
                        size: 30,
                        color: Color(0xff666666),),
                      trailing: Icon(Icons.chevron_right, size: 30,
                          color:Color(0xff666666)),
                    ),
                  ),
                  const InkWell(
                    child:ListTile(
                      title: Text("Сугалаа",
                        style: TextStyle(fontSize: 20),),
                      leading: Icon(Icons.local_activity_outlined,
                        size: 30,
                        color: Color(0xff666666),),
                      trailing: Icon(Icons.chevron_right, size: 30,
                          color:Color(0xff666666)),
                    ),
                  ),
                  const InkWell(
                    child:ListTile(
                      title: Text("Найзаа урих",
                        style: TextStyle(fontSize: 20),),
                      leading: Icon(Icons.person_add_rounded,
                        size: 30,
                        color: Color(0xff666666),),
                      trailing: Icon(Icons.chevron_right, size: 30,
                          color:Color(0xff666666)),
                    ),
                  ),
                  const InkWell(
                    child:ListTile(
                      title: Text("Тохиргоо",
                        style: TextStyle(fontSize: 20),),
                      leading: Icon(Icons.settings,
                        size: 30,
                        color: Color(0xff666666),),
                      trailing: Icon(Icons.chevron_right, size: 30,
                          color:Color(0xff666666)),
                    ),
                  ),
                  const InkWell(
                    child:ListTile(
                      title: Text("Тусламж",
                        style: TextStyle(fontSize: 20),),
                      leading: Icon(Icons.help,
                        size: 30,
                        color: Color(0xff666666),),
                      trailing: Icon(Icons.chevron_right, size: 30,
                          color:Color(0xff666666)),
                    ),
                  ),
                  InkWell(
                    onTap: _signOut,
                    child:const ListTile(
                      title: Text("Гарах",
                        style: TextStyle(fontSize: 20),),
                      leading: Icon(Icons.login,
                        size: 30,
                        color: Color(0xff666666),),
                      trailing: Icon(Icons.chevron_right, size: 30,
                          color:Color(0xff666666)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home_outlined,
                size: 30,),
              onPressed: (){
                Navigator.pushNamed(context, '/home');
              },
            ),
            IconButton(
              icon: const Icon(Icons.leaderboard_outlined,
                  size: 30),
              onPressed: (){
                Navigator.pushNamed(context, '/lottery');
              },
            ),
            IconButton(
              icon: const Icon(Icons.share_outlined,
                  size: 30),
              onPressed: () =>  Navigator.pushNamed(context, "/wallet"),
            ),
            IconButton(
              icon: const Icon(Icons.person_outlined,
                  color: Color(0xffA3ECFF),
                  size: 40),
              onPressed: () =>  Navigator.pushNamed(context, "/account"),
            ),
          ],
        ),
      ),
    );
  }
}
