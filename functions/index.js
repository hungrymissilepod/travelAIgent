/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const { onRequest } = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");
const axios = require('axios');

const express = require('express');
const cors = require('cors')({ origin: true });
const app = express();

app.use(cors);

var baseUrl = 'https://duckduckgo.com/';

/// We need this to query DuckDuckGo initially to get a search token
function _parameters(query) {
  return { 'q': query };
}

/// Because I don't want to mess around with javascript too much I am literally going to
/// copy and paste this method 3 times - Jake

exports.fetchDuckImages1 = onRequest((request, response) => {
  logger.info('FetchDuckImages1');
  response.set('Access-Control-Allow-Origin', "*")
  response.set('Access-Control-Allow-Methods', 'GET, POST');

  /// Headers to be sent with image request
  var headers = {
    'authority': 'duckduckgo.com',
    'accept': 'application/json, text/javascript, */*; q=0.01',
    'sec-fetch-dest': 'empty',
    'x-requested-with': 'XMLHttpRequest',
    'user-agent':
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36',
    'sec-fetch-site': 'same-origin',
    'sec-fetch-mode': 'cors',
    'referer': 'https://duckduckgo.com/',
    'accept-language': 'en-US,en;q=0.9',
  };

  logger.info('parameters: ', request.query);
  var query = request.query.q;
  var parameters = _parameters(query);
  logger.info('my params: ', parameters);

  var size = request.query.size;
  var layout = request.query.layout;
  var type = request.query.type;
  logger.info('size: ', size);
  logger.info('layout: ', layout);
  logger.info('type: ', type);

  logger.info('requesting a token...');
  /// Request a token
  axios.get(baseUrl, { params: parameters }).then(function (res) {
    logger.info(res.data);
    /// The token we need to make requests to get images
    let matches = res.data.match(/vqd=([\d-]+)\&/im);
    const token = matches[1];
    logger.info('my token:', token);

    /// These filters specify what kind of images we will get
    const filters = `size:${size},type:${type},layout:${layout}`;
    logger.info('filters:', filters);

    /// Parameters specifing our [query], [token], and [filters]
    var params = {
      'l': 'us-en',
      'o': 'json',
      'q': query,
      'vqd': token,
      'f': filters,
      'p': '1',
      'v7exp': 'a',
    };

    logger.info('params:', params);

    /// Make a request to the DuckDuckGo image service
    var imageRequestUrl = `${baseUrl}i.js`;

    logger.info('imageRequestUrl:', imageRequestUrl);

    logger.info('requesting images...');
    axios.get(imageRequestUrl, { headers: headers, params: params, timeout: 10000 }).then(function (res) {
      logger.info(res.data);
      response.status(200).send(res.data);
      response.end();
    }).catch(function (err) {
      logger.error('failed to get images:', err);
    });
  }).catch(function (err) {
    logger.error('failed to get token:', err);
    response.sendStatus(500).end('Server Error');
  });
});

exports.fetchDuckImages2 = onRequest((request, response) => {
  logger.info('FetchDuckImages2');
  response.set('Access-Control-Allow-Origin', "*")
  response.set('Access-Control-Allow-Methods', 'GET, POST');

  /// Headers to be sent with image request
  var headers = {
    'authority': 'duckduckgo.com',
    'accept': 'application/json, text/javascript, */*; q=0.01',
    'sec-fetch-dest': 'empty',
    'x-requested-with': 'XMLHttpRequest',
    'user-agent':
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36',
    'sec-fetch-site': 'same-origin',
    'sec-fetch-mode': 'cors',
    'referer': 'https://duckduckgo.com/',
    'accept-language': 'en-US,en;q=0.9',
  };

  logger.info('parameters: ', request.query);
  var query = request.query.q;
  var parameters = _parameters(query);
  logger.info('my params: ', parameters);

  var size = request.query.size;
  var layout = request.query.layout;
  var type = request.query.type;
  logger.info('size: ', size);
  logger.info('layout: ', layout);
  logger.info('type: ', type);

  logger.info('requesting a token...');
  /// Request a token
  axios.get(baseUrl, { params: parameters }).then(function (res) {
    logger.info(res.data);
    /// The token we need to make requests to get images
    let matches = res.data.match(/vqd=([\d-]+)\&/im);
    const token = matches[1];
    logger.info('my token:', token);

    /// These filters specify what kind of images we will get
    const filters = `size:${size},type:${type},layout:${layout}`;
    logger.info('filters:', filters);

    /// Parameters specifing our [query], [token], and [filters]
    var params = {
      'l': 'us-en',
      'o': 'json',
      'q': query,
      'vqd': token,
      'f': filters,
      'p': '1',
      'v7exp': 'a',
    };

    logger.info('params:', params);

    /// Make a request to the DuckDuckGo image service
    var imageRequestUrl = `${baseUrl}i.js`;

    logger.info('imageRequestUrl:', imageRequestUrl);

    logger.info('requesting images...');
    axios.get(imageRequestUrl, { headers: headers, params: params, timeout: 10000 }).then(function (res) {
      logger.info(res.data);
      response.status(200).send(res.data);
      response.end();
    }).catch(function (err) {
      logger.error('failed to get images:', err);
    });
  }).catch(function (err) {
    logger.error('failed to get token:', err);
    response.sendStatus(500).end('Server Error');
  });
});

exports.fetchDuckImages3 = onRequest((request, response) => {
  logger.info('FetchDuckImages3');
  response.set('Access-Control-Allow-Origin', "*")
  response.set('Access-Control-Allow-Methods', 'GET, POST');

  /// Headers to be sent with image request
  var headers = {
    'authority': 'duckduckgo.com',
    'accept': 'application/json, text/javascript, */*; q=0.01',
    'sec-fetch-dest': 'empty',
    'x-requested-with': 'XMLHttpRequest',
    'user-agent':
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36',
    'sec-fetch-site': 'same-origin',
    'sec-fetch-mode': 'cors',
    'referer': 'https://duckduckgo.com/',
    'accept-language': 'en-US,en;q=0.9',
  };

  logger.info('parameters: ', request.query);
  var query = request.query.q;
  var parameters = _parameters(query);
  logger.info('my params: ', parameters);

  var size = request.query.size;
  var layout = request.query.layout;
  var type = request.query.type;
  logger.info('size: ', size);
  logger.info('layout: ', layout);
  logger.info('type: ', type);

  logger.info('requesting a token...');
  /// Request a token
  axios.get(baseUrl, { params: parameters }).then(function (res) {
    logger.info(res.data);
    /// The token we need to make requests to get images
    let matches = res.data.match(/vqd=([\d-]+)\&/im);
    const token = matches[1];
    logger.info('my token:', token);

    /// These filters specify what kind of images we will get
    const filters = `size:${size},type:${type},layout:${layout}`;
    logger.info('filters:', filters);

    /// Parameters specifing our [query], [token], and [filters]
    var params = {
      'l': 'us-en',
      'o': 'json',
      'q': query,
      'vqd': token,
      'f': filters,
      'p': '1',
      'v7exp': 'a',
    };

    logger.info('params:', params);

    /// Make a request to the DuckDuckGo image service
    var imageRequestUrl = `${baseUrl}i.js`;

    logger.info('imageRequestUrl:', imageRequestUrl);

    logger.info('requesting images...');
    axios.get(imageRequestUrl, { headers: headers, params: params, timeout: 10000 }).then(function (res) {
      logger.info(res.data);
      response.status(200).send(res.data);
      response.end();
    }).catch(function (err) {
      logger.error('failed to get images:', err);
    });
  }).catch(function (err) {
    logger.error('failed to get token:', err);
    response.sendStatus(500).end('Server Error');
  });
});

/// Method that calls ipinfo.io and returns with it's IP info
/// Useful for checking cloud functions ip address
exports.whereAmI = onRequest((request, response) => {
  logger.info('whereAmI');

  axios.get('https://ipinfo.io/json')
    .then(function (res) {
      logger.info(res.data);
      response.end(JSON.stringify(res.data));
    }).catch((err) => {
      response.end('Failed to look up IP');
    });
});
