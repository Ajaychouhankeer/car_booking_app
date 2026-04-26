abstract class AboutEvent {}

class FetchAbout extends AboutEvent {}

class FetchFaq extends AboutEvent {}

class SendContact extends AboutEvent {
  final Map<String, dynamic> body;

  SendContact(this.body);
}