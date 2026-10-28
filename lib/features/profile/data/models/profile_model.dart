import 'package:isar/isar.dart';

part 'profile_model.g.dart';

@collection
class ProfileModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late int userId;

  double? currentWeeklyMileage; // km per week

  String? targetRaceTime; // e.g., "3:30:00" or target finish time
  String? targetRaceType; // e.g., "full marathon", "half marathon"

  String? availableTrainingDays; // e.g., "3-4", description of available time

  String? injuryHistory; // text description of injury history

  String? dietaryPreferences; // e.g., "vegetarian", "omnivore"
  String? allergies; // allergies description

  String? trainingGoal; // personal goals

  DateTime createdAt = DateTime.now();

  DateTime updatedAt = DateTime.now();
}
