import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GestionUtilisateurs(),
    );
  }
}

class GestionUtilisateurs extends StatefulWidget {
  @override
  _GestionUtilisateursState createState() => _GestionUtilisateursState();
}

class _GestionUtilisateursState extends State<GestionUtilisateurs> {
  final ApiService apiService = ApiService();
  late Future<List<dynamic>> utilisateurs;

  @override
  void initState() {
    super.initState();
    utilisateurs = apiService.fetchUtilisateurs();
  }

  final _nomController = TextEditingController();
  final _emailController = TextEditingController();
  final _telephoneController = TextEditingController();

  void _addUtilisateur() async {
    if (_nomController.text.isNotEmpty && _emailController.text.isNotEmpty && _telephoneController.text.isNotEmpty) {
      await apiService.addUtilisateur(
          _nomController.text, _emailController.text, _telephoneController.text);
      setState(() {
        utilisateurs = apiService.fetchUtilisateurs();
      });
      _nomController.clear();
      _emailController.clear();
      _telephoneController.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gestion des Utilisateurs')),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: utilisateurs,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erreur: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Aucun utilisateur trouvé.'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final user = snapshot.data![index];
                      return ListTile(
                        title: Text(user['nom']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user['email']),
                            Text(user['telephone']),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _nomController,
                  decoration: InputDecoration(labelText: 'Nom'),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _telephoneController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(labelText: 'Téléphone'),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _addUtilisateur,
                  child: Text('Ajouter un utilisateur'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}