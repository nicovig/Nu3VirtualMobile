import 'package:flutter/material.dart';

class DisconnectionDialog extends StatelessWidget {
  const DisconnectionDialog({
    Key? key,
    required this.handleOnPressedDisconnectButton,
  }) : super(key: key);

  final Function() handleOnPressedDisconnectButton;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(20),
      title: const Text('Déconnexion'),
      children: [
        const Text("Êtes vous sûr de vouloir vous déconnecter ?"),
        const SizedBox(height: 20),
        Row(
          children: [
            const Spacer(),
            ElevatedButton(
                onPressed: (() => handleOnPressedDisconnectButton()),
                child: const Text('Oui')),
            const Spacer(),
            ElevatedButton(
                onPressed: (() => Navigator.pop(context, true)),
                child: const Text('Non')),
            const Spacer()
          ],
        )
      ],
    );
  }
}
