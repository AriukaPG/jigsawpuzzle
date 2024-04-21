import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:image_picker/image_picker.dart";
import 'package:jigsawpuzzle/Screens/jigsawPuzzle.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<String>> getImageUrls(String folderName) async {
    List<String> imageUrls = [];
    try {
      var listResult = await _storage.ref(folderName).listAll();
      for (var item in listResult.items) {
        var url = await item.getDownloadURL();
        imageUrls.add(url);
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching image URLs: $error');
      }
    }
    return imageUrls;
  }
}
late User? _user;
late DocumentSnapshot userSnapshot;
String name = 'bi bn';
String user='';
Future<void> _fetchUserData() async {
  if (_user != null) {
    try {
      userSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(_user!.uid)
          .get();
      if (userSnapshot.exists) {
        //name = userSnapshot['Name'];
        user = userSnapshot['userId'];
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching user data: $error');
      }
    }
  }
}

int option = 0;
XFile? file;
String selectedFile = '';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseStorageService storageService = FirebaseStorageService();
  late Future<List<String>> _imageUrlsFuture;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    print('whyy $name');
    _imageUrlsFuture = storageService
        .getImageUrls('images'); // Replace 'images' with your folder name
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Энэ өдрийн мэнд хүргэе!'),
      ),
      body: FutureBuilder(
        future: _imageUrlsFuture,
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final List<String> imageUrls = snapshot.data!;
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  height: 200,
                  width: 135, // Set the height as needed
                  //color: Colors.blue,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:
                          const Color(0xffA3ECFF)), // Set the background color
                  child: Column(
                    children: [
                      const SizedBox(height: 70,),
                      const Text("Зураг оруулах"),
                      IconButton(
                          onPressed: uploadImage,
                          icon: const Icon(
                            Icons.camera_alt,
                            size: 50,
                          )),
                    ],
                  ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two images per row
                  mainAxisSpacing: 5, // Reduce line spacing
                  crossAxisSpacing: 10, // Space between columns
                ),
                itemCount: imageUrls.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      option = 2;
                      selectedFile = imageUrls[index];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const JigsawPuzzle(), //ImageDetailScreen(imageUrl: imageUrls[index]),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          imageUrls[index],
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home_outlined,
                color: Color(0xffA3ECFF),
                size: 40,),
              onPressed: (){},
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
                  size: 30),
              onPressed: () =>  Navigator.pushNamed(context, "/account"),
            ),
          ],
        ),
      ),
    );
  }

  void uploadImage() {
    option = 1;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Text('               '),
            IconButton(
              onPressed: () async {
                ImagePicker imagePicker = ImagePicker();
                file = await imagePicker.pickImage(source: ImageSource.camera);
                var route =
                    MaterialPageRoute(builder: (context) => const JigsawPuzzle());
                Navigator.push(context, route);
              },
              color: Colors.white,
              icon: const Icon(Icons.camera_alt, size: 50),
            ),
            const Text('                               '),
            IconButton(
              onPressed: () async {
                ImagePicker imagePicker = ImagePicker();
                file = await imagePicker.pickImage(source: ImageSource.gallery);
                if (file == null) return;
                var route =
                    MaterialPageRoute(builder: (context) => const JigsawPuzzle());
                Navigator.push(context, route);
              },
              color: Colors.white,
              icon: const Icon(Icons.image_outlined, size: 50),
            ),
          ],
        ),
        backgroundColor: const Color(0xffA3ECFF),
      ),
    );
  }
}
