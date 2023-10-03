import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FeedbackData {
  final String studentName;
  final String categoryName;
  final int rating;
  final String createdAt;
  final String? message;
  FeedbackData({
    required this.studentName,
    required this.categoryName,
    required this.rating,
    required this.createdAt,
    this.message,
  });
}
class FeedbackListView extends StatelessWidget {
  final List<FeedbackData> feedbackList;
  const FeedbackListView({Key? key, required this.feedbackList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: feedbackList.length,
      itemBuilder: (BuildContext context, int index) {
        final feedback = feedbackList[index];
        final parsedDate = DateTime.parse(feedback.createdAt);
        final formattedDate = DateFormat('dd MMMM yyyy').format(parsedDate);
        return Column(
          children: [
            if (index == 0)
              Container(
                height: 40,
                width: 250,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 15,bottom: 15),
                decoration: BoxDecoration(border: Border.all(width: 1,)),
                child: Text(
                  formattedDate,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            if (index == 18)
              Container(
                height: 40,
                width: 250,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 15,bottom: 15),
                decoration: BoxDecoration(border: Border.all(width: 1,)),
                child: Text(
                  formattedDate,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ListTile(
              title: Text("Student: ${feedback.studentName}"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Category: ${feedback.categoryName}"),
                  Text("Rating: ${feedback.rating}"),
                  Text("Created At: $formattedDate"),
                  if (feedback.message != null) Text("Message: ${feedback.message}"),
                ],
              ),
            ),
            if (index < feedbackList.length - 1) const Divider(height: 30), // Add a divider for all but the last item
          ],
        );
      },
    );
  }
}