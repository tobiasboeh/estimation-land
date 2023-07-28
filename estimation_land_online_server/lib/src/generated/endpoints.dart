/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/estimation_endpoint.dart' as _i2;
import 'package:estimation_land_online_server/src/generated/estimation.dart'
    as _i3;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'estimation': _i2.EstimationEndpoint()
        ..initialize(
          server,
          'estimation',
          null,
        )
    };
    connectors['estimation'] = _i1.EndpointConnector(
      name: 'estimation',
      endpoint: endpoints['estimation']!,
      methodConnectors: {
        'giveEstimation': _i1.MethodConnector(
          name: 'giveEstimation',
          params: {
            'estimation': _i1.ParameterDescription(
              name: 'estimation',
              type: _i1.getType<_i3.Estimation>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['estimation'] as _i2.EstimationEndpoint)
                  .giveEstimation(
            session,
            params['estimation'],
          ),
        ),
        'getEstiations': _i1.MethodConnector(
          name: 'getEstiations',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'storypoints': _i1.ParameterDescription(
              name: 'storypoints',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'topic': _i1.ParameterDescription(
              name: 'topic',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['estimation'] as _i2.EstimationEndpoint).getEstiations(
            session,
            params['name'],
            params['storypoints'],
            params['topic'],
          ),
        ),
      },
    );
  }
}
