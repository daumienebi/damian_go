import 'package:damian_go/ui/widgets/google_map_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        const GoogleMapWidget(),
        Positioned(
          top: 100,
          left: 15,
          right: 0,
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: TextButton.styleFrom(backgroundColor: Colors.white,shape: const StadiumBorder()),
                child: const Text('Countries',style: TextStyle(color: Colors.black87),),

              ),
              const SizedBox(width: 7),
              ElevatedButton(
                onPressed: () {},
                style: TextButton.styleFrom(backgroundColor: Colors.white,shape: const StadiumBorder()),
                child: const Text('Reduce zoom',style: TextStyle(color: Colors.black87),),
              ),
            ],
          ),
        ),
      ],
    );
  }
}