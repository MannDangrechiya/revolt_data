import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:intl/intl.dart';

import '../data/battery_coach_provider.dart';
import '../data/ride_coach_provider.dart';
import '../data/charging_coach_provider.dart';
import '../data/maintenance_coach_provider.dart';
import '../data/range_prediction_provider.dart';
import '../domain/coach_tip.dart';
import '../../../shared/ui/volt_app_bar.dart';
import '../../../core/widgets/skeleton_loader.dart';
import '../../../shared/ui/error_widget.dart';
import '../../../core/widgets/fade_slide_in.dart';

class CoachesScreen extends HookConsumerWidget {
  const CoachesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final batteryCoachAsync = ref.watch(batteryCoachProvider);
    final rideCoachAsync = ref.watch(rideCoachProvider);
    final chargingCoachAsync = ref.watch(chargingCoachProvider);
    final maintenanceCoachAsync = ref.watch(maintenanceCoachProvider);
    final rangePredictionAsync = ref.watch(rangePredictionProvider);

    Future<void> refreshAll() async {
      ref.invalidate(batteryCoachProvider);
      ref.invalidate(rideCoachProvider);
      ref.invalidate(chargingCoachProvider);
      ref.invalidate(maintenanceCoachProvider);
      ref.invalidate(rangePredictionProvider);
    }

    return Scaffold(
      appBar: const VoltAppBar(
        title: 'AI Coaches & Intelligence',
      ),
      body: RefreshIndicator(
        onRefresh: refreshAll,
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          children: [
            const Text(
              'Personalized Insights',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Data-driven recommendations to optimize your battery, range, and ride efficiency.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 20),

            // Card 1: Range Prediction Prominent Card (Teal)
            FadeSlideIn(
              index: 0,
              child: _buildRangePredictionCard(context, rangePredictionAsync, ref),
            ),
            const SizedBox(height: 16),

            // Card 2: Battery Coach Card (Amber/Green)
            FadeSlideIn(
              index: 1,
              child: _buildBatteryCoachCard(context, batteryCoachAsync, ref),
            ),
            const SizedBox(height: 16),

            // Card 3: Ride Coach Card (Blue)
            FadeSlideIn(
              index: 2,
              child: _buildRideCoachCard(context, rideCoachAsync, ref),
            ),
            const SizedBox(height: 16),

            // Card 4: Charging Coach Card (Purple)
            FadeSlideIn(
              index: 3,
              child: _buildChargingCoachCard(context, chargingCoachAsync, ref),
            ),
            const SizedBox(height: 16),

            // Card 5: Maintenance Coach Card (Orange)
            FadeSlideIn(
              index: 4,
              child: _buildMaintenanceCoachCard(context, maintenanceCoachAsync, ref),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildRangePredictionCard(
    BuildContext context,
    AsyncValue<RangePrediction> asyncState,
    WidgetRef ref,
  ) {
    return asyncState.when(
      loading: () => const ListSkeletonLoader(itemCount: 1, itemHeight: 140),
      error: (err, stack) => VoltErrorWidget(
        message: err.toString(),
        onRetry: () => ref.refresh(rangePredictionProvider),
      ),
      data: (prediction) {
        final rangeText =
            '${prediction.lowEstimate.round()} - ${prediction.highEstimate.round()} km';
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.teal.shade800,
                Colors.teal.shade600,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.teal.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          LucideIcons.gauge,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Range Prediction',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${prediction.confidencePercent.round()}% Confidence',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                rangeText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Predicted real-world range based on weighted riding history & battery SoC',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Updated: ${DateFormat.jm().format(prediction.lastUpdated)}',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.65),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBatteryCoachCard(
    BuildContext context,
    AsyncValue<BatteryCoachTip> asyncState,
    WidgetRef ref,
  ) {
    return asyncState.when(
      loading: () => const ListSkeletonLoader(itemCount: 1, itemHeight: 120),
      error: (err, stack) => VoltErrorWidget(
        message: err.toString(),
        onRetry: () => ref.refresh(batteryCoachProvider),
      ),
      data: (tip) {
        final isWarning = tip.severity != CoachSeverity.info;
        final color = isWarning ? Colors.amber.shade700 : Colors.green;

        return _buildGenericCoachCard(
          context: context,
          title: 'Battery Coach',
          icon: LucideIcons.batteryCharging,
          tip: tip.tip,
          severity: tip.severity,
          confidence: tip.confidence,
          lastUpdated: tip.lastUpdated,
          cardColor: color,
        );
      },
    );
  }

  Widget _buildRideCoachCard(
    BuildContext context,
    AsyncValue<RideCoachTip> asyncState,
    WidgetRef ref,
  ) {
    return asyncState.when(
      loading: () => const ListSkeletonLoader(itemCount: 1, itemHeight: 120),
      error: (err, stack) => VoltErrorWidget(
        message: err.toString(),
        onRetry: () => ref.refresh(rideCoachProvider),
      ),
      data: (tip) {
        return _buildGenericCoachCard(
          context: context,
          title: 'Ride Coach',
          icon: LucideIcons.bike,
          tip: tip.tip,
          severity: tip.severity,
          confidence: tip.confidence,
          lastUpdated: tip.lastUpdated,
          cardColor: Colors.blue,
        );
      },
    );
  }

  Widget _buildChargingCoachCard(
    BuildContext context,
    AsyncValue<ChargingCoachTip> asyncState,
    WidgetRef ref,
  ) {
    return asyncState.when(
      loading: () => const ListSkeletonLoader(itemCount: 1, itemHeight: 120),
      error: (err, stack) => VoltErrorWidget(
        message: err.toString(),
        onRetry: () => ref.refresh(chargingCoachProvider),
      ),
      data: (tip) {
        return _buildGenericCoachCard(
          context: context,
          title: 'Charging Coach',
          icon: LucideIcons.zap,
          tip: tip.tip,
          severity: tip.severity,
          confidence: tip.confidence,
          lastUpdated: tip.lastUpdated,
          cardColor: Colors.purple,
        );
      },
    );
  }

  Widget _buildMaintenanceCoachCard(
    BuildContext context,
    AsyncValue<MaintenanceCoachTip> asyncState,
    WidgetRef ref,
  ) {
    return asyncState.when(
      loading: () => const ListSkeletonLoader(itemCount: 1, itemHeight: 120),
      error: (err, stack) => VoltErrorWidget(
        message: err.toString(),
        onRetry: () => ref.refresh(maintenanceCoachProvider),
      ),
      data: (tip) {
        return _buildGenericCoachCard(
          context: context,
          title: 'Maintenance Coach',
          icon: LucideIcons.wrench,
          tip: tip.tip,
          severity: tip.severity,
          confidence: tip.confidence,
          lastUpdated: tip.lastUpdated,
          cardColor: Colors.orange,
        );
      },
    );
  }

  Widget _buildGenericCoachCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required String tip,
    required CoachSeverity severity,
    required double confidence,
    required DateTime lastUpdated,
    required Color cardColor,
  }) {
    final severityLabel = severity == CoachSeverity.critical
        ? 'Critical'
        : severity == CoachSeverity.warning
            ? 'Warning'
            : 'Good';

    final badgeColor = severity == CoachSeverity.critical
        ? Colors.red
        : severity == CoachSeverity.warning
            ? Colors.orange
            : Colors.green;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: cardColor.withValues(alpha: 0.35),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: cardColor.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: cardColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(icon, color: cardColor, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: badgeColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      severityLabel,
                      style: TextStyle(
                        color: badgeColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${confidence.round()}% conf',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            tip,
            style: const TextStyle(
              fontSize: 14,
              height: 1.35,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Updated ${DateFormat.jm().format(lastUpdated)}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
                  fontSize: 11,
                ),
              ),
              Icon(
                LucideIcons.sparkles,
                size: 14,
                color: cardColor.withValues(alpha: 0.7),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
