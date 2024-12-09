import 'dart:convert';

import 'package:biteblitz/src/common/providers/common_providers.dart';
import 'package:biteblitz/src/common/repo/restaurant_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class toggle_live_switch extends ConsumerStatefulWidget {
  toggle_live_switch();

  @override
  ConsumerState<toggle_live_switch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends ConsumerState<toggle_live_switch> {
  bool _isLoading = false; // Track if API is being processed

  Future<bool> _updateStatus(bool isOnline) async {
    final restaurantRepo = ref.watch(RestaurantRepoProvider);
    try {
      final response = await restaurantRepo.toggleLive(liveStatus: isOnline);
      final Map<String, dynamic> responseBody = json.decode(response!.body);

      if (response.statusCode == 200 && responseBody['success'] == true) {
        return true;
      } else {
        throw Exception('Failed to update status');
      }
    } catch (error) {
      print('API call failed: $error');
      return false;
    }
  }

  // Function to handle the switch toggle
  void _onToggleSwitch() async {
    setState(() {
      _isLoading = true; // Disable switch during API call
    });

    // Get current state from provider
    final currentStatus = ref.read(liveStatusProvider);

    // Optimistically update the state (switching it first)
    ref.read(liveStatusProvider.notifier).state = !currentStatus;

    // Make API call
    final success = await _updateStatus(!currentStatus);

    // Handle the response from API
    if (!success) {
      // Revert the state if API failed
      ref.read(liveStatusProvider.notifier).state = currentStatus;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update status.')),
      );
    }

    setState(() {
      _isLoading = false; // Re-enable switch after API call
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLive = ref.watch(liveStatusProvider);

    return GestureDetector(
      onTap: _isLoading ? null : _onToggleSwitch, // Disable tap if loading

      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isLive ? Colors.green : Colors.grey,
        ),
        child: Stack(
          children: [
            Positioned(
              left: isLive ? 12 : 40,
              top: 10,
              child: Text(
                isLive ? 'Online' : 'Offline',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: isLive ? 65 : 4,
              top: 4,
              // Adjusting the vertical alignment of the circle
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: Container(
                  key: ValueKey<bool>(isLive),
                  width: 32, // Reduced width of the circle
                  height: 32, // Reduced height of the circle
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
