import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../../core/theme/seven_manager_theme.dart';

class CheckData extends StatefulWidget {
  const CheckData({super.key});

  @override
  State<CheckData> createState() => _CheckDataState();
}

class _CheckDataState extends State<CheckData>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: SevenManagerTheme.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child:  Column(
                    children: [
                      const SizedBox(height: 10),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '4. Conferindo os dados',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: SevenManagerTheme.tealBlue,
                            fontSize: 26,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        color: SevenManagerTheme.lightCyan,
                        child: const Text(
                            ' SOBRE SEU ACESSO ',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: SevenManagerTheme.tealBlue,
                              fontSize: 20,
                            ),
                          ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        color: SevenManagerTheme.lightCyan,
                        child: const Text(
                            ' SOBRE VOCÊ ',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: SevenManagerTheme.tealBlue,
                              fontSize: 20,
                            ),
                          ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        color: SevenManagerTheme.lightCyan,
                        child: const Text(
                            ' SOBRE SUA IGREJA ',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: SevenManagerTheme.tealBlue,
                              fontSize: 20,
                            ),
                          ),
                      ),

                      
                        
                        
                      const SizedBox(height: 8),
                      const SizedBox(height: 16),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
