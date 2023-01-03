import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Drawer(
        width: 20,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.green,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/banner.jpg"))),
              child: Text(
                'Itadakimasu',
                style: TextStyle(
                    color: Color.fromARGB(255, 253, 255, 111), fontSize: 25),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.format_shapes_sharp),
              title: const Text('Image Annotation'),
              onTap: () => {Navigator.pushNamed(context, '/annotation')},
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera_back_outlined),
              title: const Text('Image Recognition'),
              onTap: () => {Navigator.pushNamed(context, '/take/picture')},
            ),
            ListTile(
              leading: const Icon(Icons.fastfood_outlined),
              title: const Text('Meal Recording'),
              onTap: () => {Navigator.pushNamed(context, '/save/meal')},
            ),
          ],
        ),
      ),
    );
  }
}
