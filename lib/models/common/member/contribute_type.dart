import 'package:ex_piliplus/http/api.dart';

enum ContributeType {
  video(Api.spaceArchive),
  charging(Api.spaceChargingArchive),
  season(Api.spaceSeason),
  series(Api.spaceSeries),
  bangumi(Api.spaceBangumi),
  comic(Api.spaceComic),
  ;

  final String api;
  const ContributeType(this.api);
}
