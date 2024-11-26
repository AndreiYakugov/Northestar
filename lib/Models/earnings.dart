import 'rank.dart';

class Earnings {
  final int earnings_bonusId;
  final String earnings_adjamount;
  final String earnings_minus_amount;
  final String earnings_from;
  final String earnings_to;
  final String earnings_status;
  final Rank earnings_rank;

  Earnings({required this.earnings_bonusId, required this.earnings_adjamount, required this.earnings_minus_amount,
  required this.earnings_from, required this.earnings_to, required this.earnings_status, required this.earnings_rank});
}
