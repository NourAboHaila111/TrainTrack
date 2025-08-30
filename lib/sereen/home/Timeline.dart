import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class InquiryTimeline extends StatelessWidget {
  final String currentStatus;

  InquiryTimeline({required this.currentStatus});

  final List<String> allSteps = [
    'opened',
    'assigned',
    'in progress',
    'replied',
    'closed',
  ];

  final Map<String, String> stepDescriptions = {
    'opened': 'The inquiry has been opened by the user.',
    'assigned': 'Assigned to the responsible employee.',
    'in progress': 'The inquiry is in progress.',
    'replied': 'The inquiry has been replied to.',
    'closed': 'The inquiry has been closed.',

  };

  @override
  Widget build(BuildContext context) {
    int currentStepIndex = allSteps.indexOf(currentStatus.toLowerCase());

    return SingleChildScrollView(
      child: Column(
        children: List.generate(allSteps.length, (index) {
          final step = allSteps[index];
          final isReached = index <= currentStepIndex;

          return TimelineTile(
            alignment: TimelineAlign.start,
            isFirst: index == 0,
            isLast: index == allSteps.length - 1,
            indicatorStyle: IndicatorStyle(
              width: 25,
              color: isReached ? Colors.blue : Colors.grey[400]!,
              iconStyle: IconStyle(
                iconData: isReached ? Icons.check_circle : Icons.radio_button_unchecked,
                color: Colors.white,
              ),
            ),
            beforeLineStyle: LineStyle(
              color: isReached ? Colors.blue : Colors.grey,
              thickness: 3,
            ),
            endChild: Container(
              margin: const EdgeInsets.only(left: 10, top: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step[0].toUpperCase() + step.substring(1),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: isReached ? FontWeight.bold : FontWeight.normal,
                      color: isReached ? Colors.black : Colors.grey,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    stepDescriptions[step] ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      color: isReached ? Colors.black87 : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
