import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ccxgui/bloc/process_bloc/process_bloc.dart';
import 'package:ccxgui/utils/constants.dart';

class ListenOnUDPButton extends StatefulWidget {
  @override
  _ListenOnUDPButtonState createState() => _ListenOnUDPButtonState();
}

class _ListenOnUDPButtonState extends State<ListenOnUDPButton> {
  final List<DropdownMenuItem<String>> networkTypes = [
    DropdownMenuItem(
      value: 'udp',
      child: Text('udp'),
    ),
    DropdownMenuItem(
      value: 'tcp',
      child: Text('tcp'),
    ),
  ];
  String type = 'udp';
  final TextEditingController hostController =
      TextEditingController(text: '127.0.0.1');
  final TextEditingController portController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  String get compileLocationString {
    String _host =
        hostController.text.isNotEmpty ? hostController.text + ':' : '';
    return _host + portController.text;
  }

  bool _validatePort = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 20),
      child: InkWell(
        hoverColor: Colors.transparent,
        onTap: () => showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                  'Read the input on network (listening in the specified port)'),
              content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownButton<String>(
                            items: networkTypes,
                            isExpanded: true,
                            value: type,
                            onChanged: (String? newValue) {
                              setState(() {
                                type = newValue!;
                              });
                            },
                          ),
                          TextFormField(
                            controller: hostController,
                            decoration: InputDecoration(
                              hintText: 'Enter host here',
                              labelText: 'Host: ',
                              labelStyle: TextStyle(fontSize: 16),
                              hintStyle: TextStyle(height: 2),
                            ),
                          ),
                          TextFormField(
                            controller: portController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+(\.\d+)*$'),
                              ),
                            ],
                            autofocus: true,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Port cannot be empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter port here',
                              labelText: 'Port: ',
                              labelStyle: TextStyle(fontSize: 16),
                              hintStyle: TextStyle(height: 2),
                            ),
                          ),
                          if (type == 'tcp')
                            TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                hintText:
                                    'Server password for new connections to tcp server',
                                labelText: 'TCP password: ',
                                labelStyle: TextStyle(fontSize: 16),
                                hintStyle: TextStyle(height: 2),
                              ),
                            ),
                          if (type == 'tcp')
                            TextFormField(
                              controller: descController,
                              decoration: InputDecoration(
                                hintText:
                                    'Sends to the server short description about captiobs',
                                labelText: 'TCP description: ',
                                labelStyle: TextStyle(fontSize: 16),
                                hintStyle: TextStyle(height: 2),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16, right: 12),
                  child: MaterialButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<ProcessBloc>().add(
                              ProcessOnNetwork(
                                type: type,
                                location: compileLocationString,
                                tcpdesc: descController.text,
                                tcppassword: passwordController.text,
                              ),
                            );
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Start',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        child: Container(
          decoration: BoxDecoration(
            color: kBgLightColor,
            borderRadius: BorderRadius.all(
              Radius.circular(
                10,
              ),
            ),
          ),
          height: 75,
          child: Center(
            child: Text(
              'Listen on UDP',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
