import 'package:flutter/material.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                //borde superior
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color:colors.primary,
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
                  ),
                ),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/profile.jpg'),// Imagen de perfil
                    ),
                    SizedBox(height: 10),
                    Text("Jennifer Chileno Santisteban",
                      style: TextStyle(
                        fontSize: 22, 
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      )
                    ),
                    Text("Mi primer hola mundo",
                      style: TextStyle(
                        color: Colors.grey.shade200
                      )
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 20),

            // Sección de redes sociales
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _Profile(
                          icon: Icons.person_outline_outlined, 
                          label: 'Personal Settings'
                        ),
                        SizedBox(height: 20,),
                        _Profile(
                          icon: Icons.notifications_none, 
                          label: 'Notifications'
                        ),
                        SizedBox(height: 20,),
                        _Profile(
                          icon: Icons.language_outlined, 
                          label: 'Language'
                        ),
                        SizedBox(height: 20,),
                        _Profile(
                          icon: Icons.dark_mode, 
                          label: 'Dark Theme'
                        )
                      ],
                    )
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Profile extends StatelessWidget {

  final IconData icon;
  final VoidCallback? onPressed;
  final String label;

  const _Profile({required this.icon, this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
        return ListTile(
          onTap:(){},
          leading: Icon(
            icon,
            size: 35,
          ),
          title: Text(
            label,
            style: textStyles.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        );      
  }
}