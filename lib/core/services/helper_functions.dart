class HelperFunctions {

  static String timeAgoFromDate(DateTime? date) {
    if (date == null) return 'just now'; 

    final diff = DateTime.now().difference(date);
    if (diff.inSeconds < 60) return '${diff.inSeconds} second${diff.inSeconds==1? '':'s'} ago';
    if (diff.inMinutes < 60) return '${diff.inMinutes} minute${diff.inMinutes==1? '':'s'} ago';
    if (diff.inHours < 24) return '${diff.inHours} hour${diff.inHours==1? '':'s'} ago';
    if (diff.inDays < 30) return '${diff.inDays} day${diff.inDays==1? '':'s'} ago';
    final months = (diff.inDays / 30).floor();
    if (months < 12) return '$months month${months==1? '':'s'} ago';
    final years = (diff.inDays / 365).floor();
    return '$years year${years==1? '':'s'} ago';
  }

  static double calculateAverageRating(Iterable<double> ratings) {
    if (ratings.isEmpty) return 0.0;
    final total = ratings.reduce((a, b) => a + b);
    return total / ratings.length;
  }

}