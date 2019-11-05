<?php

const TOKEN = '2b5e262a12bb56a341cf2411514c52930024a502d2aa4687b91b1a4050ab375b';
const AUTH_KEY_PATH = '/Users/juliobanda/Documents/AuthKey_Q3AN9RSTJ2.p8';
const AUTH_KEY_ID = 'Q3AN9RSTJ2';
const TEAM_ID = '8QRH5T43Y6';
const TOPIC = 'com.myPersonalTeam.Pruebas';

# ---- Shouldn't need any changes below this line ----

$payload = [
  'encrypted' => true,
  'aps'  => [
    'alert' => [
      'title' => str_rot13('Otter Spotted'),
      'body' => str_rot13('Come and see!')
    ],
    'badge' => 1,
    'mutable-content' => 1,
    'sound' => 'default',
  ],
  "media-url" => str_rot13('https://koenig-media.raywenderlich.com/uploads/2018/11/otter-badge-RW-250x250.png')
];

function generateAuthenticationHeader() {
    $header = base64_encode(json_encode(['alg' => 'ES256', 'kid' => AUTH_KEY_ID]));
    $claims = base64_encode(json_encode(['iss' => TEAM_ID, 'iat' => time()]));

    $pkey = openssl_pkey_get_private('file://' . AUTH_KEY_PATH);
    openssl_sign("$header.$claims", $signature, $pkey, 'sha256');

    $signed = base64_encode($signature);
    return "$header.$claims.$signed";
}

$ch = curl_init();
curl_setopt($ch, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_2_0);
curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($payload));
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_HTTPHEADER, [
  'apns-topic: ' . TOPIC,
  'Authorization: Bearer ' . generateAuthenticationHeader(),
]);

$url = 'https://api.development.push.apple.com/3/device/' . TOKEN;
curl_setopt($ch, CURLOPT_URL, "{$url}");

$response = curl_exec($ch);
if ($response === false) {
  echo "Failed to send push notification\n";
}

$code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
if ($code === 400) {
  $json = @json_decode($response);
  var_dump($json);
}

curl_close($ch);
