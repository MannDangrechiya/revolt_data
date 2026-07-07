import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../../core/theme/sizes.dart';
import '../../core/theme/theme_extension.dart';

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ConnectivityResult>>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        final isOffline = snapshot.data?.contains(ConnectivityResult.none) ?? false;
        
        if (!isOffline) return const SizedBox.shrink();

        return Container(
          width: double.infinity,
          color: context.colorScheme.errorContainer,
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.paddingSmall,
            horizontal: Sizes.paddingMedium,
          ),
          child: SafeArea(
            bottom: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wifi_off,
                  size: Sizes.iconSmall,
                  color: context.colorScheme.onErrorContainer,
                ),
                const SizedBox(width: Sizes.paddingSmall),
                Text(
                  "No internet connection",
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.colorScheme.onErrorContainer,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
