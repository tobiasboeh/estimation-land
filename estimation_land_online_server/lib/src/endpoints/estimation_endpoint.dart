import 'package:estimation_land_online_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class EstimationEndpoint extends Endpoint {
  Future<List<Estimation>> giveEstimation(
      Session session, Estimation estimation) async {
    final existingEstimation = await Estimation.findSingleRow(
      session,
      where: (e) =>
          e.topic.equals(estimation.topic) & e.name.equals(estimation.name),
    );
    if (existingEstimation == null) {
      await Estimation.insert(session, estimation);
    } else {
      existingEstimation.storypoint = estimation.storypoint;
      await session.db.update(existingEstimation);
    }

    //return all estimations
    return await Estimation.find(
      session,
      where: (e) => e.topic.equals(estimation.topic),
    );
  }

  Future<List<Estimation>> getEstiations(
      Session session, String name, String storypoints, String topic) async {
    return await Estimation.find(session, where: (e) => e.topic.equals('game'));
  }
}
