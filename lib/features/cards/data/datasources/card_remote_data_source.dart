import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:famcards/core/constants/app_constants.dart';
import 'package:famcards/core/error/exceptions.dart';
import 'package:famcards/features/cards/data/models/contextual_card_model.dart';
import 'package:http/http.dart' as http;

abstract interface class CardRemoteDataSource {
  Future<List<ContextualCards>> getCards();
}

class CardRemoteDataSourceImpl implements CardRemoteDataSource {
  final http.Client client;

  CardRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ContextualCards>> getCards() async {
    try {
      final uri = Uri.parse(ApiConstants.baseUrl).replace(
        queryParameters: {'slugs': 'famx-paypage'},
      );

      final response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          throw const ServerException('Empty response received');
        }

        final List<dynamic> jsonDecodedData = json.decode(response.body);
        // log(jsonDecodedData.toString());
        log(jsonDecodedData.runtimeType.toString());
        return jsonDecodedData
            .map(
              (json) => ContextualCards.fromJson(json),
            )
            .toList();
      } else if (response.statusCode == 404) {
        throw const ServerException('Resource not found');
      } else if (response.statusCode >= 500) {
        throw ServerException('Server error: ${response.statusCode}');
      } else {
        throw ServerException(
            'HTTP ${response.statusCode}: ${response.reasonPhrase}');
      }
    } on ServerException catch (e) {
      throw ServerException(
        'Unexpected error: ${e.message})}',
      );
    } on TimeoutException {
      throw const ServerException(
        'Request timed out: Please make sure you have a stable internet connection',
      );
    } on http.ClientException {
      throw const ServerException(
        'Network error: Please check your internet connection',
      );
    } on FormatException catch (e) {
      throw ServerException(
        'Invalid JSON format: ${e.message}',
      );
    } catch (e, stackTrace) {
      log("Error: ${e.toString()}, stackTrace: $stackTrace");
      throw ServerException(
        'Unexpected error: ${e.toString() + stackTrace.toString()}',
      );
    }
  }
}
