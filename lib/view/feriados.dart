import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Feriados extends StatefulWidget {
  @override
  _FeriadosState createState() => _FeriadosState();
}

class _FeriadosState extends State<Feriados> {
  final int ano = 2023;

    String _getInitials(String name) {
    List<String> nameParts = name.split(' ');
    String initials = '';
    for (var part in nameParts) {
      initials += part[0];
    }
    return initials.toUpperCase();
  }

  Future<List<Map<String, String>>> _getFeriados() async {
    final Uri uri = Uri.parse('https://brasilapi.com.br/api/feriados/v1/$ano');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      dynamic jsonResponse = json.decode(response.body);

      if (jsonResponse is List) {
        List<Map<String, String>> feriados = jsonResponse.map((json) {
          return {
            'name': json['name'].toString(),
            'date': json['date'].toString(),
            'type': json['type'].toString(),
          };
        }).toList();
        return feriados;
      } else {
        Map<String, String> feriado = {
          'name': jsonResponse['name'].toString(),
          'date': jsonResponse['date'].toString(),
          'type': jsonResponse['type'].toString(),
        };
        return [feriado];
      }
    } else {
      throw Exception('Falha ao carregar feriados');
    }
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feriados $ano'),
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: _getFeriados(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum feriado encontrado'));
          } else {
            List<Map<String, String>> feriados = snapshot.data!;

          return ListView.builder(
            itemCount: feriados.length,
            itemBuilder: (context, index) {
              String initials = _getInitials(feriados[index]['name'] ?? '');
              return ListTile(
                leading: CircleAvatar(
                  child: Text(initials),
                ),
                title: Text('Nome: ${feriados[index]['name']}'),
                subtitle: Text('Data: ${feriados[index]['date']}, Tipo: ${feriados[index]['type']}'),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
        
        },
      ),
    );
  }
}