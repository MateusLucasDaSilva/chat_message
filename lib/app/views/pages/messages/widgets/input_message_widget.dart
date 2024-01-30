import 'package:flutter/material.dart';

class InputMessageWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final Function() onTapSend;
  const InputMessageWidget(
      {super.key,
      required this.textEditingController,
      required this.onTapSend});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: textEditingController,
          ),
        ),
        IconButton(onPressed: onTapSend, icon: const Icon(Icons.send_sharp))
      ],
    );
  }
}
