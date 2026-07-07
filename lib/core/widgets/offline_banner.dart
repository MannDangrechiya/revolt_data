import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ConnectivityResult>>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        final isOffline = snapshot.data != null && 
                          snapshot.data!.contains(ConnectivityResult.none) && 
                          snapshot.data!.length == 1;
        
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: isOffline ? 32.0 : 0.0,
          color: Theme.of(context).colorScheme.errorContainer,
          child: isOffline
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_off,
                      size: 16,
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'You are offline. Changes are saved locally.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}
