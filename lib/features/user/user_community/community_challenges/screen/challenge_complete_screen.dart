import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/utils/constants/app_texts.dart';
import 'package:gokul_ramk/core/utils/constants/imagepath.dart';
import 'package:gokul_ramk/features/user/user_community/community_challenges/widget/challenge_stat_card.dart';

class ChallengeCompleteScreen extends StatelessWidget {
  const ChallengeCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              spacing: 22,
              children: [
                Center(child: Image.asset(Imagepath.challengeComplete)),
                Text(AppTexts.challengeCompleteText, textAlign: TextAlign.center),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'You earned the Step Master Badge 🥇',
                      style: getTextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ChallengeStatCard(
                        title: 'Challenge Duration',
                        value: '30 Days',
                      ),
                    ),
                    Expanded(
                      child: ChallengeStatCard(
                        title: 'Completed Days',
                        value: '30/30',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ChallengeStatCard(
                        title: 'Calories Burned',
                        value: '12,450',
                      ),
                    ),
                    Expanded(
                      child: ChallengeStatCard(
                        title: 'Total Steps',
                        value: '300,000',
                      ),
                    ),
                  ],
                ),
            
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Share Achievement to Community Feed'),
                ),
            
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.withValues(alpha: 0.1),
                        ),
                        child: Text(
                          'Back to Community',
                          style: getTextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.withValues(alpha: 0.1),
                        ),
                        child: Text(
                          'Next Challenge',
                          style: getTextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
