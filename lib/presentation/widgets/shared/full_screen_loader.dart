import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages(){
    //Lista de mensajes
    final messages = <String>[
      'Cargando peliculas',
      'Cargando pelis populares',
      'Ya mismo se está cargando',
      'Cargando el primer hola mundo',
      'Esta demorando mas de lo esperado',
    ];

    return Stream.periodic(Duration(milliseconds: 1200), (step){
      return messages[step];
      //lo cancelamos con el tamaño de mensajes
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Espere por favor...'),
          SizedBox(height: 10,),
          CircularProgressIndicator(),
          SizedBox(height: 10,),
          StreamBuilder(
            stream: getLoadingMessages() , 
            builder: (context, snapshot) {
              //si no hay data
              if(!snapshot.hasData) return Text('Cargando');

              return Text(snapshot.data!);
            },
          )
        ],
      ),
    );
  }
}