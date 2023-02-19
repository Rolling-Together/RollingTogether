class BusDto {
  final String? id;
  final String routeNum;
  final String carNum;
  final bool lift;
  final bool liftStatus;

  BusDto(
      {this.id,
      required this.routeNum,
      required this.carNum,
      required this.lift,
      required this.liftStatus});

  Map<String, dynamic> toMap() => {
        'routeNum': routeNum,
        'carNum': carNum,
        'lift': lift,
        'liftStatus': liftStatus
      };
}
